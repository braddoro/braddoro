<cfcomponent output="false">

<cfproperty name="module_dsn" displayname="module_dsn" type="string" default="">

<cffunction name="init" displayname="init" access="public" output="false">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="getQuote">
	
	<cfquery name="q_getQuote" datasource="#module_dsn#">
		select quote, quoteby, quoteWhen from braddoro.cfg_quotes where active = 'Y' order by rand() limit 1
	</cfquery>
	<cfreturn q_getQuote>
</cffunction>
<!--- End Function --->

</cfcomponent>