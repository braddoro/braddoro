<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction name="writeScripts" access="public" output="false" returntype="string">
	
	<cfset s_writeScripts = createObject("component","panel_v").writeScripts()>
	
	<cfreturn s_writeScripts>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction name="showPanel" access="public" output="false" returntype="string">
	<cfargument name="containerVisibility" type="string" default="">
	<cfargument name="useCustomHTML" 	type="string" default="No">
	<cfargument name="uniqueName" 		type="string" default="">
	<cfargument name="panelVisibility"	type="string" default="block">
	<cfargument name="panelHeight" 		type="numeric" default="0">
	<cfargument name="panelWidth" 		type="numeric" default="200">
	<cfargument name="headerBarText" 	type="string" default="">
	<cfargument name="searchBarText" 	type="string" default="">
	<cfargument name="relatedBarText" 	type="string" default="">
	<cfargument name="historyBarText"	type="string" default="">
	<cfargument name="useSearch" 		type="string" default="No">
	<cfargument name="useHistory" 		type="string" default="No">
	<cfargument name="useFooter" 		type="string" default="No">
	<cfargument name="searchHTML" 		type="string" default="">
	<cfargument name="historyHTML" 		type="string" default="">
	<cfargument name="footerHTML" 		type="string" default="">
	<cfargument name="writeScript" 		type="string" default="No">
	<cfargument name="useFieldSet" 		type="string" default="Yes">
		
	<cfset obj_display = createObject("component","panel_v")>
	<cfsavecontent variable="s_showPanel">
		<cfoutput>
			<cfif arguments.writeScript EQ "Yes">
			#this.writeScripts()#
			</cfif>
			#obj_display.panelMain(
				containerVisibility=arguments.containerVisibility,
				uniqueName=arguments.uniqueName,
				headerBarText=arguments.headerBarText, 
				panelVisibility=arguments.panelVisibility,
				panelHeight=arguments.panelHeight,
				panelWidth=arguments.panelWidth,

				relatedBarText=arguments.relatedBarText,
				relatedHTML=arguments.relatedHTML,

				useSearch=arguments.useSearch,
				searchBarText=arguments.searchBarText, 
				searchHTML=arguments.searchHTML,
				
				useHistory=arguments.useHistory,
				historyBarText=arguments.historyBarText, 
				historyHTML=arguments.historyHTML,
				
				useFooter=arguments.useFooter,
				footerHTML=arguments.footerHTML,
				useFieldSet=arguments.useFieldSet
				)#
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_showPanel>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction name="runQuery" access="public" output="false" returntype="query">
	<cfargument name="dsn" type="string" required="true">
	<cfargument name="SQL" type="string" required="true">
	
	<cfset q_runQuery = createObject("component","panel_m").runQuery(dsn=arguments.dsn,sql=arguments.sql)>
		
	<cfreturn q_runQuery>
</cffunction>
<!--- End Function --->

</cfcomponent>