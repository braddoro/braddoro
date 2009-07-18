<!--- <span class="green">this is a color</span> --->
<!---  
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
Who Seen: <textarea rows="1" cols="30" name="seen" id="seen">#s_seen#</textarea>&nbsp;&bull;<br>
Ship Type: <input type="text" id="ship" name="ship" value="#s_ship#"><br>
Seen By: <input type="text" id="seenBy" name="seenBy" value="#s_seenBy#">&nbsp;&bull;<br>
Activity: <textarea rows="3" cols="30" name="activity" id="activity">#s_activity#</textarea><br>
<input type="submit" id="go" name="go" value="#s_value#">&nbsp;<a href="sightings.cfm?pid=#s_pid#">clear</a><br>
</form>
</cfoutput>
--->



<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>FWA Fleet Manager</title>
<link href="/css/global.css" media="screen" rel="stylesheet" type="text/css" ></head> 
<body>
<h2 align="center">FWA Fleet Manager</h2>

<h3>Loadout Maintenance</h3>
<form action="/fleetsetup/setup?fleet_id=10005" method="post">
<input type="hidden" name="id" value="">
<input type="hidden" name="flag" value="save">
<input type="hidden" name="pilot_name" value="Shadrach Vor">
<input type="hidden" name="fleet_id" value="10005">

<table width="700">
<tr>
<tr><td>Pilot: Shadrach Vor</td></tr>
<tr><td>Corp: JASDIP</td></tr>
<tr><td>Alliance: Free Worlds Alliance</td></tr>
</tr>
</table>

<table border="1" cellspacing="0" cellpadding="1" width="650" style="border-color: #555555;">
<tr style="background-color: #444444;">
<td id="ship_type-label" width="150" valign="middle"><label for="ship_type" class="optional">Ship Types:</label></td>
<td class="element" valign="middle">
<select name="ship_type" id="ship_type">
<option value="7" label="Assault Ship" >Assault Ship</option><option value="10" label="Battlecruiser" >Battlecruiser</option><option value="3" label="Battleship" >Battleship</option><option value="25" label="Black Ops" >Black Ops</option><option value="22" label="Capital Industrial Ship" >Capital Industrial Ship</option><option value="15" label="Carrier" >Carrier</option><option value="27" label="Combat Recon Ship" >Combat Recon Ship</option><option value="13" label="Command Ship" >Command Ship</option><option value="17" label="Covert Ops" >Covert Ops</option><option value="2" label="Cruiser" >Cruiser</option><option value="11" label="Destroyer" >Destroyer</option><option value="12" label="Dreadnought" >Dreadnought</option><option value="23" label="Electronic Attack Ship" >Electronic Attack Ship</option><option value="20" label="Force Recon Ship" >Force Recon Ship</option><option value="1" label="Frigate" >Frigate</option><option value="8" label="Heavy Assault Ship" >Heavy Assault Ship</option><option value="24" label="Heavy Interdictor" >Heavy Interdictor</option><option value="4" label="Industrial" >Industrial</option><option value="28" label="Industrial Command Ship" >Industrial Command Ship</option><option value="18" label="Interceptor" >Interceptor</option><option value="14" label="Interdictor" >Interdictor</option><option value="19" label="Logistics" >Logistics</option><option value="26" label="Marauder" >Marauder</option><option value="16" label="Mothership" >Mothership</option><option value="6" label="Rookie ship" >Rookie ship</option><option value="21" label="Stealth Bomber" >Stealth Bomber</option><option value="29" label="Strategic Cruiser" >Strategic Cruiser</option><option value="5" label="Titan" >Titan</option><option value="9" label="Transport Ship" >Transport Ship</option></select></td>
<td rowspan="18" valign="top" width="330" style="padding-left: 30px; background-color: #444444;">
<h3>Fleet Summary</h3>
Damp: <span style="color: #00ff00;">0</span><br>
Track: <span style="color: #00ff00;">0</span><br>
Point: <span style="color: #00ff00;">0</span><br>
Scram: <span style="color: #00ff00;">0</span><br>
Web: <span style="color: #00ff00;">0</span><br>
Sensor Boost: <span style="color: #00ff00;">0</span><br>
Paint: <span style="color: #00ff00;">0</span><br>
ECM - Multi: <span style="color: #00ff00;">0</span><br>
ECM - Grav: <span style="color: #00ff00;">0</span><br>
ECM - Ladar: <span style="color: #00ff00;">0</span><br>
ECM - Magnet: <span style="color: #00ff00;">0</span><br>
ECM - Radar: <span style="color: #00ff00;">0</span><br>
Scanner: <span style="color: #00ff00;">0</span><br>
Remote Armor Repair: <span style="color: #00ff00;">0</span><br>
Energy Transfer: <span style="color: #00ff00;">0</span><br>
Shield Transport: <span style="color: #00ff00;">0</span><br>
<br>
<a href="/fleetsetup/detail?fleet_id=10005">View Fleet Details</a>
</td>
</tr>
<tr style="background-color: #222222;"><td id="ship-label" valign="middle"><label for="ship" class="required">Ship (merlin,rifter):</label></td>
<td class="element" valign="middle">
<input type="text" name="ship" id="ship" value="" size="15"></td></tr>

<tr style="background-color: #444444;"><td id="damp-label" valign="middle"><label for="damp" class="optional">Dampeners:</label></td>
<td class="element" valign="middle">
<select name="damp">
<option value="0" selected>0</option><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option></select>
</td></tr>
<tr style="background-color: #222222;"><td id="track-label" valign="middle"><label for="track" class="optional">Tracking Disruptor:</label></td>
<td class="element" valign="middle">
<select name="track">
<option value="0" selected>0</option><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option></select></td></tr>
<tr style="background-color: #444444;"><td id="point-label" valign="middle"><label for="point" class="optional">Warp Disruptor:</label></td>
<td class="element" valign="middle">
<select name="point">
<option value="0" selected>0</option><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option></select></td></tr>
<tr style="background-color: #222222;"><td id="scram-label" valign="middle"><label for="scram" class="optional">Warp Scrambler:</label></td>
<td class="element" valign="middle">
<select name="scram">
<option value="0" selected>0</option><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option></select></td></tr>
<tr style="background-color: #444444;"><td id="web-label" valign="middle"><label for="web" class="optional">Webifier:</label></td>

<td class="element" valign="middle">
<select name="web">
<option value="0" selected>0</option><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option></select></td></tr>
<tr style="background-color: #222222;"><td id="sensor_boost-label" valign="middle"><label for="sensor_boost" class="optional">Sensor Booster:</label></td>
<td class="element" valign="middle">
<select name="sensor_boost">
<option value="0" selected>0</option><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option></select></td></tr>
<tr style="background-color: #444444;"><td id="paint-label" valign="middle"><label for="paint" class="optional">Target Painter:</label></td>
<td class="element" valign="middle">
<select name="paint">
<option value="0" selected>0</option><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option></select></td></tr>
<tr style="background-color: #222222;"><td id="ecm_multi-label" valign="middle"><label for="ecm_multi" class="optional">Multi Spectum Jammer:</label></td>
<td class="element" valign="middle">
<select name="ecm_multi">
<option value="0" selected>0</option><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option></select></td></tr>
<tr style="background-color: #444444;"><td id="ecm_grav-label" valign="middle"><label for="ecm_grav" class="optional">ECM - Gravimetric:</label></td>
<td class="element" valign="middle">

<select name="ecm_grav">
<option value="0" selected>0</option><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option></select></td></tr>
<tr style="background-color: #222222;"><td id="ecm_ladar-label" valign="middle"><label for="ecm_ladar" class="optional">ECM - Ladar:</label></td>
<td class="element" valign="middle">
<select name="ecm_ladar">
<option value="0" selected>0</option><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option></select></td></tr>
<tr style="background-color: #444444;"><td id="ecm_magnet-label" valign="middle"><label for="ecm_magnet" class="optional">ECM - Magnetometric:</label></td>
<td class="element" valign="middle">
<select name="ecm_magnet">
<option value="0" selected>0</option><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option></select></td></tr>
<tr style="background-color: #222222;"><td id="ecm_radar-label" valign="middle"><label for="ecm_radar" class="optional">ECM - Radar:</label></td>
<td class="element">
<select name="ecm_radar" valign="middle">
<option value="0" selected>0</option><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option></select></td></tr>
<tr style="background-color: #444444;"><td id="scanner-label" valign="middle"><label for="scanner" class="optional">Ship Scanner:</label></td>
<td class="element" valign="middle">
<select name="scanner">
<option value="0" selected>0</option><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option></select></td></tr>

<tr style="background-color: #222222;"><td id="remote_rep-label" valign="middle"><label for="remote_rep" class="optional">Remote Armor Rep:</label></td>
<td class="element" valign="middle">
<select name="remote_rep">
<option value="0" selected>0</option><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option></select></td></tr>

<tr style="background-color: #444444;"><td id="energy_transfer-label" valign="middle"><label for="energy_transfer" class="optional">Energy Transfer:</label></td>
<td class="element" valign="middle">
<select name="energy_transfer">
<option value="0" selected>0</option><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option></select></td></tr>

<tr style="background-color: #222222;"><td id="shield_transport-label" valign="middle"><label for="shield_transport" class="optional">Shield Transport:</label></td>
<td class="element" valign="middle">
<select name="shield_transport">
<option value="0" selected>0</option><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option></select></td></tr>
</table>




<input type="submit" value="Update Loadout"> 
</form>

</body>
</html>
