<cfcomponent displayname="user_sql.cfc" output="false">

<!--- <cffunction name="getDsn" access="public" output="false" returntype="string">
	<cfreturn module_dsn />
</cffunction> --->

<!--- <cffunction name="setDsn" access="public" output="false" returntype="void">
	<cfargument name="dsn" type="string" required="true" />
	<cfset module_dsn = arguments.dsn />
	<cfreturn />
</cffunction> --->

<cfproperty name="module_dsn" displayname="module_dsn" type="string" default="">

<cffunction name="init" displayname="init" access="public" output="false">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>

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
	(userGUID, userName, realName, siteName, password, emailAddress, webSite)
	select '#createUUID#', '#arguments.realName#', '#arguments.siteName#', '#arguments.password#', '#arguments.emailAddress#', '#arguments.webSite#'
	select last_insert_id() as 'newID'
  </cfquery>

	<cfreturn q_insertUser>
</cffunction>
<!--- End Function --->

</cfcomponent>