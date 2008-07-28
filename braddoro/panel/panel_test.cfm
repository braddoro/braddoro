<!--- <cftry> --->
<cfset obj_panel = createObject("component","panel_logic").init(dsn=session.siteDsn)>
<cfset obj_utility = createObject("component","braddoro.utility.utility_logic").init(dsn=session.siteDsn)>
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title>braddoro.com</title>
<head>
<link href="braddoro/utility/braddoro.css" rel="stylesheet" type="text/css">
#obj_panel.writeScripts()#
</head>
<body class="body">
<div id="div_left" class="divleft">
	#obj_panel.showPanel(
		uniqueString=obj_utility.createString(),
		headerBarText="Simple Panel (1)",
		relatedHTML="This is some foo. To display the text in the body."
		)#

	<!--- #obj_panel.showPanel(
		relatedHTML="sdv sdfgsfd gd",
		useFooter="Yes",
		footerHTML="<a href='http://braddoro.com'>braddoro</a>",
		headerBarText="zods (2)"
		)# --->
	<!--- #obj_panel.showPanel(
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
	#obj_panel.showPanel(
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
		)#
</div>
<br>
<div id="div_main" class="divright"></div>
<div id="div_bottom" align="center" class="divbottom">
#cgi.REMOTE_ADDR#
</div>
</body>
</html>
</cfoutput>