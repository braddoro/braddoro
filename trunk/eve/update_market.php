<?php
header("Cache: private");
setlocale(LC_MONETARY, 'en_US');

$showOutput=0;
if (isset($_REQUEST["showOutput"])) {
	$showOutput = intval($_REQUEST["showOutput"]);
} else {
	if (isset($_POST["showOutput"])) {
		$showOutput = intval($_POST["showOutput"]);
	}
}
$force="";
if (isset($_REQUEST["force"])) {
	$force = "Yes";
} else {
	if (isset($_POST["force"])) {
		$force = "Yes";
	}
}

$g_break = chr(10).chr(13);
$s_server = "65.175.107.2:3306";
$s_userName = "webapp";
$s_password = "alvahugh";
$s_db = "braddoro";
$o_conn = mysql_connect($server=$s_server,$username=$s_userName,$password=$s_password);
if (!$o_conn) {die_well(mysql_error());}
$o_sel = mysql_select_db($s_db);
if (!$o_sel) {die_well(mysql_error());}
if ($force > "") {
	$s_sql = "SELECT eveID, type FROM braddoro.cfg_eve_market;";
} else {
	$s_sql = "SELECT eveID, type FROM braddoro.cfg_eve_market WHERE dateUpdated < DATE_ADD(NOW(), INTERVAL -1 DAY);";	
}
$q_data = mysql_query($s_sql);
if (!$q_data) {die_well(mysql_error());}
$i_rows = 0;
while ($rowData = mysql_fetch_row($q_data)) {
	$i_eveID = 0;
	$s_itemname = "";
	$i_volume = 0;
	$i_avg = 0;
	$i_min = 0;
	$i_max = 0;
	$i_stddev = 0;
	$i_median = 0;
	$i_eveID = $rowData[0];
	$s_type = $rowData[1];
	if ($i_eveID > 0) {
		$s_pageName = "http://eve-central.com/api/quicklook?typeid=".$i_eveID."&regionlimit=10000002"; 
		$xml = @simplexml_load_file($s_pageName) or die ("no file loaded"); 
		$o_currentNode = $xml->xpath("/evec_api/quicklook");
		foreach ($o_currentNode as $s_node) {
			$s_itemname = $s_node->itemname;
		}
		$s_pageName = "http://api.eve-central.com/api/marketstat?typeid=".$i_eveID."&regionlimit=10000002"; 
		$xml = @simplexml_load_file($s_pageName) or die ("no file loaded"); 
		$o_currentNode = $xml->xpath("/evec_api/marketstat/type/".$s_type."");
		foreach ($o_currentNode as $s_node) {
			$i_volume = $s_node->volume;
			$i_avg = $s_node->avg;
			$i_min = $s_node->min;
			$i_max = $s_node->max;
			$i_stddev = $s_node->stddev; 
			$i_median = $s_node->median; 
		}
		$s_sql = "update braddoro.cfg_eve_market set itemName = '".$s_itemname."', volume = ".$i_volume.", avg = ".$i_avg.", min = ".$i_min.", max = ".$i_max.", stddev = ".$i_stddev.", median = ".$i_median.", type = '".$s_type."', dateUpdated = '".date('Y-m-d H:i:00')."' where eveID = ".$i_eveID." and type = '".$s_type."';";
		$q_update = mysql_query($s_sql);
		if (!$q_update) {die_well(mysql_error());}
	}
	$i_rows++;
}
function die_well($error="") {
	echo $line.": ".$error;
	exit;
}
echo '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'.$g_break; 
echo '<html xmlns="http://www.w3.org/1999/xhtml">'.$g_break;
echo '<head>'.$g_break;
echo '<meta name="generator" content="Eve market update tool." />'.$g_break; 
echo '<title>Eve market update tool.</title>'.$g_break; 
echo '<style type="text/css">'.$g_break; 
echo '.body {background-color: #F1EFDE;font-family: sans-serif;font-size: .8em}'.$g_break;
echo '.cell {text-align: right;}'.$g_break;
echo '</style>'.$g_break; 
echo '</head>'.$g_break; 
echo '<body class="body">'.$g_break;
echo 'Rows updated '.$i_rows.'.<br />'.$g_break;
if ($showOutput == 1) {
	echo '<table>'.$g_break;
	echo '<tr>'.$g_break;
	echo '<th>Eve ID</th>'.$g_break;
	echo '<th>Item Name</th>'.$g_break;
	echo '<th>Volume</th>'.$g_break;
	echo '<th>Average</th>'.$g_break;
	echo '<th>Minimum</th>'.$g_break;
	echo '<th>Maximum</th>'.$g_break;
	echo '<th>Std. Dev.</th>'.$g_break;
	echo '<th>Median</th>'.$g_break;
	echo '</tr>'.$g_break;
	$s_sql = 'select eveID, itemName, volume, avg, min, max, stddev, median FROM braddoro.cfg_eve_market order by itemName;';
	$q_data = mysql_query($s_sql);
	if (!$q_data) {die_well(mysql_error());}
	while ($rowData = mysql_fetch_row($q_data)) {
		echo '<tr>'.$g_break;
		echo '<td>'.$rowData[0].'</td>'.$g_break;
		echo '<td>'.$rowData[1].'</td>'.$g_break;
		echo '<td class="cell">'.number_format($rowData[2]).'</td>'.$g_break;
		echo '<td class="cell">$'.number_format($rowData[3],2).'</td>'.$g_break;
		echo '<td class="cell">$'.number_format($rowData[4],2).'</td>'.$g_break;
		echo '<td class="cell">$'.number_format($rowData[5],2).'</td>'.$g_break;
		echo '<td class="cell">$'.number_format($rowData[6],2).'</td>'.$g_break;
		echo '<td class="cell">$'.number_format($rowData[7],2).'</td>'.$g_break;
		echo '</tr>'.$g_break;
	}
	echo '</table>'.$g_break;
}
echo '</body>'.$g_break; 
echo '</html>'.$g_break;
?>