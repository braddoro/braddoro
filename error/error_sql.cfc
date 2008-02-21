<cfcomponent output="false">

<!--- Begin Function --->
<cffunction name="init" displayname="init" access="package" output="false">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="fail">
	<cfargument name="userID" type="numeric" default="0">
	<cfargument name="message" type="string" default="">
	<cfargument name="detail" type="string" default="">
	<cfargument name="type" type="string" default="">
	<cfargument name="tagContext" type="Array" default="">
	<cfargument name="remoteIP" type="string" default="false">

	<cfquery name="q_fail" datasource="#module_dsn#">
    insert into braddoro.log_errors (userID, remoteIP, type, message, detail)
	select #arguments.userID#, '#arguments.remoteIP#', '#arguments.type#', '#arguments.message#', '#arguments.detail#'
	</cfquery>

</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="showErrors">
	<cfargument name="numberToGet" type="numeric" default="20">

	<cfquery name="q_showErrors" datasource="#module_dsn#">
    select userID, remoteIP, type, message, detail, addedDate from braddoro.log_errors order by errorID desc limit #arguments.numberToGet#
	</cfquery>

	<cfreturn q_showErrors>
</cffunction>
<!--- End Function --->

</cfcomponent>