<?php
$s_filename = basename(__FILE__);
$s_pageName = "Sun Tzu &mdash; The Art of War";
$s_server = "65.175.107.2:3306";
$s_userName = "webapp";
$s_password = "alvahugh";
$s_db = "braddoro";

$o_conn = mysql_connect($server=$s_server,$username=$s_userName,$password=$s_password);
if (!$o_conn) {die_well(__LINE__,mysql_error());}
$o_sel = mysql_select_db($s_db);
if (!$o_sel) {die_well(__LINE__,mysql_error());}
$s_sql = "select P.ship_purpose, S.ship_name, F.slot, F.fitting, F.shipFittingID, F.shipID, F.shipPurposeID, P.description 
from braddoro.dyn_ship_fitting F
inner join braddoro.cfg_ship_type S
    on F.shipID = S.shipTypeID
inner join braddoro.cfg_ship_purpose P
on F.shipPurposeID = P.shipPurposeID
order by P.ship_purpose, S.ship_name, F.slot, F.fitting;";
$q_data = mysql_query($s_sql);
if (!$q_data) {die_well(__LINE__,mysql_error());}

$s_row = "";
$i_shipID = 0;
$i_shipPurposeID = 0;
while ($row = mysql_fetch_row($q_data)) {
	$ship_purpose	= $row[0];	
	$ship_name		= $row[1];		
	$slot			= $row[2];			
	$fitting		= $row[3];		
	$shipFittingID	= $row[4];	
	$shipID			= $row[5];
	$shipPurposeID	= $row[6];
	$description	= $row[7];
	if ($i_shipPurposeID != $shipPurposeID) {
		$s_row .= "<tr>";
		$s_row .= "<td colspan='4' class='body'>&nbsp;</td>";
		$s_row .= "</tr>";
		$s_row .= "<tr>";
		$s_row .= "<td colspan='4' class='head1'>$ship_purpose</td>";
		$s_row .= "</tr>";
		if ($description > "") {
			$s_row .= "<tr>";
			$s_row .= "<td colspan='4' class='caption'>$description</td>";
			$s_row .= "</tr>";
		}
	}
	if ($i_shipID != $shipID) {
		$s_row .= "<tr>";
		$s_row .= "<td>&nbsp;</td>";
		$s_row .= "<td colspan='3' class='head2'>$ship_name</td>";
		$s_row .= "</tr>";
	}
	$s_row .= "<tr>";
	$s_row .= "<td>&nbsp;</td>";
	$s_row .= "<td>&nbsp;</td>";
	$s_row .= "<td><strong>$slot</strong></td>";
	$s_row .= "<td>$fitting</td>";
	$s_row .= "</tr>";
	
	$i_shipID = $shipID;
	$i_shipPurposeID = $shipPurposeID;
}
mysql_free_result($q_data);
/*

<strong>Nidhoggur</strong><br/>
Damage Control II<br/>
Amarr Navy Energized Adaptive Nano Membrane<br/>
Amarr Navy Energized Adaptive Nano Membrane<br/>
Armor Explosive Hardener II<br/>
Capacitor Power Relay II<br/>
Capacitor Power Relay II<br/>
<br/>
Sensor Booster II, Scan Resolution<br/>
Sensor Booster II, Scan Resolution<br/>
Cap Recharger II<br/>
Cap Recharger II<br/>
Cap Recharger II<br/>
<br/>
Capital Remote Armor Repair System I<br/>
Capital Remote Armor Repair System I<br/>
Capital Remote Armor Repair System I<br/>
Capital Remote Armor Repair System I<br/>
[empty high slot]<br/>
<br/>
Large Trimark Armor Pump I<br/>
Large Trimark Armor Pump I<br/>
Large Trimark Armor Pump I<br/>
*/
?>




<html>
<head>
<title>Heavy Metal Ship Fitting Guide</title>
<style media="screen" type="text/css">
.body {font-family : Arial , Helvetica , sans-serif;background-color : #F1EFDE;font-size:.8em;}
.fit {font-family : Arial , Helvetica , sans-serif;background-color : #999999;font-size:.8em;}
.head0 {font-family : Arial , Helvetica , sans-serif;background-color : #F1EFDE;font-size:1.125em;font-weight:bold;}
.head1 {font-family : Arial , Helvetica , sans-serif;background-color : #999999;font-size:1em;font-weight:bold;}
.head2 {font-family : Arial , Helvetica , sans-serif;background-color : #F5F5F5;font-size:.9em;font-weight:bold;}
.caption {font-family :monospace;background-color : #999999;font-size:1em;}
}
</style>
</head>
<body class='body'>
<div class='head0'>Heavy Metal Ship Fitting Guide</div><br/>
<i>this is a rough draft it will get better someday</i><br/>
<i>send new ship fits to Shadrach Vor for inclusion</i><br/>
<br/>
<table class='' border='0'>
<?php echo $s_row; ?>
</table>
</body>
</html>