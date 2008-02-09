<cfset session.siteDsn="braddoro">
<cftry>
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

<cflock timeout="20" type="exclusive" scope="Session">
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
<cfset obj_user = createObject("component","user_logic").init(dsn=session.siteDsn)>
<cfset session.userID = obj_user.authenticateUser(userID=val(session.userGUID)).userID>
<cfset session.siteName = obj_user.authenticateUser(userID=val(session.userGUID)).siteName>
<cfset objBraddoro = createObject("component","braddoro_display").logic_Init(dsn=session.siteDsn)>
<cfset x = objBraddoro.logic_setConstant(constantName="userID",constantValue=val(session.userID))>
<div id="div_top" class="divtop">
<fieldset>
<div id="div_banner" class="banner"><cfoutput>#objBraddoro.display_showBanner(siteName=session.siteName)#</cfoutput></div>
<div id="quote">#objBraddoro.logic_getQuote()#</div>
<div id="menu">#objBraddoro.logic_navMenu(userID=val(session.userID))#</div>
</fieldset>
</div>
<div id="div_main" class="divright">#objBraddoro.logic_displayPosts(numberToGet=objBraddoro.logic_GetConstant("postsToShow"))#</div>
</cfoutput>
</body>
</html>
<cfcatch type="any">
	<cfset obj_error = createObject("component","error_logic")>
	<cfoutput>#obj_error.fail(message=cfcatch.message,detail=cfcatch.detail)#</cfoutput>
</cfcatch>
</cftry>