<cfcomponent output="false">

<cfproperty name="module_dsn" displayname="module_dsn" type="string" default="">
<cfproperty name="module_siteTitle" displayname="module_siteTitle" type="string" default="braddoro.com">
<cfproperty name="module_CSSfile" displayname="module_CSSfile" type="string" default="braddoro/braddoro.css">

<cffunction name="getCSSfile" access="public" output="false" returntype="string">
	<cfreturn module_CSSfile>
</cffunction>

<cffunction name="getSiteTitle" access="public" output="false" returntype="string">
	<cfreturn module_siteTitle>
</cffunction>

<!--- Begin Function  --->
<cffunction name="init" displayname="init" access="public" output="false">
	<cfargument required="true" type="string" name="dsn">

	<cfset module_dsn = arguments.dsn>
	<cfset module_siteTitle = "braddoro.com">
	<cfset module_CSSfile = "braddoro/braddoro.css">
	
	<cfreturn this>
</cffunction>
<!--- End Function  --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="showJavascript">
	<cfargument name="showDebug" type="boolean" default="false">
	<cfargument name="start" type="boolean" default="false">

	<cfset obj_application_display = createObject("component","application_display")>
	<cfsavecontent variable="s_showJavascript">
	<cfoutput>
		<cfif arguments.start>
			#obj_application_display.showJavascriptStart(showDebug=arguments.showDebug)#
		<cfelse>
			#obj_application_display.showJavascript(showDebug=arguments.showDebug)#
		</cfif>
		
	</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_showJavascript>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="banner">
	<cfargument name="userID" type="numeric" required="true">

	<cfset obj_user_logic = createObject("component","user_logic").init(dsn=module_dsn)>
	<cfset q_selectUserInfo = obj_user_logic.selectUserInfo(userID=arguments.userID)>
	<cfset lcl_siteName = q_selectUserInfo.siteName>
	<cfset obj_application_display = createObject("component","application_display")>
	<cfsavecontent variable="s_banner">
	<cfoutput>#obj_application_display.showBanner(siteName=lcl_siteName,siteTitle=module_siteTitle)#</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_banner>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="quote">

	<cfset obj_application_sql = createObject("component","application_sql").init(dsn=module_dsn)>
	<cfset q_getQuote = obj_application_sql.getQuote()>
	<cfset obj_application_display = createObject("component","application_display")>
	<cfsavecontent variable="s_quote">
	<cfoutput>#obj_application_display.showQuote(quoteQuery=q_getQuote)#</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_quote>
</cffunction>
<!--- End Function --->
	
<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="navMenu">
	<cfargument name="userID" type="numeric" default="1"> 
	
	<cfset obj_application_display = createObject("component","application_display")>
	<cfsavecontent variable="s_navMenu">
	<cfoutput>
	<cfoutput>#obj_application_display.showNavMenu(userID=arguments.userID)#</cfoutput>
	</cfoutput>
	</cfsavecontent>

	<cfreturn s_navMenu>
</cffunction>
<!--- End Function --->
	
</cfcomponent>