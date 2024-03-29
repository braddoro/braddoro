<cftry>
<cfset obj_application = createObject("component","braddoro.application.application_logic").init(dsn=session.siteDsn)>
<cfset obj_quote = createObject("component","braddoro.quote.quote_logic").init(dsn=session.siteDsn)>
<cfset obj_post = createObject("component","braddoro.post.post_logic").init(dsn=session.siteDsn,userID=val(session.userID))>
<cfoutput>
#obj_application.javascriptTask()#
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title>braddoro.com</title>
<head>
<link href="braddoro/utility/braddoro.css" rel="stylesheet" type="text/css">
</head>
<body class="body">
<div id="div_top" class="divtop">
<fieldset>
<div id="div_banner" class="banner"><cfoutput><a href="#session.siteURL#" target="_top" style="text-decoration:none;">#obj_application.banner(userID=val(session.userID),siteTitle=session.siteTitle)#</a></cfoutput></div>
<div id="quote" title="click for another quote" style="cursor:default;" onclick="js_requestQuote('randomQuote','quote',0);">#obj_quote.randomQuote()#</div>
</fieldset>
</div>
<br>
<div id="div_main" class="divright">#obj_post.displayPosts(postID=val(url.n))#</div>
</body>
</html>
</cfoutput>
<cfcatch type="any">
	<cfset obj_error = createObject("component","braddoro.error.error_logic").init(dsn=session.siteDsn,userID=val(session.userID))>
	<cfoutput>#obj_error.fail(userID=val(session.userID),message=cfcatch.message,detail=cfcatch.detail,type=cfcatch.type,tagContext=cfcatch.tagContext,remoteIP=cgi.REMOTE_ADDR)#</cfoutput>
</cfcatch>
</cftry>