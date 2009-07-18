<html>
<head>
<title>Free Worlds Alliance Killmail History</title>
</head>
<body>
<cfset b_debug = false>
<cfset i_killmailID = 0>
<cfoutput>
<h4>Free Worlds Alliance Killboard Report</h4>
<cfinclude template="links.cfm">
</cfoutput>
<cfquery name="q_kills" datasource="braddoro">
SELECT system, count(*) as 'kills' 
FROM braddoro.dyn_killmail 
GROUP BY system 
ORDER BY count(*) DESC, system
</cfquery>
<cfoutput>
<table border='0' style='border-collapse:collapse;font-family:"Microsoft Sans Serif",Verdana,Arial;font-size:.75em;' cellspacing='0'>
<tr>
<td><strong>System</strong></td>
<td><strong>Name</strong></td>
<tr>
<cfloop query="q_kills">
	<tr>
	<td>#system#</td>
	<td>#kills#</td>
	<tr>
</cfloop>
</table>
</cfoutput>
</body>
</html>