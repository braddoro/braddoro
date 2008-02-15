<cfcomponent output="false">

<cfproperty name="module_dsn" displayname="module_dsn" type="string" default="">
<cfproperty name="module_siteTitle" displayname="module_siteTitle" type="string" default="braddoro.com">

<cffunction name="getSiteTitle" access="package" output="false" returntype="string">
	<cfreturn module_siteTitle>
</cffunction>

<cffunction name="init" displayname="init" access="package" output="false">
	<cfargument required="true" type="string" name="dsn">
	<cfset module_dsn = arguments.dsn>
	<cfreturn this>
</cffunction>

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="fail">
	<cfargument name="userID" type="numeric" default="0">
	<cfargument name="message" type="string" default="">
	<cfargument name="detail" type="string" default="">
	<cfargument name="type" type="string" default="">
	<cfargument name="tagContext" type="Array" default="">
	<cfargument name="remoteIP" type="string" default="">
	<cfargument name="showOutput" type="boolean" default="true">

	<cfset obj_application_sql = createObject("component","error_sql").init(dsn=module_dsn)>
	<cfset x = obj_application_sql.fail(argumentCollection=arguments)>
	<cfif arguments.showOutput>
		<cfif arguments.remoteIP EQ "75.176.87.141" or arguments.userID EQ 12>
			<cfset lcl_showError = true>
		<cfelse>
			<cfset lcl_showError = false>
		</cfif>
		<cfset obj_error_display = createObject("component","error_display")>	
		<cfsavecontent variable="s_fail">
			<cfoutput>#obj_error_display.fail(message=arguments.message,detail=arguments.detail,type=arguments.type,tagContext=arguments.tagContext,showError=lcl_showError,remoteIP=arguments.remoteIP)#</cfoutput>
		</cfsavecontent>
	<cfelse>
		<cfset s_fail = "">	
	</cfif>	

	<cfreturn s_fail>
</cffunction>
<!--- End Function --->
	
</cfcomponent>