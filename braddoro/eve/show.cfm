<cfparam name="url.n" type="string" default="">
<html>
<head>
<title>Free Worlds Alliance Killmail Detail</title>
</head>
<body>
<h4>Free Worlds Alliance Killmail Detail</h4>
<cfquery name="q_kills" datasource="braddoro">
SELECT 
  	killmailText
FROM braddoro.dyn_killmail k1
INNER JOIN braddoro.dyn_killmail_text k2 
	ON k1.killmailID = k2.killmailID
WHERE k1.uniqueID = '#url.n#'
</cfquery>
<cfoutput query="q_kills">
	#replace(killmailText,chr(10),"<br>","All")#
</cfoutput>
</body>
</html>