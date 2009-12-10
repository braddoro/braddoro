
<cfcomponent>

<cffunction name="setScope" access="public" output="false" returntype="String">
	<cfargument name="myvar" type="String" required="true">
	
	<cfset arguments.myvar = "">
	<cfif isdefined("url.#arguments.myvar#")>
		<cfset s_retval = url.system>
	<cfelse>
	  <cfif isdefined("form.#arguments.myvar#")>
		  <cfset s_retval = form.system>
	  </cfif>
	</cfif>	
	
	<cfreturn retval>
</cffunction>

</cfcomponent>