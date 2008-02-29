<cfcomponent output="false">

<cffunction access="public" output="false" returntype="any" name="init">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>

<!--- Begin Function --->
<cffunction access="public" output="false" returntype="string" name="javascriptTask">
	
	<cfsavecontent variable="s_javascript">
		<cfoutput>
<script type="text/javascript" src="/braddoro/user/user.js"></script>
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_javascript>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="string" name="ajaxTask">
	<cfargument required="true" type="string" name="task">
	
	<cfsavecontent variable="s_ajaxTask">
		<cfoutput>
<cfif arguments.task EQ "authenticateUser">
	<cfset q_authenticateUser = this.authenticateUser(username=arguments.userName,password=arguments.password,remoteIP=cgi.REMOTE_ADDR)>
	<cfset session.userID = q_authenticateUser.userID>
	<cfset session.siteName = q_authenticateUser.siteName>
	<cfset cookie.userGUID = q_authenticateUser.userGUID>
	
	<cfset obj_post_logic = createObject("component","post_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_post_logic.displayPosts(numberToGet=val(session.postsToShow),userID=val(session.userID))#</cfoutput>
	</cfsavecontent>
</cfif>
<cfif arguments.task EQ "logIn">#this.logIn()#</cfif>
<cfif arguments.task EQ "showUserInfo">#this.showUser(userID=session.userID)#</cfif>
<cfif arguments.task EQ "register">#this.showUser(userID=0)#</cfif>
<cfif arguments.task EQ "saveUserInfo">
	<cfset x = this.saveUserInfo(argumentCollection=form)>
	#this.showUser(userID=session.userID)#
</cfif>
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_ajaxTask>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="logIn">
	
	<cfset obj_user_display = createObject("component","user_display")>
	<cfsavecontent variable="s_logIn">
	<cfoutput>#obj_user_display.showLogin()#</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_logIn>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="query" name="authenticateUser">
	<cfargument name="userID" type="numeric" default="0">
	<cfargument name="userGUID" type="string" default="">
	<cfargument name="username" type="string" default="">
	<cfargument name="password" type="string" default="">
	<cfargument name="remoteIP" type="string" default="">

	<cfset obj_user_sql = createObject("component","user_sql").init(dsn=module_dsn)>
	<cfset q_authenticateUser = obj_user_sql.checkUser(userID=arguments.userID,userGUID=arguments.userGUID,userName=arguments.userName,password=arguments.password,remoteIP=arguments.remoteIP)>

	<cfreturn q_authenticateUser>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="query" name="selectUserInfo">
	<cfargument name="userID" type="numeric" default="0">

	<cfset obj_user_sql = createObject("component","user_sql").init(dsn=module_dsn)>
	<cfset q_selectUserInfo = obj_user_sql.selectUserInfo(userID=arguments.userID)>

	<cfreturn q_selectUserInfo>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="showUser">
	<cfargument name="userID" type="numeric" default="0">

	<cfset obj_user_sql = createObject("component","user_sql").init(dsn=module_dsn)>
	<cfset q_selectUserInfo = obj_user_sql.selectUserInfo(userID=arguments.userID)>
	<cfset obj_user_display = createObject("component","user_display")>
	<cfif arguments.userID EQ 0>
		<cfset lcl_legend = "site registration">
	<cfelse>
		<cfset lcl_legend = "user info">
	</cfif>
	<cfsavecontent variable="s_showUser">
		<cfoutput>#obj_user_display.showUserInput(userQuery=q_selectUserInfo,legend=lcl_legend)#</cfoutput>
	</cfsavecontent>

	<cfreturn s_showUser>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="void" name="saveUserInfo">

	<cfset obj_user_sql = createObject("component","user_sql").init(dsn=module_dsn)>
	<cfif arguments.userID EQ 0>
		<cfset x = obj_user_sql.insertUser(argumentCollection=arguments)>
	<cfelse>
		<cfset x = obj_user_sql.updateUser(argumentCollection=arguments)>
	</cfif>
	
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="query" name="getUserList">

	<cfset obj_user_sql = createObject("component","user_sql").init(dsn=module_dsn)>
	<cfset q_getUserList = obj_user_sql.getUsers()>	

	<cfreturn q_getUserList>	
</cffunction>
<!--- End Function --->  
	
</cfcomponent>