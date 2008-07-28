<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction access="public" name="init" output="false">
	<cfargument required="false" type="string" name="dsn">
		
	<cfset variables.dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction name="writeScripts" access="public" output="false" returntype="string">
	
	<cfset obj_display = createObject("component","panel_display").init()>
	<cfsavecontent variable="s_writeScripts">
		<cfoutput>#obj_display.writeScripts()#</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_writeScripts>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction name="showRelatedPanels" access="public" output="false">
	
	<!--- configuration lookupie stuff --->
	
	<!--- logicky stuff --->
	<cfif arguments.useCustomHTML EQ "Yes">
		lcl_relatedHTML = display.buildCustomHTML()
	<cfelse>
		lcl_relatedHTML = display.buildRelatedHTML()
	</cfif>
	
	<!--- showie stuff --->
	<cfsavecontent variable="s_showRelatedPanels">
		<cfoutput>
			#display.panelMain(arguments=lots,relatedHTML=lcl_relatedHTML)#
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_showRelatedPanels>
</cffunction>
<!--- End Function --->


<!--- Begin Function  --->
<cffunction name="showPanel" access="public" output="false">
	<cfargument name="useCustomHTML" type="string" default="No">
	<cfargument name="uniqueName" type="string" default="">
	<cfargument name="headerBarText" type="string" default="">
	<cfargument name="searchBarText" type="string" default="">
	<cfargument name="relatedBarText" type="string" default="">
	<cfargument name="historyBarText" type="string" default="">
	<cfargument name="useSearch" type="string" default="No">
	<cfargument name="useHistory" type="string" default="No">
	<cfargument name="useFooter" type="string" default="No">
	<cfargument name="searchHTML" type="string" default="">
	<cfargument name="historyHTML" type="string" default="">
	<cfargument name="footerHTML" type="string" default="">
	
	<cfif arguments.useCustomHTML EQ "Yes">
		lcl_relatedHTML = display.buildCustomHTML()
	<cfelse>
		lcl_relatedHTML = display.buildRelatedHTML()
	</cfif>
	
	<cfset obj_display = createObject("component","panel_display").init()>
	<cfsavecontent variable="s_showPanel">
		<cfoutput>
			#arguments.uniqueName#
			#obj_display.panelMain(
				uniqueName=arguments.uniqueName,
				headerBarText=arguments.headerBarText, 

				relatedBarText=arguments.relatedBarText,
				relatedHTML=arguments.relatedHTML,
				
				useSearch=arguments.useSearch,
				searchBarText=arguments.searchBarText, 
				searchHTML=arguments.searchHTML,
				
				useHistory=arguments.useHistory,
				historyBarText=arguments.historyBarText, 
				historyHTML=arguments.historyHTML,
				
				useFooter=arguments.useFooter,
				footerHTML=arguments.footerHTML
				)#
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_showPanel>
</cffunction>
<!--- End Function --->

</cfcomponent>