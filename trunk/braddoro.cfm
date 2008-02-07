<cflock timeout="20" type="exclusive" scope="Session">
	<cfif isdefined("cookie.userGUID")>
		<cfset session.userGUID = cookie.userGUID>
		<cfset session.siteName = "">
		<cfset session.userID = 1>
	<cfelse>
		<cfset session.userGUID = "DCDE6DFA-19B9-BA51-EE3FDC1D1A72E094">
		<cfset session.siteName = "">
		<cfset session.userID = 1>
	</cfif>
</cflock>
<cfset objBraddoro = createObject("component","braddoro_display").logic_Init(dsn="braddoro")>
<cfset session.userID = objBraddoro.logic_checkUser(session.userGUID).userID>
<cfset session.siteName = objBraddoro.logic_checkUser(session.userGUID).siteName>
<cfset x = objBraddoro.logic_setConstant(constantName="userID",constantValue=val(session.userID))>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title><cfoutput>#objBraddoro.logic_GetConstant("siteBanner")#</cfoutput></title>
<head>
<link href="braddoro/braddoro.css" rel="stylesheet" type="text/css">
<cfoutput>#objBraddoro.logic_javaScript(showDebug=false)#</cfoutput>
</head>
<cfoutput>
<body class="body">
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