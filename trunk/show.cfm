<cftry>
<cfset obj_post = createObject("component","braddoro.post.post_logic").init(dsn=session.siteDsn,userID=val(session.userID))>
<cfoutput>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title>braddoro.com</title>
<head>
<link href="braddoro/utility/braddoro.css" rel="stylesheet" type="text/css">
</head>
<body class="body">
<div id="div_main" class="divright">#obj_post.getSearch(postID=val(url.n))#</div>
</body>
</html>
</cfoutput>
<cfcatch type="any">
	<cfset obj_error = createObject("component","error.error_logic").init(dsn=session.siteDsn,userID=val(session.userID))>
	<cfoutput>#obj_error.fail(userID=val(session.userID),message=cfcatch.message,detail=cfcatch.detail,type=cfcatch.type,tagContext=cfcatch.tagContext,remoteIP=cgi.REMOTE_ADDR)#</cfoutput>
</cfcatch>
</cftry>