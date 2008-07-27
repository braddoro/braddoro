<!--- <cftry> --->
<cfset obj_panel = CreateObject("component","panel_logic").init(dsn=session.siteDsn)>
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title>braddoro.com</title>
<head>
<link href="braddoro/utility/braddoro.css" rel="stylesheet" type="text/css">
</head>
<body class="body">
<div id="div_left" class="divleft">
	#obj_panel.showPanel(
		uniqueName="asasdfdf",
		relatedHTML="This is some foo. To display the text in the body.",
		headerBarText="foo bar (1)"
		)#
	#obj_panel.showPanel(
		uniqueName="asfsdfd",
		relatedHTML="sdv sdfgsfd gd",
		useFooter="Yes",
		footerHTML="<a href='http://braddoro.com'>braddoro</a>",
		headerBarText="zods (2)"
		)#
	#obj_panel.showPanel(
		uniqueName="asfdasdf",
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
		)#
	#obj_panel.showPanel(
		uniqueName="asadfafdasdf",
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