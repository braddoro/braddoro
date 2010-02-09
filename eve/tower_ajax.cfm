<cfparam name="form.task" type="string" default="">
<cfset _html = "">
<cfset i_iconSize = 14>

<cfset s_pid = "">
<cfif isdefined("url.pid")>
	<cfset s_pid = url.pid>
<cfelse>
  <cfif isdefined("form.pid")>
	  <cfset s_pid = form.pid>
  </cfif>
</cfif>

<cfswitch expression="#form.task#">
<cfcase value="silo">

	<cfquery datasource="braddoro" name="q_silo">
		update dyn_pos_tower_reaction 
		set lastEmptyDate = now()
		where towerID = #val(form.towerID)#
		and reactionID = #val(form.reactionID)#
	</cfquery>

	<cfquery datasource="braddoro" name="q_owner">
		select T.towerID, R.reactionID, T.system, T.planet, T.moon, R.reaction, O.owner, TR.lastEmptyDate, R.hoursToFill, silos, 
		DATE_ADD(TR.lastEmptyDate, INTERVAL (hoursToFill*silos) HOUR) as 'emptyBefore',
		dateDiff(DATE_ADD(TR.lastEmptyDate, INTERVAL (hoursToFill*silos) HOUR),now()) as 'daysLeft',
		case TR.EorF when 'F' then 'Fill' when 'E' then 'Empty' else '' end as 'EorF',
		M.min*(R.outputModifier*72000) as 'income' 
		from dyn_pos_tower T
		inner join dyn_pos_tower_reaction TR
		    on T.towerID = TR.towerID
			and T.active = 1
		inner join cfg_pos_reactions R
		    on TR.reactionID = R.reactionID
		inner join dyn_pos_owners O
			on T.ownerID = O.ownerID
			and O.publicID = '#s_pid#'
		inner join cfg_eve_market M
			on M.eveID = R.eveID
		order by O.owner, T.system, T.planet, T.moon, R.reaction 	
	</cfquery>
<!--- 
select T.towerID, R.reactionID, T.system, T.planet, T.moon, R.reaction, O.owner, TR.lastEmptyDate, R.hoursToFill, silos, 
DATE_ADD(TR.lastEmptyDate, INTERVAL (hoursToFill*silos) HOUR) as 'emptyBefore',
dateDiff(DATE_ADD(TR.lastEmptyDate, INTERVAL (hoursToFill*silos) HOUR),now()) as 'daysLeft',
case TR.EorF when 'F' then 'Fill' when 'E' then 'Empty' else '' end as 'EorF' 
from dyn_pos_tower T
inner join dyn_pos_tower_reaction TR
    on T.towerID = TR.towerID
	and T.active = 1
inner join cfg_pos_reactions R
    on TR.reactionID = R.reactionID
inner join dyn_pos_owners O
	on T.ownerID = O.ownerID
	and O.publicID = '#s_pid#'
order by O.owner, T.system, T.planet, T.moon, R.reaction 	
 --->
	<cfset i_cols = 6>	
	<cfsavecontent variable="_html">
	<cfset s_class="">
	<table class="inputtable">
		<cfset i_cols = 6>
		<cfset i_income = 0>
		<cfoutput query="q_owner" group="owner">
			<tr>
				<td class="header" style="padding-right:5px;"></td>
				<td class="header" style="padding-right:5px;">System</td>			
				<td class="header" style="padding-right:5px;">Moon</td>
				<td class="header" style="padding-right:5px;">Reaction</td>
				<td class="header" style="padding-right:5px;">Days Left</td>
				<td class="header" style="padding-right:5px;">Income</td>
				
			</tr>
			<cfoutput>
				<cfset s_class="">
				<cfif daysLeft LT 2><cfset s_class="warn"></cfif>
				<tr style="cursor:default;" title="click to view">
					<td style="padding-right:5px;" class="#s_class#"><img src="Button-Pause-16x16.png" border="0" height="#i_iconSize#" width="#i_iconSize#" title="Update silo empty date." onclick="js_silo('div_reaction', '#towerID#','#reactionID#');"></td>
					<td style="padding-right:5px;" class="#s_class#">#system#</td>			
					<td align="right" style="padding-right:5px;" class="#s_class#">#planet#-#moon#</td>
					<td align="right" style="padding-right:5px;" class="#s_class#">#daysLeft#</td>
					<td style="padding-right:5px;" class="#s_class#">#reaction#</td>
					<td align="right" style="padding-right:5px;" class="#s_class#">#dollarFormat(income)#</td>
				</tr>
				<cfset i_income = i_income + income>
			</cfoutput>
		</cfoutput>
		<cfoutput>				
		<tr style="cursor:default;" title="click to view">
			<td class="header" style="padding-right:5px;" class="#s_class#">&nbsp;</td>
			<td class="header" style="padding-right:5px;" class="#s_class#">&nbsp;</td>			
			<td class="header" align="right" style="padding-right:5px;" class="#s_class#">&nbsp;</td>
			<td class="header" align="right" style="padding-right:5px;" class="#s_class#">&nbsp;</td>
			<td class="header" style="padding-right:5px;" class="#s_class#"><strong>Monthly Income</strong></td>
			<td class="header" align="right" style="padding-right:5px;" class="#s_class#"><strong>#dollarFormat(i_income)#</strong></td>
		</tr>
		</cfoutput>	
	</table>

<!--- 
	<table class="inputtable">
		<cfoutput query="q_reaction" group="owner">
			<tr style="cursor:default;" title="click to view">
				<td colspan="#i_cols#"><strong>#owner#</strong></td>
			</tr>
			<tr>
				<td class="header" style="padding-right:5px;"></td>
				<td class="header" style="padding-right:5px;">System</td>			
				<td class="header" style="padding-right:5px;">Planet</td>
				<td class="header" style="padding-right:5px;">Moon</td>
				<td class="header" style="padding-right:5px;">Reaction</td>
				<td class="header" style="padding-right:5px;">Emptied on</td>
				<td class="header" style="padding-right:5px;">Days Left</td>
				<td class="header" style="padding-right:5px;">Fill or Empty</td>
				<td class="header" style="padding-right:5px;">Empty Before</td>
				<td class="header" style="padding-right:5px;">Silos</td>
			</tr>
			<cfoutput>
				<cfset s_class="">
				<cfif daysLeft LT 2><cfset s_class="warn"></cfif>
				<tr style="cursor:default;" title="click to view">
					<td style="padding-right:5px;" class="#s_class#"><img src="Button-Pause-16x16.png" border="0" height="#i_iconSize#" width="#i_iconSize#" title="Update silo empty date." onclick="js_silo('div_reaction', '#towerID#','#reactionID#');"></td>
					<td style="padding-right:5px;" class="#s_class#">#system#</td>			
					<td align="right" style="padding-right:5px;" class="#s_class#">#planet#</td>
					<td align="right" style="padding-right:5px;" class="#s_class#">#moon#</td>
					<td style="padding-right:5px;" class="#s_class#">#reaction#</td>
					<td align="right" style="padding-right:5px;" class="#s_class#">#dateformat(lastEmptyDate,"mm/dd/yyyy")# #timeformat(lastEmptyDate,"hh:mm TT")#</td>
					<td align="right" style="padding-right:5px;" class="#s_class#">#daysLeft#</td>
					<td align="right" style="padding-right:5px;" class="#s_class#">#EorF#</td>
					<td align="right" style="padding-right:5px;" class="#s_class#">#dateformat(emptyBefore,"mm/dd/yyyy")# #timeformat(emptyBefore,"hh:mm TT")#</td>
					<td align="right" style="padding-right:5px;" class="#s_class#">#silos#</td>
				</tr>
			</cfoutput>
		</cfoutput>
	</table>
 --->
	</cfsavecontent>
 
</cfcase>
</cfswitch>

<cfoutput>#_html#</cfoutput>