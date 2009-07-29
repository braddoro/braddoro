<cfcomponent output="false">
	<cffunction name="dropdown" access="public" output="false" returntype="String">
		<cfargument name="displayString" type="string" default="">
		<cfargument name="dropdownName" type="string" default="">
		<cfargument name="itemList" type="string" default="">
		<cfargument name="selectedValue" type="string" default="">
		<cfargument name="defaultOption" type="string" default="">
		<cfargument name="defaultValue" type="string" default="">
		
		<cfsavecontent variable="s_dropdown">
		<cfoutput>
		#arguments.displayString#<select id="#arguments.dropdownName#" name="#arguments.dropdownName#">
		<option value="#arguments.defaultValue#">#arguments.defaultOption#</option>
		<cfloop list="#arguments.itemList#" index="s_current">
			<option value="#s_current#"<cfif arguments.selectedValue EQ s_current> SELECTED</cfif>>#s_current#</option>
		</cfloop>
		</select>
		</cfoutput>
		</cfsavecontent>
		
		<cfreturn s_dropdown>
	</cffunction>

	<cffunction name="dropdownQuery" access="public" output="false" returntype="String">
		<cfargument name="displayString" type="string" default="">
		<cfargument name="dropdownName" type="string" default="">
		<cfargument name="dataQuery" type="query" required="true">
		<cfargument name="selectedValue" type="string" default="">
		<cfargument name="defaultOption" type="string" default="">
		<cfargument name="defaultValue" type="string" default="">
		
		<cfsavecontent variable="s_dropdown">
		<cfoutput>
		#arguments.displayString#<select id="#arguments.dropdownName#" name="#arguments.dropdownName#">
		<option value="#arguments.defaultValue#">#arguments.defaultOption#</option>
		<cfloop query="arguments.dataQuery">
			<option value="#value#"<cfif not compare(arguments.selectedValue,value)> SELECTED</cfif>>#display#</option>
		</cfloop>
		</select>
		</cfoutput>
		</cfsavecontent>
		
		<cfreturn s_dropdown>
	</cffunction></cfcomponent>