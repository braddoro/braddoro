<cfparam name="s_pageName" default="FWA Intel - POS List">
<cfinclude template="head.cfm">
<!--- Begin Page Content --->
<cfparam name="form.moon" type="string" default="">
<cfparam name="form.system" type="string" default="">
<cfparam name="form.planet" type="string" default="">
<cfparam name="form.alliance" type="string" default="">
<cfparam name="form.corporation" type="string" default="">
<cfparam name="form.constellation" type="string" default="">
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
<cfoutput>
<form id="myform" name="myform" action="poslist.cfm" method="post">
<input type="hidden" id="pid" name="pid" value="#s_pid#">

<select id="constellation" name="constellation">
<option value="">Constellation</option>
<cfloop query="q_constellation">
	<option value="#constellation#"<cfif form.constellation EQ constellation> SELECTED</cfif>>#constellation#</option>
</cfloop>
</select>

<select id="system" name="system">
<option value="">System</option>
<cfloop query="q_system">
	<option value="#system#"<cfif form.system EQ system> SELECTED</cfif>>#system#</option>
</cfloop>
</select>

<select id="planet" name="planet">
<option value="">Planet</option>
<cfloop query="q_planet">
	<option value="#planet#"<cfif form.planet EQ planet> SELECTED</cfif>>#planet#</option>
</cfloop>
</select>

<select id="moon" name="moon">
<option value="">Moon</option>
<cfloop query="q_moon">
	<option value="#moon#"<cfif form.moon EQ moon> SELECTED</cfif>>#moon#</option>
</cfloop>
</select>

<select id="corporation" name="corporation">
<option value="">Corporation</option>
<cfloop query="q_corporation">
	<option value="#corporation#"<cfif form.corporation EQ corporation> SELECTED</cfif>>#corporation#</option>
</cfloop>
</select>

<select id="alliance" name="alliance">
<option value="">Alliance</option>
<cfloop query="q_alliance">
	<option value="#alliance#"<cfif form.alliance EQ alliance> SELECTED</cfif>>#alliance#</option>
</cfloop>
</select>

<input type="submit" id="go" name="go" value="go">&nbsp;<a href="sightings.cfm?pid=#s_pid#">clear</a><br>
</form>
</cfoutput>
<cfquery name="q_sighting" datasource="braddoro">
	select 
	distinct
	posListID, constellation, system, planet, moon, corporation, alliance, race, size, faction, dateScanned, note 
	from braddoro.dyn_intel_pos_list
	where deleted = 0
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
	order by constellation, system, planet, moon
</cfquery>
<div class="subtitle">Sightings</div>
<table class="table" border="0">
<tr>
	<td class="greentan">constellation</td>
	<td class="greentan">system</td>
	<td class="greentan">planet</td>
	<td class="greentan">moon</td>
	<td class="greentan">corporation</td>															
	<td class="greentan">alliance</td>
	<td class="greentan">race</td>
	<td class="greentan">size</td>
	<td class="greentan">faction</td>
	<td class="greentan">dateScanned</td>
	<td class="greentan">note</td>
	<td class="greentan">&nbsp;</td>
</tr>
<cfoutput query="q_sighting">
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
	<td class="#s_class#">#note#</td>
	<td class="#s_class#">#dateFormat(dateScanned,"mm/dd/yyyy")#</td>
	<td class="#s_class#"><a href="sightings.cfm?sightingID=#posListID#&pid=#s_pid#">[edit]</a></td>																	
	</tr>
</cfoutput>
<cfoutput>
<tr>
	<td class="greentan" colspan="12">#q_sighting.recordCount# Records</td>
</tr>
</table>
</cfoutput>
<!--- End Page Content --->
<cfinclude template="foot.cfm">