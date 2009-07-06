<cfset s_pid = "">
<cfif isdefined("url.pid")>
			<cfset s_pid = url.pid>
<cfelse>
  <cfif isdefined("form.pid")>
	  <cfset s_pid = form.pid>
  </cfif>
</cfif>
<cfquery name="q_check" datasource="braddoro">
    select userID, userName 
    from braddoro.dyn_intel_users 
    where publicID = '#s_pid#'
    and active = 1
</cfquery>
<cfloop query="q_check">
  <cfset s_userName = userName>
  <cfset i_userID = userID>
</cfloop>
<cfif q_check.recordCount EQ 0 or s_pid EQ "">
  I don't know you.
  <cfabort>
</cfif>
<cfoutput>
<html>
<head>
<title>#s_pageName#</title>
</head>
<body>
<h4>#s_pageName# :: #s_userName#</h4>
</cfoutput>
<cfinclude template="links.cfm">