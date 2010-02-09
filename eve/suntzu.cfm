<cfparam name="chapterID" type="numeric" default="0">
<cfparam name="paragraphID" type="numeric" default="0">
<cfset s_filename = GetFileFromPath(GetCurrentTemplatePath())>
<cfset s_pageName = "The Art of War &mdash; Sun Tzu">
<cfset i_iconSize = 14>
<cfset i_chapterID = 0>
<cfif isdefined("url.chapterID")>
	<cfset i_chapterID = val(url.chapterID)>
<cfelse>
  <cfif isdefined("form.chapterID")>
	  <cfset i_chapterID = val(form.chapterID)>
  </cfif>
</cfif>
<cfset i_paragraphID = 0>
<cfif isdefined("url.paragraphID")>
	<cfset i_paragraphID = val(url.paragraphID)>
<cfelse>
  <cfif isdefined("form.paragraphID")>
	  <cfset i_paragraphID = val(form.paragraphID)>
  </cfif>
</cfif>
<cfoutput>
<html> 
<head> 
<title>#s_pageName#</title>
<style media="screen" type="text/css">
.base {font-family : Arial , Helvetica , sans-serif;background-color : ##F1EFDE;font-size:.9em;}
.leftcol {width:150px;text-align:right;background-color:##A6A68C;padding:2px;}
.rightcol {background-color:##A6A68C;padding:2px;}
.example {font-family : Arial , Helvetica , sans-serif;font-size:.75em;padding:2px;}
.smallwarn {font-family : Arial , Helvetica , sans-serif;font-size:.75em;color: red;}
.smallok {font-family : Arial , Helvetica , sans-serif;font-size:.75em;color: green;}
.toptab {background-color:##78866B;color:##FFFFFF;width:220px;padding:3px;}
.header {background-color:##78866B;color:##FFFFFF;padding:2px;}
.detail {padding:2px;}
.warn {font-family : Arial , Helvetica , sans-serif;color: red;}
.inputtable {border:1px solid ##708090;font-size:.9em;border-collapse:collapse;padding:2px;}
.inputtablenob {##708090;font-size:.9em;border-collapse:collapse;padding:2px;}
.headerlabel {font-family : Arial , Helvetica , sans-serif;background-color : ##F1EFDE;font-size:1.125em;color: ##708090;font-weight:bold;}
.headersmall {font-family : Arial , Helvetica , sans-serif;background-color : ##F1EFDE;font-size:.9sem;color: ##708090;font-weight:bold;}
}
</style>
<script type="text/javascript" src="ajax.js"></script>
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
	function js_changeBG(changeme,colorbg) {
		document.getElementById(changeme).style.backgroundColor = colorbg;
	}
	function js_opener(myurl) {
		window.open(myurl,"_self","","false");
	}
	function js_silo(container, towerID, reactionID) {
		var s_ajax = "Task=silo";
		s_ajax += "&towerID=" + towerID;
		s_ajax += "&reactionID=" + reactionID;
		var s_return = http_post_request("tower_ajax.cfm", s_ajax);
		if (container != '' && document.getElementById(container)) {
			document.getElementById(container).innerHTML = s_return; 
		}
	}
</script>
</head> 
<body class="base">
<span class="headerlabel">#s_pageName#</span> <a href="#s_filename#"><img src="Button-Refresh-16x16.png" border="0" height="#i_iconSize#" width="#i_iconSize#" title="refresh"></a>&nbsp;<span id="swirly" name="swirly" style="display:block;">&nbsp;<img src="../../images/new-spinner.gif" border="0" height="12" width="12" title="loading..."></span><br /><br />
</cfoutput>
<cfif i_chapterID EQ 0 and i_paragraphID EQ 0>
	<cfset s_sql = "select chapterID, chapterName, paragraphID, paragraph from suntzu order by RAND() limit 1;">
<cfelse>
	<cfset s_sql = "select chapterID, chapterName, paragraphID, paragraph from suntzu where chapterID = " & #i_chapterID# & " and paragraphID = " & #i_paragraphID# & ";">
</cfif>
<cfquery datasource="braddoro" name="q_suntzu">#s_sql#</cfquery>
<cfoutput query="q_suntzu">
	<cfset i_chapterID = #chapterID#>
	<cfset i_paragraphID = #paragraphID#>
	<strong>#i_chapterID#. #chapterName#</strong><br /><br />
	<strong>#i_paragraphID#.</strong>&nbsp;#paragraph#<br /><br />
</cfoutput>
<cfoutput>
	<a href="#s_filename#?chapterID=#i_chapterID#&paragraphID=#i_paragraphID-1#" title="Previous Paragraph"><img src="../../images/Button-Previous-16x16.png" border="0" height="#i_iconSize#" width="#i_iconSize#" title="previous" align="bottom"></a></a>&nbsp;
	<strong><cfloop from="1" to="13" index="i_chapt"><a href="#s_filename#?chapterID=#i_chapt#&paragraphID=1" title="Jump to Chapter #i_chapt#">#i_chapt#</a>&nbsp;</cfloop></strong>
	<a href="#s_filename#?chapterID=#i_chapterID#&paragraphID=#i_paragraphID+1#" title="Next Paragraph"><img src="../../images/Button-Next-16x16.png" border="0" height="#i_iconSize#" width="#i_iconSize#" title="next" align="bottom"></a></a>
</cfoutput>
</body> 
</html>
<script language="javascript">
document.getElementById("swirly").style.display = "none";
</script>