<cfset s_title="BSA Troop 18, Newell NC">
<cfset s_spoofedURL="http://bsatroop18.org/">
<cfoutput>
<html>
<head>
<link href="bsa.css" rel="stylesheet" type="text/css" media="screen">
<!--- <script type="text/javascript" src="utility.js"></script> --->
<title>#s_title#</title>
<script language="javascript">
function js_collapseThis(changeme,showType) {
	var s_showType = "block";
	if (arguments.length == 2) {
		s_showType = showType; 
	}
	if (document.getElementById(changeme).style.display == "none") {
		document.getElementById(changeme).style.display = s_showType;
	} else {
		document.getElementById(changeme).style.display = "none";
	}
}
</script>
</head>
<body class="base">
<!--- <img src="BsaLogoOriginal.jpg" border="0"> --->
<div id="div_banner">
	<span class="banner">#s_title#</span>
	<span style="font-size:.9em;float:right;"><cfinclude template="links.cfm"></span>
</div>
<br>
</cfoutput>