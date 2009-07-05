<cfparam name="form.sightingDate" type="string" default="#dateformat(now(),"yyyy-mm-dd")#">
<cfparam name="form.hour" type="numeric" default="#hour(now())#">
<cfparam name="form.minute" type="numeric" default="#minute(now())#">
<cfparam name="form.system" type="string" default="">
<cfparam name="form.seen" type="string" default="">
<cfparam name="form.seenBy" type="string" default="">
<cfparam name="form.ship" type="string" default="">
<cfparam name="form.activity" type="string" default="">
<html>
<head>
<title>FWA Intel - Sightings</title>
</head>
<body>
<cfoutput>
<h4>Intel - Sightings</h4><br>
<form id="myform" name="myform" action="sightings.cfm" method="post">
Date: <input type="text" id="sightingDate" name="sightingDate" value="#form.sightingDate#" size="10">&nbsp;&bull;<br>
Time: <select id="hour" name="hour">
<cfloop from="0" to="23" index="i_hour">
<option value="#i_hour#"<cfif val(form.hour) EQ i_hour> SELECTED</cfif>>#numberFormat(i_hour,"00")#</option>
</cfloop>
</select>
<cfset i_mod = val(form.minute) MOD 5>
<cfset i_current = val(form.minute)-i_mod>
<select id="minute" name="minute">
<cfloop from="0" to="55" index="i_minute" step="5">
<option value="#i_minute#"<cfif i_current EQ i_minute> SELECTED</cfif>>#numberFormat(i_minute,"00")#</option>
</cfloop>
</select>&nbsp;&bull;<br>
System: <input type="text" id="system" name="system" value="#form.system#">&nbsp;&bull;<br>
Who Seen: <input type="text" id="seen" name="seen" value="">&nbsp;&bull;<br>
Ship Type: <input type="text" id="ship" name="ship" value="">&nbsp;&bull;<br>
Seen By: <input type="text" id="seenBy" name="seenBy" value="#form.seenBy#">&nbsp;&bull;<br>
Activity: <textarea rows="3" cols="30" name="activity" id="activity"></textarea><br>
<input type="submit" id="go" name="go" value="Add"><br>
(&bull; = required)
</form>
</cfoutput>
<cfif isdefined("form.go") and form.seen NEQ "" and form.system NEQ "" and form.seenBy NEQ "">
  <cfquery name="q_sighting" datasource="braddoro">
  insert into braddoro.dyn_intel_sightings (sightingDate, system, seen, seenBy, ship, activity, deleted)
  select 
  			 '#dateformat(form.sightingDate,"yyyy-mm-dd")# #form.hour#:#form.minute#', 
  			 '#trim(form.system)#',
  			 '#trim(form.seen)#',
  			 '#trim(form.seenBy)#',
  			 '#trim(form.ship)#',
  			 '#form.activity#',
  			 0	 			 			 			 			 
  </cfquery>
</cfif>
<cfquery name="q_sighting" datasource="braddoro">
select sightingID, sightingDate, system, seen, seenBy, ship, activity
from braddoro.dyn_intel_sightings
where deleted = 0
order by sightingDate desc 
</cfquery>
<table style='font-family:"Microsoft Sans Serif",Verdana,Arial;font-size:.75em;' border="0">
<tr>
		<th>Date Seen</th>
		<th>System</th>
		<th>Target</th>
		<th>Seen By</th>
		<th>Ship</th>
		<th>Activity</th>															
</tr>
<cfoutput query="q_sighting">
<tr>
		<td>#dateFormat(sightingDate,"mm/dd/yyyy")# #timeFormat(sightingDate,"HH:mm")#</td>
		<td>#system#</td>
		<td>#seen#</td>
		<td>#ship#&nbsp;</td>
		<td>#activity#&nbsp;</td>
		<td>#seenBy#</td>																	
</tr>
</cfoutput>
</table>
</body>
</html>