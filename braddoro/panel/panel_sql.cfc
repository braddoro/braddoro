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

</cfcomponent>