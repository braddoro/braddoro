<cfcomponent output="false">

<!--- Begin Function --->
<cffunction name="init" displayname="init" access="package" output="false">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="checkUser">
	<cfargument name="userID" type="numeric" default="0">
	<cfargument name="userGUID" type="string" default="">
	<cfargument name="userName" type="string" default="">
	<cfargument name="password" type="string" default="">
	<cfargument name="remoteIP" type="string" default="">
	
	<cfsavecontent variable="_sql">
		<cfoutput>
	    select * 
	    from braddoro.dyn_Users 
	    where active = 'Y'
	<cfif arguments.userID GT 0>
		and userID = #arguments.userID#
	</cfif>
	<cfif arguments.userGUID NEQ "">
		and userGUID = '#arguments.userGUID#'
	</cfif>
	<cfif arguments.userName NEQ "">
		and userName = '#arguments.userName#'
		and password = '#arguments.password#'
	</cfif>
		limit 1
		</cfoutput>
	</cfsavecontent>
	<cfquery name="q_checkUser" datasource="#module_dsn#">#preserveSingleQuotes(_sql)#</cfquery>
	<cfset obj_error = createObject("component","braddoro.error.error_logic").init(dsn=session.siteDsn)>
	<cfset myArray = arrayNew(1)>
	<cfoutput>#obj_error.fail(userID=val(arguments.userID),message="sql query",detail=_sql,type="debugging",tagContext=myArray,remoteIP=cgi.REMOTE_ADDR,showOutput=false)#</cfoutput> 

	<cfquery name="q_insert" datasource="#module_dsn#">
		update braddoro.dyn_Users set lastVisit = now() where userID = #val(q_checkUser.userID)# 
	</cfquery>
	<cfif userName NEQ "" and val(q_checkUser.userID) LT 2>
	<cfquery name="q_insert2" datasource="#module_dsn#">
		insert into braddoro.log_loginHistory (remoteIP, userName) select '#arguments.remoteIP#', '#arguments.userName#' 
	</cfquery>
	</cfif>
	
	<cfreturn q_checkUser>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="insertUser">

	<cfsavecontent variable="_sql">
	<cfoutput>
		insert into braddoro.dyn_Users 
		(userGUID, userName, realName, siteName, password, emailAddress, webSite, dateOfBirth, zipCode, Active)
		select '#createUUID()#', '#arguments.userName#', '#arguments.realName#', '#arguments.siteName#', '#arguments.password#', '#arguments.emailAddress#', '#arguments.webSite#', '#dateformat(arguments.dateOfBirth,"yyyy-mm-dd")#', #val(arguments.zipCode)#, 'P'
	</cfoutput>
	</cfsavecontent>
	<cftry>
	<cfquery name="q_insertUser" datasource="#module_dsn#">#preserveSingleQuotes(_sql)#</cfquery>
	<cfcatch type="database">
		<cfset obj_error = createObject("component","error_logic").init(dsn=module_dsn)>
		<cfset x = obj_error.fail(
			userID=0,
			message=cfcatch.detail,
			detail=cfcatch.QueryError,
			type=cfcatch.Type,
			remoteIP=cgi.REMOTE_ADDR,
			showOutput=false	
			)>
	</cfcatch>
	</cftry>
	
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="updateUser">

	<cftry>
	<cfquery name="q_updateUser" datasource="#module_dsn#">
		update braddoro.dyn_Users set
		userName = '#left(arguments.userName,50)#',
		realName = '#left(arguments.realName,50)#',
		siteName = '#left(arguments.siteName,50)#',
		emailAddress = '#left(arguments.emailAddress,100)#',
		webSite = '#left(arguments.webSite,200)#',
	<cfif isdate(arguments.dateOfBirth)>
		dateOfBirth = '#dateformat(arguments.dateOfBirth,"yyyy-mm-dd")#',
	</cfif>
		zipCode = '#left(val(arguments.zipCode),5)#'
		where userID = #val(arguments.userID)#
	</cfquery>
	<cfcatch type="database">
		<cfset obj_error = createObject("component","error_logic").init(dsn=module_dsn)>
		<cfset x = obj_error.fail(
			userID=0,
			message=cfcatch.detail,
			detail=cfcatch.QueryError,
			type=cfcatch.Type,
			remoteIP=cgi.REMOTE_ADDR,
			showOutput=false	
			)>
	</cfcatch>
	</cftry>

</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="selectUserInfo">
	<cfargument name="userID" type="numeric" required="true">
  
	<cfquery name="q_selectUserInfo" datasource="#module_dsn#">
	select userID, userGUID, userName, realName, siteName, password, emailAddress, webSite, lastVisit, dateOfBirth, zipCode, Active from braddoro.dyn_Users where userID = #arguments.userID# limit 1 
	</cfquery>

	<cfreturn q_selectUserInfo>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="getUsers">
	
	<cfquery name="q_getUsers" datasource="#module_dsn#">
		select userID as 'value', siteName as 'display' from braddoro.dyn_users where active = 'Y' order by siteName 	
	</cfquery>

  <cfreturn q_getUsers>
</cffunction>
<!--- End Function --->

</cfcomponent>