<cfcomponent displayname="user_sql.cfc" output="false">

<cfproperty name="module_dsn" displayname="module_dsn" type="string" default="">

<!--- Begin Function --->
<cffunction name="init" displayname="init" access="public" output="false">
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
	
	<cfquery name="q_checkUser" datasource="#module_dsn#">
	    select * from braddoro.dyn_Users where 
		active = 'Y'
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
	 </cfquery>
	 
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
<cffunction access="package" output="false" returntype="query" name="insertUser">

	<cfquery name="q_insertUser" datasource="#module_dsn#">
	insert into braddoro.dyn_Users 
	(userGUID, userName, realName, siteName, password, emailAddress, webSite, dateOfBirth, zipCode)
	select '#createUUID#', '#arguments.userName#', '#arguments.realName#', '#arguments.siteName#', '#arguments.password#', '#arguments.emailAddress#', '#arguments.webSite#', '#arguments.dateOfBirth#', '#arguments.zipCode#'
	select last_insert_id() as 'newID'
	 </cfquery>

	<cfreturn q_insertUser>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="updateUser">

	<cfquery name="q_updateUser" datasource="#module_dsn#">
	update braddoro.dyn_Users set
	userName = '#arguments.userName#',
	realName = '#arguments.realName#',
	siteName = '#arguments.siteName#',
	emailAddress = '#arguments.emailAddress#',
	webSite = '#arguments.webSite#',
	dateOfBirth = '#dateformat(arguments.dateOfBirth,"yyyy-mm-dd")#',
	zipCode = '#arguments.zipCode#'
	where userID = #val(arguments.userID)#
	</cfquery>

</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="selectUserInfo">
	<cfargument name="userID" type="numeric" required="true">
  
	<cfquery name="q_selectUserInfo" datasource="#module_dsn#">
	select userID, userGUID, userName, realName, siteName, password, emailAddress, webSite, lastVisit, dateOfBirth, zipCode, Active from braddoro.dyn_Users where userID = #arguments.userID# 
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