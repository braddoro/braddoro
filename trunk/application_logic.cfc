<cfcomponent displayname="application_logic" output="false">

<cfproperty name="module_dsn" displayname="module_dsn" type="string" default="">
<cfproperty name="module_siteTitle" displayname="module_siteTitle" type="string" default="braddoro.com">
<cfproperty name="module_CSSfile" displayname="module_CSSfile" type="string" default="braddoro/braddoro.css">

<cffunction name="getCSSfile" access="public" output="false" returntype="string">
	<cfreturn module_CSSfile>
</cffunction>

<cffunction name="getSiteTitle" access="public" output="false" returntype="string">
	<cfreturn module_siteTitle>
</cffunction>

<cffunction name="init" displayname="init" access="public" output="false">
	<cfargument required="true" type="string" name="dsn">

	<cfset module_dsn = arguments.dsn>
	<cfset module_siteTitle = "braddoro.com">
	<cfset module_CSSfile = "braddoro/braddoro.css">
	
	<cfreturn this>
</cffunction>

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="showJavascript">
	<cfargument name="showDebug" type="boolean" default="false">

	<cfset obj_application_display = createObject("component","application_display")>
	<cfsavecontent variable="s_showJavascript">
	<cfoutput>
		#obj_application_display.showJavascript(showDebug=arguments.showDebug)#
	</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_showJavascript>
</cffunction>
<!--- End Function --->
	
</cfcomponent>