<cfparam name="url.n" type="string" default="">
<html>
<head>
<title>Free Worlds Alliance Killmail Detail</title>
</head>
<body>
<cfoutput>
<h4>Free Worlds Alliance Killmail Detail</h4>
<cfquery name="q_kills" datasource="braddoro">
SELECT 
  	killmailText
FROM braddoro.dyn_killmail k1
INNER JOIN braddoro.dyn_killmail_text k2 
	ON k1.killmailID = k2.killmailID
WHERE k1.unique = '#url.n#'
</cfquery>
<cfoutput query="q_kills">
	#killmailText#
</cfoutput>
</body>
</html>