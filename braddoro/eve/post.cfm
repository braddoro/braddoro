<html>
<head>
<title>Free Worlds Alliance Post Killmail</title>
</head>
<body>
<cfset b_debug = false>
<cfset i_killmailID = 0>
<cfoutput>
<h4>Free Worlds Alliance Killmail Posting</h4>
<form id="myform" name="myform" action="post.cfm" method="post">
<textarea id="killmail" name="killmail" rows="5" cols="40"></textarea><br>
<input type="submit" id="go" name="go" value="Add Killmail">
</form>
<cfif isdefined("form.killmail") and trim(form.killmail) NEQ "">
	<cfset s_killDateTime = "">
	<cfset s_victim = "">
	<cfset s_alliance = "">
	<cfset s_corp = "">	
	<cfset s_destroyed = "">	
	<cfset s_damageTaken = "">	
	<cfset s_system = "">	
	<cfset s_security = "">	
	<cfset s_name2 = "">
	<cfset s_security2 = "">
	<cfset s_alliance2 = "">
	<cfset s_corp2 = "">
	<cfset s_ship2 = "">
	<cfset s_weapon2 = "">
	<cfset s_damageDone2 = "">
	<cfset s_item = "">
	<cfset i_quantity = 1>
	<cfset s_quantity = "">	
	<cfset s_item2 = "">
	<cfset b_finalBlow = false>
	<cfset b_cargo = false>
	<cfset b_drone = false>
	<cfset b_dropped = false>
	<cfset b_destroyedItems = false>
	<cfset b_droppedItems = false>
	<cfset b_duplicate = false>
	<cfset i_lineNo = 1>
	<cfloop index="line" list="#form.killmail#" delimiters="#chr(10)#">
		<cfif s_killDateTime EQ "">
			<cfset s_killDateTime = line>
		</cfif>
		<!--- #i_lineNo# - #s_killDateTime# --->
		<cfset s_string = "Victim: ">
		<cfif left(line,len(s_string)) EQ s_string  and i_lineNo LTE 9>
			<cfset s_victim = mid(line,len(s_string),len(line)-len(s_string))>
		</cfif>
		<cfset s_string = "Alliance: ">
		<cfif left(line,len(s_string)) EQ s_string and i_lineNo LTE 9>
			<cfset s_alliance = mid(line,len(s_string),len(line)-len(s_string))>
		</cfif>
		<cfset s_string = "Corp: ">
		<cfif left(line,len(s_string)) EQ s_string and i_lineNo LTE 9>
			<cfset s_corp = mid(line,len(s_string),len(line)-len(s_string))>
		</cfif>
		<cfset s_string = "Destroyed: ">
		<cfif left(line,len(s_string)) EQ s_string and i_lineNo LTE 9>
			<cfset s_destroyed = mid(line,len(s_string),len(line)-len(s_string))>
		</cfif>
		<cfset s_string = "Damage Taken: ">
		<cfif left(line,len(s_string)) EQ s_string and i_lineNo LTE 9>
			<cfset s_damageTaken = mid(line,len(s_string),len(line)-len(s_string))>
		</cfif>
		<cfset s_string = "System: ">
		<cfif left(line,len(s_string)) EQ s_string and i_lineNo LTE 9>
			<cfset s_system = mid(line,len(s_string),len(line)-len(s_string))>
		</cfif>
		<cfset s_string = "Security: ">
		<cfif left(line,len(s_string)) EQ s_string and i_lineNo LTE 9>
			<cfset s_security = mid(line,len(s_string),len(line)-len(s_string))>
		</cfif>
		<cfif i_lineNo EQ 9>
			<cfquery name="q_check" datasource="braddoro">
				select killmailID 
				from braddoro.dyn_killmail 
				where killmailDateTime = '#s_killDateTime#'
				and victim = '#trim(s_victim)#'
			</cfquery>
			<cfif val(q_check.killmailID) GT 0>
				<cfset b_duplicate = true>
				<cfbreak>
			</cfif>
			<cfquery name="q_killmail" datasource="braddoro">
				insert into braddoro.dyn_killmail (killmailDateTime, victim, alliance, corp, destroyed, damageTaken, system, security, uniqueID)
				select '#dateformat(s_killDateTime,"yyyy-mm-dd")# #timeformat(s_killDateTime,"HH:mm:ss")#', '#trim(s_victim)#', '#trim(s_alliance)#', '#trim(s_corp)#', '#trim(s_destroyed)#', #val(s_damageTaken)#, '#trim(s_system)#', #val(s_security)#, UUID();
			</cfquery>
			<cfif b_debug>
				select '#s_killDateTime#', '#trim(s_victim)#', '#trim(s_alliance)#', '#trim(s_corp)#', '#trim(s_destroyed)#', #val(s_damageTaken)#, '#trim(s_system)#', #val(s_security)#;
				<br>
			</cfif>
			<cfquery name="q_getID" datasource="braddoro">
				select max(killmailID) as 'newID' from braddoro.dyn_killmail;
			</cfquery>
			<cfset i_killmailID = q_getID.newID>
			<cfquery name="q_killmail" datasource="braddoro">
				insert into braddoro.dyn_killmail_text (killmailID, killmailText)
				select #val(i_killmailID)#, '#form.killmail#'
			</cfquery>
			<cfif b_debug>
				select #val(i_killmailID)#, '#form.killmail#'
				<br>
			</cfif>
		</cfif>
		<cfif i_lineNo GT 9>
			<cfset s_string = "Name: ">
			<cfif left(line,len(s_string)) EQ s_string  and i_lineNo GT 9>
				<cfset s_name2 = mid(line,len(s_string),len(line)-len(s_string))>
				<cfif line contains "(laid the final blow)">
					<cfset b_finalBlow = 1>
					<cfset s_name2 = replaceNoCase(s_name2," (laid the final blow)","","All")>
				<cfelse>
					<cfset b_finalBlow = 0>
				</cfif>
			</cfif>
			<cfset s_string = "Security: ">
			<cfif left(line,len(s_string)) EQ s_string and i_lineNo GT 9>
				<cfset s_security2 = mid(line,len(s_string),len(line)-len(s_string))>
			</cfif>
			<cfset s_string = "Alliance: ">
			<cfif left(line,len(s_string)) EQ s_string and i_lineNo GT 9>
				<cfset s_alliance2 = mid(line,len(s_string),len(line)-len(s_string))>
			</cfif>
			<cfset s_string = "Corp: ">
			<cfif left(line,len(s_string)) EQ s_string and i_lineNo GT 9>
				<cfset s_corp2 = mid(line,len(s_string),len(line)-len(s_string))>
			</cfif>
			<cfset s_string = "Ship: ">
			<cfif left(line,len(s_string)) EQ s_string and i_lineNo GT 9>
				<cfset s_ship2 = mid(line,len(s_string),len(line)-len(s_string))>
			</cfif>
			<cfset s_string = "Weapon: ">
			<cfif left(line,len(s_string)) EQ s_string and i_lineNo GT 9>
				<cfset s_weapon2 = mid(line,len(s_string),len(line)-len(s_string))>
			</cfif>
			<cfset s_string = "Damage Done: ">
			<cfif left(line,len(s_string)) EQ s_string and i_lineNo GT 9>
				<cfset s_damageDone2 = mid(line,len(s_string),len(line)-len(s_string))>
			</cfif>
			<cfif s_damageDone2 NEQ "">
				<cfquery name="q_killers" datasource="braddoro">
					insert into braddoro.dyn_killmail_killers (killmailID, name, security, alliance, corp, ship, weapon, damageDone, finalBlow)
					select #val(i_killmailID)#, '#trim(s_name2)#', #val(s_security2)#, '#trim(s_alliance2)#', '#trim(s_corp2)#', '#trim(s_ship2)#', '#trim(s_weapon2)#', #val(s_damageDone2)#, #b_finalBlow#;
				</cfquery>
				<cfif b_debug>
					select #val(i_killmailID)#, '#trim(s_name2)#', #val(s_security2)#, '#trim(s_alliance2)#', '#trim(s_corp2)#', '#trim(s_ship2)#', '#trim(s_weapon2)#', #val(s_damageDone2)#, #b_finalBlow#;
					<br>
				</cfif>
				<cfset s_name2 = "">
				<cfset b_finalBlow = 0>
				<cfset s_security2 = "">
				<cfset s_alliance2 = "">
				<cfset s_corp2 = "">
				<cfset s_ship2 = "">
				<cfset s_weapon2 = "">
				<cfset s_damageDone2 = "">
			</cfif>
		</cfif>
		<cfif line CONTAINS "Destroyed items:" and not b_droppedItems>
			<cfset b_destroyedItems = true>
		</cfif>
		<cfif b_destroyedItems and not b_droppedItems and line NEQ "" and not line CONTAINS "Destroyed items:">
			<cfset s_item = line>
			<cfif line CONTAINS "(Cargo)">
				<cfset b_cargo = true>
				<cfset s_item = replaceNoCase(s_item," (Cargo)","","All")>
			</cfif>
			<cfif line CONTAINS "(Drone Bay)">
				<cfset b_drone = true>
				<cfset s_item = replaceNoCase(s_item," (Drone Bay)","","All")>
			</cfif>
			<cfif s_item CONTAINS ",">
				<cfset s_item2 = listGetAt(s_item,1)>
				<cfset s_quantity = listGetAt(s_item,2)>
				<cfset s_quantity = replaceNoCase(s_quantity,"Qty:","","All")>
				<cfset i_quantity = val(trim(s_quantity))>
				<cfset s_item = s_item2>
			</cfif>
			<cfif trim(s_item) NEQ "" and not s_item contains "Dropped items:">
				<cfquery name="q_destroyed" datasource="braddoro">
					insert into braddoro.dyn_killmail_items (killmailID, item, quantity, cargo, drone, dropped)
					select #val(i_killmailID)#, '#trim(s_item)#', #val(i_quantity)#, #b_cargo#, #b_drone#, false
				</cfquery>
				<cfif b_debug>
					select #val(i_killmailID)#, '#trim(s_item)#', #val(i_quantity)#, #b_cargo#, #b_drone#, false
					<br>
				</cfif>
			</cfif>
			<cfset s_item = "">
			<cfset i_quantity = 1>
			<cfset s_quantity = "">
			<cfset b_cargo = false>
			<cfset b_drone = false>
			<cfset s_item2 = "">
		</cfif>
		<cfif line CONTAINS "Dropped items:" and not b_droppedItems>
			<cfset b_droppedItems = true>
		</cfif>
		<cfif b_droppedItems and line NEQ "" AND NOT line CONTAINS "Dropped items:">
			<cfset s_item = line>
			<cfif s_item CONTAINS ",">
				<cfset s_item2 = listGetAt(s_item,1)>
				<cfset s_quantity = listGetAt(s_item,2)>
				<cfset s_quantity = replaceNoCase(s_quantity,"Qty:","","All")>
				<cfset i_quantity = val(trim(s_quantity))>
				<cfset s_item = s_item2>
			</cfif>
			<cfif trim(s_item) NEQ "">			
				<cfquery name="q_dropped" datasource="braddoro">
					insert into braddoro.dyn_killmail_items (killmailID, item, quantity, cargo, drone, dropped)
					select #val(i_killmailID)#, '#trim(s_item)#', #val(i_quantity)#, 0, 0, true
				</cfquery>
				<cfif b_debug>
					select #val(i_killmailID)#, '#trim(s_item)#', #val(i_quantity)#, 0, 0, true
					<br>
				</cfif>
			</cfif>
			<cfset s_item = "">
			<cfset i_quantity = 1>
			<cfset s_item2 = "">
		</cfif>
		<cfset i_lineNo = i_lineNo + 1>
	</cfloop>
	Thanks for uploading.
</cfif>
</cfoutput>
<cfquery name="q_kills" datasource="braddoro">
SELECT 
	k1.killmailID, 
	k1.killmailDateTime, 
	k1.victim, 
	k1.alliance as 'killedAlliance', 
	k1.corp as 'killedCorp', 
	k1.destroyed, 
	k1.damageTaken, 
	k1.system, 
	k1.security as 'killedSecurity', 
	k1.uniqueID,
	k2.killerID, 
	k2.name, 
	k2.security, 
	k2.alliance, 
	k2.corp, 
	k2.ship, 
	k2.weapon, 
	k2.damageDone, 
	k2.finalBlow,
	year(k1.killmailDateTime) as 'killYear',
	month(k1.killmailDateTime) as 'killMonth',
	week(k1.killmailDateTime) as 'killWeek',
	day(k1.killmailDateTime) as 'killDay'
FROM braddoro.dyn_killmail k1
INNER JOIN braddoro.dyn_killmail_killers k2 
	ON k1.killmailID = k2.killmailID
WHERE k1.killmailID = #val(i_killmailID)#
ORDER BY 
	k1.killmailDateTime DESC,
	k2.killmailID,
	k2.damageDone DESC,
	k2.name
</cfquery>
<cfoutput query="q_kills">
	<table border='1' style='border-collapse:collapse;font-family:"Microsoft Sans Serif",Verdana,Arial;' cellspacing='0'>
		<tr>
		<td bgcolor="navy"><span style="color:white;font-weight:bold;">#dateFormat(killmailDateTime,"mm/dd/yyyy")# #timeFormat(killmailDateTime,"hh:mm TT")#</span></td>
		<td><strong>Killers</strong></td>
		<td><strong>Items</strong></td>
		</tr>
		<tr>
		<td valign="top">
		<strong>#victim#</strong><br>
		<cfif killedAlliance NEQ "NONE">Alliance: #killedAlliance#<br></cfif>
		Corp: #killedCorp#<br>
		System: #system#<br>
		Ship: #destroyed#<br>
		</td>
		<td valign="top">
		<cfoutput>
			Name: <strong>#name#</strong> <cfif finalBlow>(laid the final blow)</cfif><br>
			<cfif alliance NEQ "NONE">Alliance: #alliance#<br></cfif>
			Corp: #corp#<br>
			Ship: #ship#<br>
			Weapon: #weapon#<br>
			Damage: #numberformat(damageDone)#<br>
			<br>
		</cfoutput>
		</td>
		<td valign="top">
		<cfquery datasource="braddoro" name="q_items">
			select item, quantity, drone, cargo, dropped
			from braddoro.dyn_killmail_items
			where killmailID = #killmailID#
			order by dropped, item
		</cfquery>
		<strong>Destroyed</strong><br>
		<cfset b_dropped = false>
		<cfloop query="q_items">
			<cfif dropped and not b_dropped><br><strong>Dropped</strong><br><cfset b_dropped = true></cfif>
			#item# <cfif quantity GT 1>(#numberformat(quantity)#) </cfif><cfif cargo>(cargo)</cfif><cfif drone>(drone)</cfif><br>
		</cfloop>
		</td>
		</tr>
	</table>
	<!--- <cfquery name="q_killmail" datasource="braddoro">
	select uniqueID, killmailText 
	from braddoro.dyn_killmail_text k2
	inner join braddoro.dyn_killmail k1
	on k1.killmailID = k2.killmailID
	where killmailID = #killmailID#
	</cfquery> --->
</cfoutput>
</body>
</html>