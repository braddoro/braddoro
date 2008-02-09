<cftry>
<cflock timeout="20" type="exclusive" scope="Session">
	<cfset session.siteDsn="braddoro">
	<cfset session.postsToShow=20>
	<cfif isdefined("cookie.userGUID")>
		<cfset session.userGUID = cookie.userGUID>
		<cfset session.siteName = "Anon Y. Mous">
		<cfset session.userID = 1>
	<cfelse>
		<cfset session.userGUID = "DCDE6DFA-19B9-BA51-EE3FDC1D1A72E094">
		<cfset session.siteName = "Anon Y. Mous">
		<cfset session.userID = 1>
	</cfif>
</cflock>
<cfset obj_application = createObject("component","application_logic").init(dsn=session.siteDsn)>
<cfoutput>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title>#obj_application.getSiteTitle()#</title>
<head>
<link href="#obj_application.getCSSfile()#" rel="stylesheet" type="text/css">
#obj_application.showJavascript(showDebug=false)#
</head>
<body class="body">
<cfset obj_user = createObject("component","user_logic").init(dsn=session.siteDsn)>
<cfset q_authenticateUser = obj_user.authenticateUser(userGUID=session.userGUID)>
<cfset session.userID = q_authenticateUser.userID>
<cfset session.siteName = q_authenticateUser.siteName>

<div id="div_top" class="divtop">
<fieldset>
<div id="div_banner" class="banner"><cfoutput>#obj_application.banner(userID=val(session.userID))#</cfoutput></div>
<div id="quote">#obj_application.Quote()#</div>
<div id="menu">#obj_application.navMenu(userID=val(session.userID))#</div>
</fieldset>
</div>
<cfset obj_content = createObject("component","content_logic").Init(dsn=session.siteDsn)>
<div id="div_main" class="divright">#obj_content.displayPosts(numberToGet=val(session.postsToShow),userID=val(session.userID))#</div>
</cfoutput>
</body>
</html>
<cfcatch type="any">
	<cfset obj_error = createObject("component","error_logic")>
	<cfoutput>#obj_error.fail(message=cfcatch.message,detail=cfcatch.detail,tagContext=cfcatch.tagContext,remoteIP=cgi.REMOTE_ADDR)#</cfoutput>
</cfcatch>
</cftry>