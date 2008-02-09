<cfcomponent displayname="error_logic" output="false">

<cfproperty name="module_dsn" displayname="module_dsn" type="string" default="">
<cfproperty name="module_siteTitle" displayname="module_siteTitle" type="string" default="braddoro.com">

<cffunction name="getSiteTitle" access="public" output="false" returntype="string">
	<cfreturn module_siteTitle>
</cffunction>

<cffunction name="init" displayname="init" access="public" output="false">
	<cfargument required="true" type="string" name="dsn">
	<cfset module_dsn = arguments.dsn>
	<cfreturn this>
</cffunction>

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="fail">
	<cfargument name="message" type="string" default="">
	<cfargument name="detail" type="string" default="">

	<!--- <cfset obj_application_sql = createObject("component","application_sql")> --->
	<!--- <cfset x = obj_application_sql.fail(message=arguments.message,detail=arguments.detail)> --->
	<cfset obj_error_display = createObject("component","error_display")>	
	<cfsavecontent variable="s_fail">
	<cfoutput>#obj_error_display.fail(message=arguments.message,detail=arguments.detail)#</cfoutput>
	</cfsavecontent>	

	<cfreturn s_fail>
</cffunction>
<!--- End Function --->
	
</cfcomponent>