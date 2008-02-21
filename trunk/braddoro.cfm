<cftry>
<cflock timeout="20" type="exclusive" scope="Session">
	<cfset session.siteDsn="braddoro">
	<cfset session.postsToShow=20>
	<cfif isdefined("cookie.userGUID")>
		<cfset session.userGUID = cookie.userGUID>
	<cfelse>
		<cfset session.userGUID = "none">
	</cfif>
</cflock>
<cfset obj_application = createObject("component","application_logic").init(dsn=session.siteDsn)>
<cfset obj_user = createObject("component","user.user_logic").init(dsn=session.siteDsn)>
<cfset q_authenticateUser = obj_user.authenticateUser(userGUID=session.userGUID)>
<cfset session.userID = q_authenticateUser.userID>
<cfset session.siteName = q_authenticateUser.siteName>
<cfset session.userGUID = q_authenticateUser.userGUID>
<cfcookie expires="never" name="userGUID" value="#q_authenticateUser.userGUID#">
<cfoutput>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title>#obj_application.getSiteTitle()#</title>
<head>
<link href="#obj_application.getCSSfile()#" rel="stylesheet" type="text/css">
<div id="js_div">#obj_application.showJavascript(showDebug=false)#</div>
</head>
<body class="body">
<div id="div_top" class="divtop">
<fieldset>
<div id="div_banner" class="banner"><cfoutput>#obj_application.banner(userID=val(session.userID))#</cfoutput></div>
<cfset obj_quote_logic = createObject("component","braddoro.quote.quote_logic").init(dsn=session.siteDsn)>
#obj_quote_logic.javascriptTask()#
<div id="quote" title="click for another quote" style="cursor:default;" onclick="js_requestQuote('randomQuote','quote',0);">#obj_quote_logic.randomQuote()#</div>
<div id="menu">#obj_application.navMenu(userID=val(session.userID))#</div>
</fieldset>
</div>
<cfset obj_post_logic = createObject("component","braddoro.post.post_logic").init(dsn=session.siteDsn,userID=session.userID)>
#obj_post_logic.javascriptTask()#
<div id="div_main" class="divright">#obj_post_logic.displayPosts()#</div>
</cfoutput>
</body>
</html>
<cfcatch type="any">
	<cfset obj_error = createObject("component","error.error_logic").init(dsn=session.siteDsn,userID=session.userID)>
	<cfoutput>#obj_error.fail(userID=val(session.userID),message=cfcatch.message,detail=cfcatch.detail,type=cfcatch.type,tagContext=cfcatch.tagContext,remoteIP=cgi.REMOTE_ADDR)#</cfoutput>
</cfcatch>
</cftry>