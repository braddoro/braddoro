<?php
$s_filename = basename(__FILE__);
$s_pageName = "Ship Fitting";
$server		= "65.175.107.2:3306";
$username	= "webapp";
$password	= "alvahugh";
$dbname		= "braddoro";
$o_conn = mysql_connect($server,$username,$password);
if (!$o_conn) {die_well(__LINE__,mysql_error());}
$o_sel = mysql_select_db($dbname);
if (!$o_sel) {die_well(__LINE__,mysql_error());}
$s_sql = "select fitID, purpose, shipName, slot, module from braddoro.dyn_ship_fitting2 order by purpose, shipName, slot, module";
$q_data = mysql_query($s_sql);
if (!$q_data) {die_well(__LINE__,mysql_error());}
$purpose_hold = "";
$shipName_hold = "";
$module_hold = "";
$i_same = 1;
$s_spacer = "&nbsp;&nbsp;&nbsp;&nbsp;";
$s_html = "";
$s_html .= '<table class="tabledata" cellpadding="0" cellspacing="0">';
while($row = mysql_fetch_array($q_data)) {
	$fitID = $row["fitID"];
	$purpose = $row["purpose"];
	$shipName = $row["shipName"];
	$slot = $row["slot"];
	$module = $row["module"];
	if ($purpose_hold != $purpose) {
		$s_html .= '<tr><td class="label0" colspan="4">'.$purpose.'</td></tr>';
	}
	if ($purpose_hold != $purpose || $shipName_hold != $shipName) {
		$s_html .= '<tr><td class="label0">'.$s_spacer.'</td><td class="label0" colspan="3">'.$shipName.'</td></tr>';
	}
	$s_html .= '<tr><td class="label">'.$s_spacer.'</td><td class="label">&nbsp;</td><td class="label">'.$slot.'</td><td class="label">'.$module.'</td></tr>';
	$purpose_hold = $purpose;
	$shipName_hold = $shipName;
	$module_hold = $module;
}
$s_html .= '</table>';
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
<title>FWA Ship Fitting Guide</title>
<link rel="stylesheet" href="input.css" type="text/css">
<script language="javascript" type="text/javascript" src="input.js"></script>
</head>
<body>
<div class="fontfamily s5">FWA Ship Fitting Guide</div><br/>
<?php echo $s_html; ?>
</body>
</html>
