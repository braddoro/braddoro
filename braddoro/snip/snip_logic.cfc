<cfcomponent output="false">

	<!--- Begin Function  --->
	<cffunction name="input" access="package" output="false" returntype="string">
		<cfargument name="snippetID" type="numeric" default="0">
	
		<cfset objThis_sql = createObject("component","snip_sql")>
		<cfset q_get = objThis_sql.get(snippetID=arguments.snippetID)>
		<cfset q_category = objThis_sql.category()>	
		<cfset s_input = createObject("component","snip_display").input(dataQuery=q_get,categoryQuery=q_category)>
		
		<cfreturn s_input>
	</cffunction>
	<!--- End Function --->
	
	<!--- Begin Function  --->
	<cffunction name="output" access="package" output="false" returntype="string">
		<cfargument name="snippetID" type="numeric" default="0">
	
		<cfset q_get = createObject("component","snip_sql").get(snippetID=arguments.snippetID)>
		<cfset s_output = createObject("component","snip_display").output(dataQuery=q_get)>
		
		<cfreturn s_output>
	</cffunction>
	<!--- End Function --->
	
	<!--- Begin Function  --->
	<cffunction name="task" access="package" output="false" returntype="string">
		<cfargument name="snippetID" type="numeric" default="0">	
		<cfargument name="task" type="string" default="">
		
		<cfset objThis_sql = createObject("component","snip_sql")>
	
		<cfswitch expression = "#arguments.task#">
			<cfcase value="edit">
				<cfset s_task = this.input(snippetID=val(arguments.snippetID))>
			</cfcase>
	
			<cfcase value="save">
				<cfif val(arguments.snippetID) GT 0>
					 <cfset objThis_sql.updateRow(argumentCollection=arguments)>
				<cfelse>
					<cfset objThis_sql.insertRow(argumentCollection=arguments)>
				</cfif>
				<cfset q_get = objThis_sql.get(snippetID=0)>
				<cfset s_task = createObject("component","snip_display").output(dataQuery=q_get)>
			</cfcase>
		
			<cfdefaultcase>
				<cfset s_task = "">
			</cfdefaultcase>
		</cfswitch>
		
		<cfreturn s_task>
	</cffunction>
	<!--- End Function --->

</cfcomponent>