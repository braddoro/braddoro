<cfcomponent displayname="user_logic.cfc" output="false">

<cfproperty name="module_dsn" displayname="module_dsn" type="string" default="">

<cffunction name="init" displayname="init" access="public" output="false">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="logIn">
	<cfargument name="userGUID" type="string" required="true">
	
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
	
</cfcomponent>