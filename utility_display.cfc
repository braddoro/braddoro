<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction name="init" displayname="init" access="package" output="false">

	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="queryDropdown">
<cfargument name="selectName" type="string" default="topicID">
<cfargument name="dataQuery" type="query" required="true">
<cfargument name="currentID" type="numeric" default="0">

	<cfsavecontent variable="s_queryDropdown">
		<cfoutput>
			<SELECT name="#arguments.selectName#" id="#arguments.selectName#">
			<option value="0"<cfif arguments.currentID EQ 0> SELECTED</cfif></option>
			<cfloop query="arguments.dataQuery">
				<option value="#value#"<cfif val(value) EQ val(arguments.currentID)> SELECTED</cfif>>#display#</option>
			</cfloop>
			</SELECT>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_queryDropdown>
</cffunction>
<!--- End Function --->

</cfcomponent>