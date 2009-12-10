<cfparam name="form.race" type="string" default="">
<cfparam name="form.class" type="string" default="">
<cfparam name="form.techLevel" type="string" default="">
<cfparam name="form.sort" type="string" default="race">
<cfparam name="form.direction" type="string" default="asc">
<cfset s_filename = GetFileFromPath(GetCurrentTemplatePath())>

<cfquery datasource="braddoro" name="q_race">
	select distinct race
	from dyn_eve_ship_class
	order by race
</cfquery>
<cfquery datasource="braddoro" name="q_class">
	select distinct class
	from dyn_eve_ship_class
	order by class
</cfquery>
<cfif isdefined("form.submit_filter")>
	<cfset s_showFilter = "block">
<cfelse>
	<cfset s_showFilter = "none">
</cfif>
<html> 
<head> 
<title>Ship Classes</title>
<style media="screen" type="text/css">
.base {font-family : Arial , Helvetica , sans-serif;background-color : ##F1EFDE;font-size:.9em;}
.leftcol {width:150px;text-align:right;}
.toptab {background-color:##78866B;color:##FFFFFF;width:220px;padding:3px;}
.header {background-color:##78866B;color:##FFFFFF;padding:2px;}
.detail {padding:2px;}
.inputtable {border:1px solid ##708090;font-size:.9em;border-collapse:collapse;padding:2px;}
.headerlabel {font-family : Arial , Helvetica , sans-serif;background-color : ##F1EFDE;font-size:1.125em;color: ##708090;font-weight:bold;}
.headersmall {font-family : Arial , Helvetica , sans-serif;background-color : ##F1EFDE;font-size:.9sem;color: ##708090;font-weight:bold;}
}
</style>
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
<div class="headerlabel">Ship Classes</div><br>
<cfoutput>
<form id="frm_filter" name="frm_filter" action="#s_filename#" method="post">
<div id="div_filter_head" style="cursor: hand;" onclick="js_collapseThis('div_filter_body');" class="headersmall" title="Click to show or hide text." style="display:inline;">Filter</div>
<div id="div_filter_body" style="display:#s_showFilter#;">
<cf_dropdown displayString="" dropdownName="race" itemList="#valueList(q_race.race)#" selectedValue="#form.race#" defaultOption="Race">
<cf_dropdown displayString="" dropdownName="class" itemList="#valueList(q_class.class)#" selectedValue="#form.class#" defaultOption="Class">
<cf_dropdown displayString="" dropdownName="techLevel" itemList="0,1,2,3" selectedValue="#form.techLevel#" defaultOption="Tech Level">
<input type="hidden" id="sort" name="sort" value="#form.sort#">
<input type="hidden" id="direction" name="direction" value="#form.direction#">
<input type="submit" id="submit_filter" name="submit_filter" value="Go">
</div>
</form>
</cfoutput>
<!--- <cfdump var="#form#"> --->
<!--- <cfoutput>'#listChangeDelims(form.race, "','", ",")#'</cfoutput> --->
<cfset i_rows = 0>
<cfquery datasource="braddoro" name="q_pos">
	select shipID, eveID, race, class, shipName, tier, strength, techLevel
	from dyn_eve_ship_class
	where 0=0
<cfif form.race NEQ "">
	and race = '#form.race#'
	<!--- <cfif form.race contains ",">
		and race like '#listChangeDelims(form.race, "','", ",")#' 
	</cfif> --->
</cfif>
<cfif form.class NEQ "">
	and class = '#form.class#'
</cfif>
<cfif form.techLevel NEQ "">
	and techLevel = #val(form.techLevel)#
</cfif>
	order by #form.sort# #form.direction# 
</cfquery>
<table class="inputtable">
<tr>
	<td class="headerlabel">Race<img src="desc.gif" onclick="js_submitMe('race','asc');"><img src="asc.gif" onclick="js_submitMe('race','desc');"></td>
	<td class="headerlabel">Class<img src="desc.gif" onclick="js_submitMe('class','asc');"><img src="asc.gif" onclick="js_submitMe('class','desc');"></td>
	<td class="headerlabel">Ship Name<img src="desc.gif" onclick="js_submitMe('shipName','asc');"><img src="asc.gif" onclick="js_submitMe('shipName','desc');"></td>
	<td class="headerlabel">Tier<img src="desc.gif" onclick="js_submitMe('tier','asc');"><img src="asc.gif" onclick="js_submitMe('tier','desc');"></td>
	<td class="headerlabel">Tech<img src="desc.gif" onclick="js_submitMe('techLevel','asc');"><img src="asc.gif" onclick="js_submitMe('techLevel','desc');"></td>
	<td class="headerlabel">Strength<img src="desc.gif" onclick="js_submitMe('strength','asc');"><img src="asc.gif" onclick="js_submitMe('strength','desc');"></td>
</tr>
<cfoutput query="q_pos">
	<!--- 99A68C A6A68C --->
	<!--- 757116 D9DB56 --->
	
	<cfif currentRow MOD 2><cfset s_bgcolor = "##99A68C"><cfelse><cfset s_bgcolor = "##A6A68C"></cfif>
	<tr>
	<td class="detail" bgcolor="#s_bgcolor#">#race#</td>
	<td class="detail" bgcolor="#s_bgcolor#">#class#</td>
	<td class="detail" bgcolor="#s_bgcolor#">#shipName#</td>
	<td class="detail" bgcolor="#s_bgcolor#">#tier#</td>
	<td class="detail" bgcolor="#s_bgcolor#">#techLevel#</td>
	<td class="detail" bgcolor="#s_bgcolor#">#strength#</td>
	</tr>
	<cfset i_rows++>
</cfoutput>
<cfoutput>
</table>
	Results: #i_rows#
</body> 
</html>
<script language="javascript">
function js_submitMe(column,direction) {
	document.getElementById("sort").value = column;
	document.getElementById("direction").value = direction;
	document.getElementById("frm_filter").submit();
}
</script>
</cfoutput>