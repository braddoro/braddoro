<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title><cfoutput>#objBraddoro.logic_GetConstant("siteBanner")#</cfoutput></title>
<head>
<link href="braddoro.css" rel="stylesheet" type="text/css">
<cfoutput>#objBraddoro.logic_javaScript(showDebug=true)#</cfoutput>
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