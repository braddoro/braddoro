<cfparam name="form.orderBy" type="string" default="P.constellation, P.system, P.planet, P.moon">
<cfparam name="form.sortDir" type="string" default="ASC">
<cfparam name="form.moon" type="string" default="">
<cfparam name="form.planet" type="string" default="">
<cfparam name="form.system" type="string" default="">
<cfparam name="form.rarity" type="string" default="">
<cfparam name="form.mineral" type="string" default="">
<cfparam name="form.alliance" type="string" default="">
<cfparam name="form.corporation" type="string" default="">
<cfparam name="form.constellation" type="string" default="">
<cfset s_filename = GetFileFromPath(GetCurrentTemplatePath())>
<cfif form.orderBy EQ "">
	<cfset form.orderBy = "P.constellation, P.system, P.planet, P.moon">
</cfif>
<cfquery datasource="braddoro" name="q_pos">
	SELECT 
	P.posListID,
	M.moonMineralID,  
	P.constellation, P.system, P.planet, P.moon, 
	P.corporation, P.alliance, 
	P.race, P.size, P.faction, P.dateScanned, P.note,
	M.mineral, M.rarity, M.output,
	P.deleted
	from dyn_intel_pos_list P
	left join dyn_intel_pos_moon_mineral M
	on P.system = M.system
	and P.planet = M.planet
	and P.moon = M.moon
	where P.deleted = 0
<cfif form.constellation NEQ "">
	and P.constellation = '#form.constellation#'
</cfif>
<cfif form.corporation NEQ "">
	and P.corporation = '#form.corporation#'
</cfif>
<cfif form.alliance NEQ "">
	and P.alliance = '#form.alliance#'
</cfif>
<cfif form.system NEQ "">
	and P.system = '#form.system#'
</cfif>
<cfif val(form.planet) GT 0>
	and P.planet = #val(form.planet)#
</cfif>
<cfif val(form.moon) GT 0>
	and P.moon = #val(form.moon)#
</cfif>
<cfif val(form.rarity) GT 0>
	and M.rarity = #val(form.rarity)#
</cfif>
<cfif form.mineral GT 0>
	and M.mineral = '#form.mineral#'
</cfif>
<cfif isdefined("form.hideEmpty") and form.hideEmpty EQ "Yes">
	and P.corporation <> 'None'
</cfif>
<cfif isdefined("form.hideMoonless") and form.hideMoonless EQ "Yes">
	and P.moon <> 0
</cfif>
	order by #orderby# #sortDir#
</cfquery>
<cfquery name="q_constellation" datasource="braddoro">
	select distinct constellation
	from braddoro.dyn_intel_pos_list
	where deleted = 0
	order by constellation
</cfquery>
<cfquery name="q_alliance" datasource="braddoro">
	select distinct alliance 
	from braddoro.dyn_intel_pos_list
	where deleted = 0
	order by alliance
</cfquery>
<cfquery name="q_corporation" datasource="braddoro">
	select distinct corporation
	from braddoro.dyn_intel_pos_list
	where deleted = 0
	order by corporation
</cfquery>
<cfquery name="q_system" datasource="braddoro">
	select distinct system 
	from braddoro.dyn_intel_pos_list
	where deleted = 0
	order by system
</cfquery>
<cfquery name="q_planet" datasource="braddoro">
	select distinct planet 
	from braddoro.dyn_intel_pos_list
	where deleted = 0
<cfif form.system NEQ "">
	and system = '#form.system#'
</cfif>
	order by planet
</cfquery>
<cfquery name="q_moon" datasource="braddoro">
	select distinct moon 
	from braddoro.dyn_intel_pos_list
	where deleted = 0
<cfif form.system NEQ "">
	and system = '#form.system#'
</cfif>
	order by moon
</cfquery>
<cfquery name="q_rarity" datasource="braddoro">
	select distinct rarity 
	from braddoro.dyn_intel_pos_moon_mineral
	order by rarity
</cfquery>
<cfquery name="q_mineral" datasource="braddoro">
	select distinct mineral
	from braddoro.dyn_intel_pos_moon_mineral
	order by mineral
</cfquery>
<cfoutput>
<cfif isdefined("form.submit_filter")>
	<cfset s_showFilter = "block">
<cfelse>
	<cfset s_showFilter = "none">
</cfif>
<html> 
<head> 
<title>POS Information</title>
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
<div class="headerlabel">POS Information</div><br>
<form id="frm_filter" name="frm_pass" action="#s_filename#" method="post">
<div id="div_filter_head" style="cursor: hand;" onclick="js_collapseThis('div_filter_body');" class="toptab" title="Click to show or hide text." style="display:inline;">Filter & Sort</div>
<div id="div_filter_body" style="display:#s_showFilter#;">
<div class="headersmall">Filter</div>
<cf_dropdown displayString="" dropdownName="constellation" itemList="#valueList(q_constellation.constellation)#" selectedValue="#form.constellation#" defaultOption="Constellation">
<cf_dropdown displayString="" dropdownName="system" itemList="#valueList(q_system.system)#" selectedValue="#form.system#" defaultOption="System">
<cf_dropdown displayString="" dropdownName="planet" itemList="#valueList(q_planet.planet)#" selectedValue="#form.planet#" defaultOption="Planet">
<cf_dropdown displayString="" dropdownName="moon" itemList="#valueList(q_moon.moon)#" selectedValue="#form.moon#" defaultOption="Moon"><br>
<cf_dropdown displayString="" dropdownName="corporation" itemList="#valueList(q_corporation.corporation)#" selectedValue="#form.corporation#" defaultOption="Corporation">
<cf_dropdown displayString="" dropdownName="alliance" itemList="#valueList(q_alliance.alliance)#" selectedValue="#form.alliance#" defaultOption="Alliance"><br>
<cf_dropdown displayString="" dropdownName="rarity" itemList="#valueList(q_rarity.rarity)#" selectedValue="#form.rarity#" defaultOption="Rarity">
<cf_dropdown displayString="" dropdownName="mineral" itemList="#valueList(q_mineral.mineral)#" selectedValue="#form.mineral#" defaultOption="Mineral"><br>
Hide Moonless&nbsp;<input type="checkbox" id="hideMoonless" name="hideMoonless" value="Yes"<cfif isdefined("form.hideMoonless") and form.hideMoonless EQ "Yes"> CHECKED</cfif>>
Hide Empty&nbsp;<input type="checkbox" id="hideEmpty" name="hideEmpty" value="Yes"<cfif isdefined("form.hideEmpty") and form.hideEmpty EQ "Yes"> CHECKED</cfif>>
<div class="headersmall">Sort</div>
<cf_dropdown displayString="" dropdownName="orderby" itemList="P.dateScanned,P.constellation,P.system,P.planet,P.moon,P.corporation,P.alliance,P.race,P.size,P.faction,P.dateScanned,P.note,M.mineral,M.rarity" selectedValue="#form.orderby#" defaultOption="Sort Field">
<cf_dropdown displayString="" dropdownName="sortDir" itemList="ASC,DESC" selectedValue="#form.sortDir#" defaultOption="Sort Dir">
<input type="submit" id="submit_filter" name="submit_filter" value="Go">
</div>
</form>
<cfset i_rows = 0>
<table class="inputtable">
	<tr>
	<td class="header">Scanned</td>
	<td class="header">Constellation</td>
	<td class="header">System</td>
	<td class="header">Planet</td>
	<td class="header">Moon</td>
	<td class="header">Corporation</td>
	<td class="header">Alliance</td>
	<td class="header">Size</td>
	<td class="header">Race</td>
	<td class="header">Faction</td>
	<td class="header">Mineral</td>
	</tr>
</cfoutput>
<cfoutput query="q_pos" group="posListID">
<cfif currentRow MOD 2><cfset s_bgcolor = "##99A68C"><cfelse><cfset s_bgcolor = "##A6A68C"></cfif>
	<tr>
	<td class="detail" bgcolor="#s_bgcolor#"><a href="poslist.cfm?poslistID=#poslistID#&pid=13e45bd5-6b6a-11de-a093-cf48f9094230" target="_blank">#dateFormat(dateScanned,"mm/dd/yyyy")#</a></td>
	<td class="detail" bgcolor="#s_bgcolor#">#constellation#</td>
	<td class="detail" bgcolor="#s_bgcolor#">#system#</td>
	<td class="detail" bgcolor="#s_bgcolor#">#planet#</td>
	<td class="detail" bgcolor="#s_bgcolor#">#moon#</td>
	<td class="detail" bgcolor="#s_bgcolor#">#corporation#</td>
	<td class="detail" bgcolor="#s_bgcolor#">#alliance#</td>
	<td class="detail" bgcolor="#s_bgcolor#">#size#</td>
	<td class="detail" bgcolor="#s_bgcolor#">#race#</td>
	<td class="detail" bgcolor="#s_bgcolor#">#faction#</td>
	<cfset s_mineral = "">
	<cfoutput><cfset s_mineral = s_mineral & "#mineral# (#rarity#), "></cfoutput>
	<cfset s_mineral = replace(s_mineral,"()","","All")	>
	<cfset s_mineral = replace(s_mineral,"None (0),","","All")>
	<cfif len(s_mineral) GT 2><cfset s_mineral = left(s_mineral,len(s_mineral)-2)></cfif>
	<td class="detail" bgcolor="#s_bgcolor#">#s_mineral#&nbsp;</td>
	</tr>
	<cfset i_rows++>
</cfoutput>
<cfoutput>
</table>
	Results: #i_rows#
</body> 
</html>
</cfoutput>