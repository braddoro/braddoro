<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction access="public" name="init" output="false">
	<cfargument required="true" type="string" name="dsn">
	<cfargument required="true" type="numeric" name="userID">
		
	<cfset module_dsn = arguments.dsn>
	<cfset module_userID = arguments.userID>
	
	<cfreturn this>
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


</cfcomponent>