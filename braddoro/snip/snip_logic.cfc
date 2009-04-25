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

			<cfcase value="show">
				<cfset q_get = objThis_sql.get(snippetID=0)>
				<cfset s_task = createObject("component","snip_display").output(dataQuery=q_get)>
			</cfcase>
		
			<cfcase value="exportXML">
				<cfset s_task = this.exportXML(snippetID=76)>
			</cfcase>

			<cfdefaultcase>
				<cfset s_task = "">
			</cfdefaultcase>
		</cfswitch>
		
		<cfreturn s_task>
	</cffunction>
	<!--- End Function --->

	<!--- Begin Function  --->
	<cffunction name="exportXML" access="package" output="false" returntype="string">
		<cfargument name="snippetID" type="numeric" default="0">
		<cfargument name="targetDir" type="string" default="">
	
			<!---
			http://www.brooks-bilson.com/blogs/rob/index.cfm/2006/11/30/Converting-HomeSite--Snippets-to-CFEclipse-Snippets-with-ColdFusion
			1. read snippets directory recursively
			2. read .hss and .hse files - these contain the snippet text
			3. create folders in eclipse snippet directory
			4. wrap the snippet text in xml (eclipse snippet format). Name of snippet is filename from homesite
			5. write out xml files in eclipse snippets directory
			--->
			<!--- set homesite and eclipse snippet base directories --->
			<cfset s_targetDir = "~\snippets\">
		    <!--- <cfif not directoryExists("snippets")>
		        <cfdirectory action="CREATE" directory="snippets">
		    </cfif>--->

			<cfset q_get = createObject("component","snip_sql").get(snippetID=arguments.snippetID)>
			
			<!--- loop over each directory, creating the same thing on the eclipse side --->
			<cfoutput query="q_get" group="category">
			    <!--- <cfif not directoryExists("#targetDir##category#")>
			        <cfdirectory action="CREATE" directory="#targetDir##category#">
			    </cfif>--->
			    <cfoutput>
					<!--- create the xml for each eclipse version of the snippet --->
					<cfsavecontent variable="s_targetSnippet"><?xml version="1.0" encoding="utf-8"?>
					<snippet filetemplate="false" extension="cfm">
					<name>#snip_name#</name>
					<help>#snip_help#</help>
					<starttext><![CDATA[#HTMLCodeFormat(snippetStart)#]]></starttext>
					<endtext><![CDATA[#HTMLCodeFormat(snippetEnd)#]]></endtext>
					</snippet></cfsavecontent>
					<!--- write out each file on the eclipse side --->
					<!--- <cffile action="WRITE" file="#snip_name#.xml" output="#s_targetSnippet#" mode="777"> --->
			    </cfoutput>
			</cfoutput>
		
		<cfreturn s_targetSnippet>	
	</cffunction>
	<!--- End Function --->
	
</cfcomponent>