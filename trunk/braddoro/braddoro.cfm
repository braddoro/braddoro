<cftry>
<cfset obj_application = CreateObject("component","braddoro.application.application_logic").init(dsn=session.siteDsn)>
<cfset obj_message = CreateObject("component","braddoro.message.message_logic").init(dsn=session.siteDsn,userID=Val(session.userID))>
<cfset obj_quote = CreateObject("component","braddoro.quote.quote_logic").init(dsn=session.siteDsn)>
<cfset obj_error = CreateObject("component","error.error_logic").init(dsn=session.siteDsn)>
<cfset obj_user = CreateObject("component","braddoro.user.user_logic").init(dsn=session.siteDsn)>
<cfset obj_post = CreateObject("component","braddoro.post.post_logic").init(dsn=session.siteDsn,userID=Val(session.userID))>
<cfset obj_date = CreateObject("component","braddoro.date.date_logic").init(dsn=session.siteDsn,userID=Val(session.userID))>
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title>braddoro.com</title>
<head>
<link href="braddoro/utility/braddoro.css" rel="stylesheet" type="text/css">
<link rel="alternate" type="application/rss+xml" title="braddoro rss feed" href="http://braddoro.com/braddoro/rss.cfm" />
</head>
<!-- BEGIN: google tracking -->
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-4903214-1";
urchinTracker();
</script>
<!-- END: google tracking -->
<body class="body">
<div id="div_top" class="divtop">
<fieldset>
<div id="div_banner" class="banner"><cfoutput>#obj_application.banner(userID=val(session.userID),siteTitle=session.siteTitle)#</cfoutput></div>
<div id="quote" title="click for another quote" style="cursor:default;" onclick="js_requestQuote('randomQuote','quote',0);">#obj_quote.randomQuote()#</div>
<div id="menu">#obj_application.navMenu(userID=val(session.userID))#</div>
</fieldset>
</div>
<div id="div_date" class="divright">#obj_date.showDates()#</div>
<br>
<div id="div_main" class="divright">#obj_post.displayPosts()#</div>
#obj_application.javascriptTask()#
#obj_message.javascriptTask()#
#obj_quote.javascriptTask()#
#obj_error.javascriptTask()#
#obj_user.javascriptTask()#
#obj_post.javascriptTask()#
#obj_date.javascriptTask()#
</body>
</html>
</cfoutput>
<cfcatch type="any">
	<cfif IsDefined("session.userID")>
		<cfset lcl_userID = Val(session.userID)>
	<cfelse>
		<cfset lcl_userID = 0>
	</cfif>
	<cfset obj_error = CreateObject("component","error.error_logic").init(dsn=session.siteDsn,userID=Val(session.userID))>
	<cfoutput>#obj_error.fail(userID=lcl_userID,message=cfcatch.message,detail=cfcatch.detail,type=cfcatch.type,tagContext=cfcatch.tagContext,remoteIP=cgi.REMOTE_ADDR)#</cfoutput>
</cfcatch>
</cftry>