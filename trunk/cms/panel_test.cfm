<!--- <cftry> --->
<cfset obj_utility = createObject("component","braddoro.utility.utility_logic").init(dsn=session.siteDsn)>
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title>braddoro.com</title>
<head>
<link href="braddoro/utility/braddoro.css" rel="stylesheet" type="text/css">
</head>
<body class="body">
<div id="div_left" class="divleft">
	<cfset obj_panel = createObject("component","common.panel_c")>
	<cfset s_sql = "SELECT U.userName, M.message FROM braddoro.dyn_messages M inner join dyn_Users U on M.from_userID = U.userID WHERE M.to_userID = 12 and M.readDate is null">
	<cfset q_related = obj_panel.runQuery(dsn=session.siteDsn,sql=s_sql)>
	<cfsavecontent variable="s_relatedHTML">
	<cfloop query="q_related">
		<strong>#userName#</strong><br>
		#message#<br>
		<cfif currentrow LT recordCount><hr></cfif>
	</cfloop>
	</cfsavecontent>
	#obj_panel.showPanel(
		uniqueName="asdf",
		headerBarText="Unread Messages (#q_related.recordCount#)",
		relatedHTML=s_relatedHTML,
		panelVisibility="none",
		panelHeight=50
		)#
	<!--- #obj_panel.showPanel(
		uniqueName=obj_utility.createString(),
		relatedHTML="sdv sdfgsfd gd",
		useFooter="Yes",
		footerHTML="<a href='http://braddoro.com'>braddoro</a>",
		headerBarText="zods (2)"
		)# --->
		
	<!--- #obj_panel.showPanel(
		uniqueName=obj_utility.createString(),
		useSearch="Yes",
		searchBarText="Search Something",
		searchHTML="<input type='text' size='25' value='search'>
				<select>
					<option value='0'>select an option</option>
					<option value='1'>option 1</option>
					<option value='1'>option 2</option>
				</select>
				<button value='go'>go</button>",
		relatedHTML="This is some foo. To display the text in the body.",
		headerBarText="searchy (3)"
		)# --->
		
	<!--- #obj_panel.showPanel(
		uniqueName=obj_utility.createString(),
		useSearch="Yes",
		searchBarText="Search Something",
		searchHTML="<input type='text' size='25' value='search'>
				<select>
					<option value='0'>select an option</option>
					<option value='1'>option 1</option>
					<option value='1'>option 2</option>
				</select>
				<button value='go'>go</button>",
		relatedBarText="Related Foo",
		relatedHTML="This is some foo. To display the text in the body.",
		useHistory="Yes",
		historyHTML="this is some history",
		historyBarText="history",
		headerBarText="all (4)",
		useFooter="Yes",
		footerHTML="<a href='http://braddoro.com'>braddoro</a>"
		)# --->
</div>
<br>
<div id="div_main" class="divright"></div>
<div id="div_bottom" align="center" class="divbottom">
#cgi.REMOTE_ADDR#
</div>
</body>
</html>
</cfoutput>