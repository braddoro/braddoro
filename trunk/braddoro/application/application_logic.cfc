<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction name="init" displayname="init" access="public" output="false">
	<cfargument required="true" type="string" name="dsn">

	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>
<!--- End Function  --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="javascriptTask">

	<cfsavecontent variable="s_javascriptTask">
		<cfoutput>
<script type="text/javascript" src="/braddoro/application/application.js"></script>
<script type="text/javascript" src="/braddoro/user/md5.js"></script>
<script type="text/javascript" src="/braddoro/utility/ajax.js"></script>
<script type="text/javascript" src="/braddoro/utility/utility.js"></script>
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_javascriptTask>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="string" name="ajaxTask">
	<cfargument required="true" type="string" name="task">
	<cfargument required="true" type="numeric" name="userID">
	
	<cfsavecontent variable="s_ajaxTask">
		<cfoutput>
		<cfif form.task EQ "showBanner">#this.banner(userID=arguments.userID,siteTitle="braddoro.com")#</cfif>
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_ajaxTask>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="banner">
	<cfargument name="userID" type="numeric" required="true">
	<cfargument name="siteTitle" type="string" required="true">

	<cfset obj_user_logic = createObject("component","braddoro.user.user_logic").init(dsn=module_dsn)>
	<cfset lcl_siteName = obj_user_logic.selectUserInfo(userID=arguments.userID).siteName>
	<cfset obj_application_display = createObject("component","application_display")>
	<cfsavecontent variable="s_banner">
	<cfoutput>#obj_application_display.showBanner(siteName=lcl_siteName,siteTitle=arguments.siteTitle)#</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_banner>
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