<cfparam name="s_pageName" default="FWA Intel - POS List">
<cfinclude template="head.cfm">

<cfparam name="form.pid" type="string" default="">
<cfparam name="form.mineral" type="string" default="">
<cfparam name="form.rarity" type="numeric" default="0">
<cfparam name="form.output" type="numeric" default="0">

<cfset s_pid = "">
<cfif isdefined("url.pid")>
	<cfset s_pid = url.pid>
<cfelse>
  <cfif isdefined("form.pid")>
	  <cfset s_pid = form.pid>
  </cfif>
</cfif>

<cfset s_system = "">
<cfif isdefined("url.system")>
	<cfset s_system = url.system>
<cfelse>
  <cfif isdefined("form.system")>
	  <cfset s_system = form.system>
  </cfif>
</cfif>

<cfset i_planet = 0>
<cfif isdefined("url.planet")>
	<cfset i_planet = url.planet>
<cfelse>
  <cfif isdefined("form.planet")>
	  <cfset i_planet = form.planet>
  </cfif>
</cfif>

<cfset i_moon = 0>
<cfif isdefined("url.moon")>
	<cfset i_moon = url.moon>
<cfelse>
  <cfif isdefined("form.moon")>
	  <cfset i_moon = form.moon>
  </cfif>
</cfif>

<cfset i_moonMineralID = 0>
<cfif isdefined("url.moonMineralID")>
	<cfset i_moonMineralID = url.moonMineralID>
<cfelse>
  <cfif isdefined("form.moonMineralID")>
	  <cfset i_moonMineralID = form.moonMineralID>
  </cfif>
</cfif>

<cfif i_moonMineralID GT 0>
	<cfquery name="q_minerals" datasource="braddoro">
		delete from dyn_intel_pos_moon_mineral where moonMineralID = #i_moonMineralID#
	</cfquery>
</cfif>
<cfif form.mineral NEQ "">
	<cfquery name="q_minerals" datasource="braddoro">
		insert into dyn_intel_pos_moon_mineral (system, planet, moon, mineral, rarity, output)
		values ('#trim(s_system)#', #val(i_planet)#, #val(i_moon)#, '#trim(form.mineral)#', #val(form.rarity)#, #val(form.output)#)  
	</cfquery>
</cfif>
<!--- Begin Page Content --->
<cfoutput>
<script language="javascript">
</script>
<div class="subtitle">Moon Mineral</div>
<form id="myform" name="myform" action="moonMins.cfm" method="post">
<input type="hidden" id="pid" name="pid" value="#s_pid#">
<input type="hidden" id="system" name="system" value="#s_system#">
<input type="hidden" id="planet" name="planet" value="#i_planet#">
<input type="hidden" id="moon" name="moon" value="#i_moon#">
Mineral: <input type="text" id="mineral" name="mineral" value=""><br>
Rarity: <cf_dropdown displayString="" dropdownName="rarity" itemList="0,2,8,16,32,64,256" selectedValue="0" defaultOption="0"><br>
Output: <cf_dropdown displayString="" dropdownName="output" itemList="1,2,3" selectedValue="1" defaultOption="1"><br>
<input type="submit" id="go" name="go" value="go"><br>
</form>
</cfoutput>
<cfquery name="q_minerals" datasource="braddoro">
	select * 
	from braddoro.dyn_intel_pos_moon_mineral
	where system = '#s_system#'
	and planet = #i_planet#
	and moon = #i_moon#
	order by mineral
</cfquery>
<table class="inputtable" style="border-collapse:collapse;">
<tr>
	<td class="greentan">Mineral</td>
	<td class="greentan">Rarity</td>
	<td class="greentan">Output</td>
	<td class="greentan">Delete</td>
</tr>
<cfoutput query="q_minerals">
	<cfif currentRow MOD 2><cfset s_class="even"><cfelse><cfset s_class="odd"></cfif>
	<tr>
	<td class="#s_class#">#mineral#</td>
	<td class="#s_class#">#rarity#</td>
	<td class="#s_class#">#output#</td>
	<td class="#s_class#"><a href="moonMins.cfm?moonMineralID=#moonMineralID#&system=#system#&planet=#planet#&moon=#moon#&pid=13e45bd5-6b6a-11de-a093-cf48f9094230" target="_blank">Edit</a></td>
	</tr>
</cfoutput>
</table>
<!--- End Page Content --->
<cfinclude template="foot.cfm">