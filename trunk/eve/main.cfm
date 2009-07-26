<cfparam name="s_pageName" default="FWA">
<cfparam name="form.field1" default="">
<cfparam name="form.field2" default="">
<cfif form.field1 NEQ "" and form.field2 NEQ ""> 
	<cfquery name="q_query" datasource="braddoro">
		select publicID, userID, userName, loginName 
		from braddoro.dyn_intel_users 
		where loginName = '#form.field1#'
		and password = '#form.field2#'
		and active = 1
	</cfquery>
	<cfif q_query.recordcount GT 0>
		<cflocation url="menu.cfm?pid=#q_query.publicID#" addToken="No">
	</cfif>
</cfif>
<cfoutput>
<html>
<head>
<title>#s_pageName#</title>
</head>
<body>
<h4>#s_pageName#</h4><br>
<cfif form.field1 EQ "">
	<form id="myform" name="myform" action="main.cfm" method="post">
	<input type="text" id="field1" name="field1" value=""><br>
	<input type="password" id="field2" name="field2" value=""><br>
	<input type="submit" id="go" name="go" value="Go">
	</form>
</cfif>
</cfoutput>
</body>
</html>