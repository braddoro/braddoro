<cfset objSnip = createObject("component","snip_logic")>
<html>
<head>
<title>Snip Library</title>
<script language="javascript" src="snip.js"></script>
</head>
<body style="font-family: helvetica, arial, sans-serif;font-size:.9em">
<b>Snip Library</b>&nbsp;<span style="cursor:pointer;" onclick="js_ajax('edit',-1,'div_input');"><img src="write.gif" title="Add snippet."></span>
<hr>
<cfoutput>
<div id="div_output" name="div_output" style="display:block;">#objSnip.output(snippetID=0)#</div>
<div id="div_input" name="div_input" style="display:none;"></div>
<!--- #objSnip.input(snippetID=-1)# --->
</cfoutput>
</body>
</head>
</html>