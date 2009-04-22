<cfcomponent output="false">

	<!--- Begin Function --->
	<cffunction name="category" access="package" output="false" returntype="query">
	
		<cfquery name="q_category" datasource="braddoro">
		select distinct category  
		from braddoro.dyn_snippet_library
		where active = 'Yes'
		order by category
		</cfquery>
	
	  <cfreturn q_category>
	</cffunction>
	<!--- End Function --->
	
	<!--- Begin Function --->
	<cffunction name="get" access="package" output="false" returntype="query">
		<cfargument name="snippetID" type="numeric" default="0">
	
		<cfquery name="q_get" datasource="braddoro">
		select snippetID, category, title, snippet, active 
		from braddoro.dyn_snippet_library
		where active = 'Yes'
	<cfif arguments.snippetID NEQ 0>
		and snippetID = #arguments.snippetID#
	</cfif>
		order by category, title
		</cfquery>
	
	  <cfreturn q_get>
	</cffunction>
	<!--- End Function --->
	
	<!--- Begin Function --->
	<cffunction name="insertRow" access="package" output="false" returntype="void">
	
		<cfquery name="q_insertRow" datasource="braddoro">
		insert into braddoro.dyn_snippet_library (category, title, snippet, active)
		select '#arguments.category#', '#arguments.title#', '#arguments.snippet#', 'Yes'  
		</cfquery>
		
	</cffunction>
	<!--- End Function --->
	
	<!--- Begin Function --->
	<cffunction name="updateRow" access="package" output="false" returntype="void">
		<cfargument name="snippetID" type="numeric" default="0">
		
		<cfquery name="q_insertRow" datasource="braddoro">
		update braddoro.dyn_snippet_library set
		category = '#arguments.category#',
		title = '#arguments.title#', 
		snippet = '#arguments.snippet#'
		where snippetID = #val(arguments.snippetID)#
		</cfquery>
		
	</cffunction>
	<!--- End Function --->

</cfcomponent>