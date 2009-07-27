<cfparam name="s_pageName" default="FWA Intel - POS List">
<cfinclude template="head.cfm">
<!--- Begin Page Content --->
<cfparam name="form.moon" type="string" default="">
<cfparam name="form.system" type="string" default="">
<cfparam name="form.planet" type="string" default="">
<cfparam name="form.alliance" type="string" default="">
<cfparam name="form.corporation" type="string" default="">
<cfparam name="form.constellation" type="string" default="">
<cfparam name="form.note_input" type="string" default="">
<cfparam name="form.race_input" type="string" default="">
<cfparam name="form.size_input" type="string" default="">
<cfparam name="form.moon_input" type="string" default="">
<cfparam name="form.planet_input" type="string" default="">
<cfparam name="form.system_input" type="string" default="">
<cfparam name="form.faction_input" type="string" default="">
<cfparam name="form.alliance_input" type="string" default="">
<cfparam name="form.dateScanned_input" type="string" default="">
<cfparam name="form.corporation_input" type="string" default="">
<cfparam name="form.constellation_input" type="string" default="">
<cfparam name="form.posListID" type="numeric" default="0">

<!--- <div class="alert">This page is under developement.</div> --->
<cfset i_posListID = 0>
<cfif isdefined("url.posListID")>
	<cfset i_posListID = url.posListID>
<cfelse>
  <cfif isdefined("form.posListID")>
	  <cfset i_posListID = form.posListID>
  </cfif>
</cfif>

<cfif isdefined("form.add")>
	<cfif form.add EQ "add">
		<cfquery name="q_add" datasource="braddoro">
			insert into braddoro.dyn_intel_pos_list (constellation, system, planet, moon, corporation, alliance, race, size, faction, dateScanned, note, deleted)
			values('#form.constellation_input#', '#form.system_input#', #val(form.planet_input)#, #val(form.moon_input)#, '#form.corporation_input#', '#form.alliance_input#', '#form.race_input#', '#form.size_input#', '#form.faction_input#', '#dateFormat(form.dateScanned_input,"yyyy-mm-dd")#', '#form.note_input#', 0)
		</cfquery>
		Added...<br>
	</cfif>
	<cfif form.add EQ "save">
		<cfquery name="q_save" datasource="braddoro">
			update braddoro.dyn_intel_pos_list set
			constellation = '#form.constellation_input#',
			system = '#form.system_input#',
			planet = #val(form.planet_input)#, 
			moon = #val(form.moon_input)#,
			corporation = '#form.corporation_input#', 
			alliance = '#form.alliance_input#',
			race = '#form.race_input#', 
			size = '#form.size_input#', 
			faction = '#form.faction_input#', 
			dateScanned = '#dateFormat(form.dateScanned_input,"yyyy-mm-dd")#', 
			note = '#form.note_input#'
			where posListID = #val(posListID)# 
		</cfquery>
		Saved...<br>
	</cfif>
</cfif>

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
<cfif NOT isdefined("form.go")>
	<cfset s_where = "and 0=1">
<cfelse>
	<cfset s_where = "">
</cfif>

<cfquery name="q_edit" datasource="braddoro">
	select * 
	from braddoro.dyn_intel_pos_list
	where posListID = #val(i_posListID)#
</cfquery>

<cfoutput>
<cfset i_posListID = #val(i_posListID)#>
<cfset s_constellation = q_edit.constellation>
<cfset s_system = q_edit.system>
<cfset s_planet = val(q_edit.planet)>
<cfset s_moon = val(q_edit.moon)>
<cfset s_corporation = q_edit.corporation>
<cfset s_alliance = q_edit.alliance>
<cfset s_faction = q_edit.faction>
<cfset s_race = q_edit.race>
<cfset s_size = q_edit.size>
<cfset s_note = q_edit.note>
<cfset s_dateScanned = dateformat(q_edit.dateScanned,"mm/dd/yyyy")>

<cfif i_posListID GT 0>
	<cfset s_value = "save">
<cfelse>
	<cfset s_value = "add">
</cfif>
<div class="subtitle">POS Entry</div>
<form id="myform" name="myform" action="poslist.cfm" method="post">
Scan Date: <input type="text" id="dateScanned_input" name="dateScanned_input" value="#dateFormat(s_dateScanned,'mm/dd/yyyy')#" size="10"><br>
Constellation: <input type="text" id="constellation_input" name="constellation_input" value="#s_constellation#"><br>
System: <input type="text" id="system_input" name="system_input" value="#s_system#"><br>
Planet: <input type="text" id="planet_input" name="planet_input" value="#s_planet#" size="5">&nbsp;(number)<br>
Moon: <input type="text" id="moon_input" name="moon_input" value="#s_moon#" size="5">&nbsp;(number)<br>
Corporation: <input type="text" id="corporation_input" name="corporation_input" value="#s_corporation#"><br>
Alliance: <input type="text" id="alliance_input" name="alliance_input" value="#s_alliance#"><br>
<cf_dropdown displayString="Faction: " dropdownName="faction_input" itemList="Angel,Blood,Dark Blood,Domination,Dread Guristas,Guristas,Sansha,Serpentis,Shadow,True Sansha" selectedValue="#s_faction#" defaultOption=""><br>
<cf_dropdown displayString="Race: " dropdownName="race_input" itemList="Amarr,Caldari,Gallente,Minmitar" selectedValue="#s_race#" defaultOption=""><br>
<cf_dropdown displayString="Size: " dropdownName="size_input" itemList="Small,Medium,Large" selectedValue="#s_size#" defaultOption=""><br>
Note: <textarea rows="5" cols="50" name="note_input" id="note_input">#s_note#</textarea><br>
<input type="submit" id="add" name="add" value="#s_value#"><br>
<input type="hidden" id="pid" name="pid" value="#s_pid#">
<input type="hidden" id="posListID" name="posListID" value="#i_posListID#">
</form>

<div class="subtitle">POS Filter</div>
<form id="myform" name="myform" action="poslist.cfm" method="post">
<cf_dropdown displayString="" dropdownName="constellation" itemList="#valueList(q_constellation.constellation)#" selectedValue="#form.constellation#" defaultOption="Constellation">
<cf_dropdown displayString="" dropdownName="system" itemList="#valueList(q_system.system)#" selectedValue="#form.system#" defaultOption="System">
<cf_dropdown displayString="" dropdownName="planet" itemList="#valueList(q_planet.planet)#" selectedValue="#form.planet#" defaultOption="Planet">
<cf_dropdown displayString="" dropdownName="moon" itemList="#valueList(q_moon.moon)#" selectedValue="#form.moon#" defaultOption="Moon">
<cf_dropdown displayString="" dropdownName="corporation" itemList="#valueList(q_corporation.corporation)#" selectedValue="#form.corporation#" defaultOption="Corporation">
<cf_dropdown displayString="" dropdownName="alliance" itemList="#valueList(q_alliance.alliance)#" selectedValue="#form.alliance#" defaultOption="Alliance">
Hide Empty&nbsp;<input type="checkbox" id="hideEmpty" name="hideEmpty" value="Yes"<cfif isdefined("form.hideEmpty") and form.hideEmpty EQ "Yes"> CHECKED</cfif>>
<input type="submit" id="go" name="go" value="go"><br>
<input type="hidden" id="pid" name="pid" value="#s_pid#">
</form>
</cfoutput>
<cfquery name="q_posList" datasource="braddoro">
	select 
	distinct
	posListID, constellation, system, planet, moon, corporation, alliance, race, size, faction, dateScanned, note 
	from braddoro.dyn_intel_pos_list
	where deleted = 0 #s_where#
<cfif form.constellation NEQ "">
	and constellation = '#form.constellation#'
</cfif>
<cfif form.corporation NEQ "">
	and corporation = '#form.corporation#'
</cfif>
<cfif form.alliance NEQ "">
	and alliance = '#form.alliance#'
</cfif>
<cfif form.system NEQ "">
	and system = '#form.system#'
</cfif>
<cfif val(form.planet) GT 0>
	and planet = #val(form.planet)#
</cfif>
<cfif val(form.moon) GT 0>
	and moon = #val(form.moon)#
</cfif>
<cfif isdefined("form.hideEmpty") and form.hideEmpty EQ "Yes">
	and corporation <> 'None'
	and moon > 0
</cfif>

	order by constellation, system, planet, moon
</cfquery>
<div class="subtitle">POS List</div>
<table class="table" border="0">
<tr>
	<td class="greentan">Constellation</td>
	<td class="greentan">System</td>
	<td class="greentan">Planet</td>
	<td class="greentan">Moon</td>
	<td class="greentan">Corporation</td>															
	<td class="greentan">Alliance</td>
	<td class="greentan">Race</td>
	<td class="greentan">Size</td>
	<td class="greentan">Faction</td>
	<td class="greentan">Scan Date</td>
	<td class="greentan">&nbsp;</td>
</tr>
<cfoutput query="q_posList">
	<cfif currentRow MOD 2><cfset s_class="even"><cfelse><cfset s_class="odd"></cfif>
	<tr>
	<td class="#s_class#">#constellation#</td>
	<td class="#s_class#">#system#</td>
	<td class="#s_class#">#planet#</td>
	<td class="#s_class#">#moon#</td>
	<td class="#s_class#">#corporation#&nbsp;</td>
	<td class="#s_class#">#alliance#</td>
	<td class="#s_class#">#race#</td>
	<td class="#s_class#">#size#</td>
	<td class="#s_class#">#faction#</td>
	<td class="#s_class#">#dateFormat(dateScanned,"mm/dd/yyyy")#</td>
	<td class="#s_class#"><a href="poslist.cfm?posListID=#posListID#&pid=#s_pid#">[edit]</a></td>
	</tr>
	<cfif note GT "">
		<tr>
		<td class="#s_class#" colspan="11">#replace(note,chr(10),"<br>","All")#</td>
		</tr>
	</cfif>
</cfoutput>
<cfoutput>
<tr>
	<td class="greentan" colspan="11">#q_posList.recordCount# Records</td>
</tr>
</table>
</cfoutput>
<!--- End Page Content --->
<cfinclude template="foot.cfm">