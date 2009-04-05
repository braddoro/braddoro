<cftry>
<cfset obj_application =	createObject("component","braddoro.application.application_logic").init(dsn=session.siteDsn)>
<cfset obj_message = 		createObject("component","braddoro.message.message_logic").init(dsn=session.siteDsn,userID=Val(session.userID))>
<cfset obj_utility = 		createObject("component","braddoro.utility.utility_logic").init(dsn=session.siteDsn)>
<cfset obj_quote = 			createObject("component","braddoro.quote.quote_logic").init(dsn=session.siteDsn)>
<cfset obj_error = 			createObject("component","error.error_logic").init(dsn=session.siteDsn)>
<cfset obj_user = 			createObject("component","braddoro.user.user_logic").init(dsn=session.siteDsn)>
<cfset obj_post = 			createObject("component","braddoro.post.post_logic").init(dsn=session.siteDsn,userID=Val(session.userID))>
<cfset obj_date = 			createObject("component","braddoro.date.date_logic").init(dsn=session.siteDsn,userID=Val(session.userID))>
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title>braddoro.com</title>
<head>
<link href="braddoro/braddoro.css" rel="stylesheet" type="text/css">
<link rel="alternate" type="application/rss+xml" title="braddoro rss feed" href="http://braddoro.com/braddoro/rss.cfm" />
</head>
<body class="body">
<div id="div_top" class="divtop">
<fieldset>
<div id="div_banner" class="banner"><cfoutput>#obj_application.banner(userID=val(session.userID),siteTitle=session.siteTitle)#</cfoutput></div>
<div id="quote" title="click for another quote" style="cursor:default;" onclick="js_requestQuote('randomQuote','quote',0);">#obj_quote.randomQuote()#</div>
<div id="menu">#obj_application.navMenu(userID=val(session.userID))#</div>
</fieldset>
</div>
<div id="div_date" class="divinfo">#obj_date.showDates()#</div>
<table border="0">
<tr>
<td valign="top">
<!--- 
<div id="div_left" class="divleft">
<cfset obj_panel = createObject("component","braddoro.panel.panel_logic")>
<cfset s_sql = "SELECT U.userName, M.message 
		FROM braddoro.dyn_messages M 
		inner join dyn_Users U 
		on M.from_userID = U.userID 
		WHERE M.to_userID = #val(session.userID)# 
		and M.readDate is null
		order by sentDate desc">
<cfset q_related = obj_panel.runQuery(dsn=session.siteDsn,sql=s_sql)>
<cfsavecontent variable="s_relatedHTML">
<cfloop query="q_related">
	<strong>#userName#</strong><br>
	#message#<br>
	<cfif currentrow LT recordCount><hr></cfif>
</cfloop>
</cfsavecontent>
#obj_panel.showPanel(
	uniqueName=obj_utility.createString(),
	headerBarText="Unread Messages (#q_related.recordCount#)",
	relatedHTML=s_relatedHTML,
	panelVisibility="block",
	containerVisibility="block",
	panelHeight=100,
	containerWidth=100,
	writeScript="Yes"
	)#
<cfset s_sql = "SELECT lastVisit, userName FROM dyn_users order by lastVisit desc limit 3">
<cfset q_related = obj_panel.runQuery(dsn=session.siteDsn,sql=s_sql)>
<cfsavecontent variable="s_relatedHTML">
<cfloop query="q_related">
	<strong>#userName#: </strong>#dateFormat(lastVisit,"mm/dd/yyyy")#<br>
	<cfif currentrow LT recordCount><hr></cfif>
</cfloop>
</cfsavecontent>
#obj_panel.showPanel(
	uniqueName=obj_utility.createString(),
	headerBarText="Last Logins",
	relatedHTML=s_relatedHTML,
	panelVisibility="block",
	containerVisibility="block",
	panelHeight=75,
	containerWidth=100
	)#
</div>
--->
</td>
<td>
<div id="div_main" class="divright">#obj_post.displayPosts()#</div>
</td>
</tr>
</table>
#obj_application.javascriptTask()#
#obj_message.javascriptTask()#
#obj_quote.javascriptTask()#
#obj_error.javascriptTask()#
#obj_user.javascriptTask()#
#obj_post.javascriptTask()#
#obj_date.javascriptTask()#
</div>
<div id="div_bottom" align="center" class="divbottom">
#cgi.REMOTE_ADDR#
</div>
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