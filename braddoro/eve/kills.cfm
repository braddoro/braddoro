<cfparam name="form.killerAlliance" type="string" default="">
<cfparam name="form.killerCorp" type="string" default="">
<cfparam name="form.victim" type="string" default="">
<cfparam name="form.killedAlliance" type="string" default="">
<cfparam name="form.killedCorp" type="string" default="">
<cfparam name="form.system" type="string" default="">
<cfparam name="form.killer" type="string" default="">

<html>
<head>
<title>Free Worlds Alliance Killmail History</title>
</head>
<body>
<cfset b_debug = false>
<cfset i_killmailID = 0>
<cfoutput>
<h4>Free Worlds Alliance Killboard History</h4>
<a href="stats.cfm"><span class="large">Kill Stats</span></a>&nbsp;
<a href="kills.cfm"><span class="large">Kill History</span></a>&nbsp;
<a href="post.cfm"><span class="large">Post Kill</span></a><br><br>
<form id="myform" name="myform" action="kills.cfm" method="post">
Killer Alliance: <input type="text" id="killerAlliance" name="killerAlliance" value="#form.killerAlliance#"><br>
Killer Corp: <input type="text" id="killerCorp" name="killerCorp" value="#form.killerCorp#"><br>
Killer: <input type="text" id="killer" name="killer" value="#form.killer#"><br>
System: <input type="text" id="system" name="system" value="#form.system#"><br>
Killed Alliance: <input type="text" id="killedAlliance" name="killedAlliance" value="#form.killedAlliance#"><br>
Killed Corp: <input type="text" id="killedCorp" name="killedCorp" value="#form.killedCorp#"><br>
Victim: <input type="text" id="victim" name="victim" value="#form.victim#"><br>
<input type="submit" id="go" name="go" value="Search">
</form>
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
	day(k1.killmailDateTime) as 'killDay'
FROM braddoro.dyn_killmail k1
INNER JOIN braddoro.dyn_killmail_killers k2 
	ON k1.killmailID = k2.killmailID
WHERE k1.deleted = 0 
<cfif form.killerAlliance NEQ "">
	and k2.alliance like '%#form.killerAlliance#%'
</cfif>
<cfif form.killerCorp NEQ "">
	and k2.corp like '%#form.killerCorp#%'
</cfif>
<cfif form.victim NEQ "">
	and k1.victim like '%#form.victim#%'
</cfif>
<cfif form.killedAlliance NEQ "">
	and k1.alliance like '%#form.killedAlliance#%'
</cfif>
<cfif form.killedCorp NEQ "">
	and k1.corp like '%#form.killedCorp#%'
</cfif>
<cfif form.system NEQ "">
	and k1.system like '%#form.system#%'
</cfif>
<cfif form.killer NEQ "">
	and k2.name like '%#form.killer#%'
</cfif>
ORDER BY 
	k1.killmailDateTime DESC,
	k2.killmailID,
	k2.damageDone DESC,
	k2.name
</cfquery>
<script language="javascript">
function js_collapseThis(changeme) {
	if (document.getElementById(changeme).style.display == "block") {
		document.getElementById(changeme).style.display = "none";
	} else {
		document.getElementById(changeme).style.display = "block";
	}
}
</script>
<cfoutput query="q_kills" group="killYear">
	<div class=""><strong>Year: #killYear#</strong></div>	
	<cfset i_totalKills = 0>
	<cfoutput group="killMonth">
		<fieldset id="fieldset_killMonth_#val(killYear)##numberFormat(killMonth,'00')#" name="fieldset_killMonth_#val(killYear)##numberFormat(killMonth,'00')#">
		<legend onclick="js_collapseThis('div_killMonth_#val(killYear)##numberFormat(killMonth,'00')#');" style="cursor:pointer;">Month: #monthAsString(val(killMonth))# <span id="total_killMonth_#killYear##numberFormat(killMonth,'00')#"></span></legend>
		<div id="div_killMonth_#val(killYear)##numberFormat(killMonth,'00')#" name="div_killMonth_#val(killYear)##numberFormat(killMonth,'00')#" style="display:none;">
		<strong>Day: #killDay#</strong><br>
		<cfoutput group="killDay">
			<cfoutput group="killmailID">
				<table border='1' style='border-collapse:collapse;font-family:"Microsoft Sans Serif",Verdana,Arial;font-size:.75em;' cellspacing='0'>
					<tr>
					<td bgcolor="navy"><span style="color:white;font-weight:bold;">#dateFormat(killmailDateTime,"mm/dd/yyyy")# #timeFormat(killmailDateTime,"hh:mm TT")#</span></td>
					<td><span onclick="js_collapseThis('div_killers_#killmailID#');" title="Click to display/hide information." style="cursor:hand;"><strong>Killers</strong></span></td>
					<td><span onclick="js_collapseThis('div_items_#killmailID#');" title="Click to display/hide information." style="cursor:hand;"><strong>Items</strong></span></td>
					</tr>
					<tr>
					<td valign="top">
					<strong>#victim#</strong><br>
					<cfif killedAlliance NEQ "NONE">Alliance: #killedAlliance#<br></cfif>
					Corp: #killedCorp#<br>
					System: #system#<br>
					Ship: #destroyed#<br>
					<a href="show.cfm?n=#uniqueID#" target="_blank">[view killmail]</a>
					</td>
					<td valign="top"><span id="div_killers_#killmailID#" style="display:none;">
					<cfoutput>
						Name: <strong>#name#</strong> <cfif finalBlow>(laid the final blow)</cfif><br>
						<cfif alliance NEQ "NONE">Alliance: #alliance#<br></cfif>
						Corp: #corp#<br>
						Ship: #ship#<br>
						Weapon: #weapon#<br>
						Damage: #numberformat(damageDone)#<br>
						<br>
					</cfoutput>
					</span>
					</td>
					<td valign="top"><span id="div_items_#killmailID#" style="display:none;">
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
					</span>
					</td>
					</tr>
				</table>
				<br>
				<cfset i_totalKills = i_totalKills + 1>
			</cfoutput>
		</cfoutput>
		<cfif i_totalKills GT 0>
			Kills: #i_totalKills#
		<script language="javascript">
			document.getElementById("total_killMonth_#killYear##numberFormat(killMonth,'00')#").innerHTML = "&nbsp;::&nbsp;Kills: #i_totalKills#";
		</script>
		</cfif>
		</div>
		</fieldset>
		<cfset i_totalKills = 0>
	</cfoutput>
</cfoutput>
</body>
</html>