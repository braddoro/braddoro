<cfcomponent displayname="error_sql" output="false">

<cfproperty name="module_dsn" displayname="module_dsn" type="string" default="">

<cffunction name="init" displayname="init" access="public" output="false">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>

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

</cfcomponent>