<cfparam name="s_pageName" default="FWA Intel - Sighting Ad Hoc Query">

<cfinclude template="head.cfm">
<!--- Begin Page Content --->
<cfoutput>

<cfparam name="form.sql" default="">
<form id="myform" name="myform" action="query.cfm" method="post">
<input type="hidden" id="pid" name="pid" value="#s_pid#"><br>
<textarea id=="sql" name="sql" rows="20" cols="80">#preserveSingleQuotes(form.sql)#</textarea><br>
<input type="submit" id="go" name="go" value="Go">
</form>
<cfset s_list = "CURSOR,DATABASE,DATABASES,DECLARE,DEFAULT,DELETE,DROP,GRANT,PROCEDURE,PURGE,REPLACE,REVOKE,TABLE,TERMINATED">
<cfset b_validSQL = true>
<cfloop from="1" to="#listLen(s_list)#" index="s_index">
				<cfif form.sql CONTAINS listGetAt(s_list,s_index)>
								<cfset b_validSQL = false>
				</cfif>
</cfloop>
<cfif form.sql neq "" and b_validSQL>
			<cfquery name="q_query" datasource="braddoro">#preserveSingleQuotes(form.sql)#</cfquery>
</cfif>
<cfif isdefined("q_query")>
			<cfdump var="#q_query#">
</cfif>
<cfif not b_validSQL>
			Invalid reserved words.
</cfif>
</body>
</html>
</cfoutput>
<!--- End Page Content --->
<cfinclude template="foot.cfm">