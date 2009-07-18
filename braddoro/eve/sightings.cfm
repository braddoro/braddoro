<cfparam name="s_pageName" default="FWA Intel - Sighting Data">
<cfinclude template="head.cfm">
<!--- Begin Page Content --->
<cfoutput>

<cfparam name="form.sightingDate" type="date" default="#dateformat(now(),"mm/dd/yyyy")# #timeformat(now(),"HH:mm:ss")#">
<cfparam name="form.hour" type="numeric" default="#hour(now())#">
<cfparam name="form.minute" type="numeric" default="#minute(now())#">
<cfparam name="form.system" type="string" default="">
<cfparam name="form.seen" type="string" default="">
<cfparam name="form.seenBy" type="string" default="#s_userName#">
<cfparam name="form.ship" type="string" default="">
<cfparam name="form.activity" type="string" default="">
<cfparam name="form.reconType" type="string" default="">

<cfset i_sightingID = 0>
<cfset s_sightingDate = form.sightingDate>
<cfset i_hour = hour(form.sightingDate)>
<cfset i_minute = minute(form.sightingDate)>
<cfset s_system = form.system>
<cfset s_seen = "">
<cfset s_seenBy = form.seenBy>			
<cfset s_ship = "">
<cfset s_reconType = "">
<cfset s_activity = "">	

<cfif isdefined("form.go") and form.seen NEQ "" and form.system NEQ "" and form.seenBy NEQ "">
	<cfif isdefined("sightingID") and val(sightingID) GT 0>
        <cfquery name="q_sighting" datasource="braddoro">
	        update braddoro.dyn_intel_sightings set
				sightingDate = '#dateformat(form.sightingDate,"yyyy-mm-dd")# #form.hour#:#form.minute#',
				system = '#trim(form.system)#',
				seen = '#trim(form.seen)#',
				seenBy = '#trim(form.seenBy)#',
				ship = '#trim(form.ship)#',
				activity = '#form.activity#', 
				reconType = '#form.reconType#'
				where sightingID = #val(form.sightingID)#
        </cfquery>
	<cfelse>
        <cfquery name="q_sighting" datasource="braddoro">
    	    insert into braddoro.dyn_intel_sightings (sightingDate, system, seen, seenBy, ship, activity, reconType, deleted)
        	select 
				'#dateformat(form.sightingDate,"yyyy-mm-dd")# #form.hour#:#form.minute#', 
				'#trim(form.system)#',
				'#trim(form.seen)#',
				'#trim(form.seenBy)#',
				'#trim(form.ship)#',
				'#form.activity#',
				'#form.reconType#',
				0	 			 			 			 			 
		</cfquery>
	</cfif>
</cfif>
<cfif isdefined("sightingID")  and val(sightingID) GT 0 and not isdefined("form.go")>
	<cfquery name="q_sighting" datasource="braddoro">
		select sightingID, sightingDate, system, seen, seenBy, ship, activity, reconType from braddoro.dyn_intel_sightings where sightingID = #val(sightingID)#	 			 			 			 			 
	</cfquery>
	<cfloop query="q_sighting">
		<cfset i_sightingID = sightingID>
		<cfset s_sightingDate = dateformat(sightingDate,"yyyy-mm-dd")>
		<cfset i_hour = hour(sightingDate)>
		<cfset i_minute = minute(sightingDate)>
		<cfset s_system = system>
		<cfset s_seen = seen>
		<cfset s_seenBy = seenBy>			
		<cfset s_ship = ship>
		<cfset s_activity = activity>	
		<cfset s_reconType = reconType>
	</cfloop> 
</cfif>
<cfif isdefined("sightingID") and val(sightingID) GT 0 and not isdefined("form.go")>
	<cfset s_value = "Save">
<cfelse>
	<cfset s_value = "Add">
</cfif>
<form id="myform" name="myform" action="sightings.cfm" method="post">
(&bull; = required)<br>
<input type="hidden" id="pid" name="pid" value="#s_pid#"><br>
<input type="hidden" id="sightingID" name="sightingID" value="#i_sightingID#"><br>
Recon Type: 
<cfset s_list = "Chance Encounter,Static,Interception,Shadow">
<select id="reconType" name="reconType">
<option value="Chance Encounter"<cfif "Chance Encounter" EQ s_reconType> SELECTED</cfif>>Chance Encounter</option>
<option value="Static"<cfif "Static" EQ s_reconType> SELECTED</cfif>>Static</option>
<option value="Interception"<cfif "Interception" EQ s_reconType> SELECTED</cfif>>Interception</option>
<option value="Shadow"<cfif "Shadow" EQ s_reconType> SELECTED</cfif>>Shadow</option>
<option value="Log On"<cfif "Log On" EQ s_reconType> SELECTED</cfif>>Log On</option>
<option value="Log Off"<cfif "Log Off" EQ s_reconType> SELECTED</cfif>>Log Off</option>
</select><br>
Date: <input type="text" id="sightingDate" name="sightingDate" value="#s_sightingDate#" size="10">&nbsp;&bull;<br>
Time: <select id="hour" name="hour">
<cfloop from="0" to="23" index="i_index">
<option value="#i_index#"<cfif val(i_hour) EQ i_index> SELECTED</cfif>>#numberFormat(i_index,"00")#</option>
</cfloop>
</select>
<cfset i_mod = val(i_minute) MOD 5>
<cfset i_current = val(i_minute)-i_mod>
<select id="minute" name="minute">
<cfloop from="0" to="55" index="i_index" step="5">
<option value="#i_index#"<cfif i_current EQ i_index> SELECTED</cfif>>#numberFormat(i_index,"00")#</option>
</cfloop>
</select>&nbsp;&bull;<br>
System: <input type="text" id="system" name="system" value="#s_system#">&nbsp;&bull;<br>
Who Seen: <textarea rows="1" cols="30" name="seen" id="seen">#s_seen#</textarea>&nbsp;&bull;&nbsp;(drag and drop name from local, do not link)<br>
Ship Type: <input type="text" id="ship" name="ship" value="#s_ship#"><br>
Seen By: <input type="text" id="seenBy" name="seenBy" value="#s_seenBy#">&nbsp;&bull;<br>
Activity: <textarea rows="3" cols="30" name="activity" id="activity">#s_activity#</textarea><br>
<input type="submit" id="go" name="go" value="#s_value#">&nbsp;<a href="sightings.cfm?pid=#s_pid#">clear</a><br>
</form>
</cfoutput>
<cfquery name="q_sighting" datasource="braddoro">
	select sightingID, sightingDate, system, seen, seenBy, ship, activity, reconType
	from braddoro.dyn_intel_sightings
	where deleted = 0
	and sightingDate > '#dateformat(dateAdd("d",-1,now()),"yyyy-mm-dd")# #timeformat(now(),"HH:mm:ss")#'
	order by sightingDate desc
</cfquery>
<cfoutput>
<div class="subtitle">Recent Sightings</div>
</cfoutput>
<table class="table" border="0">
<tr>
	<td class="greentan">Date Seen</td>
	<td class="greentan">Recon Type</td>
	<td class="greentan">System</td>
	<td class="greentan">Target</td>
	<td class="greentan">Ship</td>
	<td class="greentan">Activity</td>															
	<td class="greentan">Seen By</td>
	<td class="greentan">&nbsp;</td>
</tr>
<cfoutput query="q_sighting">
	<cfif currentRow MOD 2><cfset s_class="even"><cfelse><cfset s_class="odd"></cfif>
	<tr>
		<td class="#s_class#">#dateFormat(sightingDate,"mm/dd/yyyy")# #timeFormat(sightingDate,"HH:mm")#</td>
		<td class="#s_class#">#reconType#</td>
		<td class="#s_class#">#system#</td>
		<td class="#s_class#">#seen#</td>
		<td class="#s_class#">#ship#&nbsp;</td>
		<td class="#s_class#">#activity#&nbsp;</td>
		<td class="#s_class#">#seenBy#</td>
		<td class="#s_class#"><a href="sightings.cfm?sightingID=#sightingID#&pid=#s_pid#">[edit]</a></td>																	
	</tr>
</cfoutput>
<tr>
	<td class="greentan" colspan="8">Only the last 24 hours is shown to save bandwidth.</td>
</tr>
</table>
<!--- End Page Content --->
<cfinclude template="foot.cfm">