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
<link href="eve.css" rel="stylesheet" type="text/css" media="screen">
<title>#s_pageName#</title>
</head>
<body class="base">
<div class="title">#s_pageName# :: #s_userName#</div>
</cfoutput>
<cfinclude template="links.cfm">