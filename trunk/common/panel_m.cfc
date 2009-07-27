<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction access="package" name="runQuery" output="false" returntype="query">
	<cfargument name="dsn" type="string" required="true">
	<cfargument name="SQL" type="string" required="true">
		
	<cfquery datasource="#arguments.dsn#" name="q_runQuery">#preserveSingleQuotes(arguments.SQL)#</cfquery>
	
	<cfreturn q_runQuery>
</cffunction>
<!--- End Function --->

</cfcomponent>