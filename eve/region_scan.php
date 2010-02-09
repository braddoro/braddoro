<?php
header("Cache: private");
setlocale(LC_MONETARY, 'en_US');

$i_output=1;
if (isset($_REQUEST["output"])) {
	$i_output = intval($_REQUEST["output"]);
} else {
	if (isset($_POST["output"])) {
		$i_output = intval($_POST["output"]);
	}
}
/*
$i_insert=0;
if (isset($_REQUEST["insert"])) {
	$i_insert = intval($_REQUEST["insert"]);
} else {
	if (isset($_POST["insert"])) {
		$i_insert = intval($_POST["insert"]);
	}
}
*/
$i_delete=0;
if (isset($_REQUEST["delete"])) {
	$i_delete = intval($_REQUEST["delete"]);
} else {
	if (isset($_POST["delete"])) {
		$i_delete = intval($_POST["delete"]);
	}
}
$i_eveID=0;
if (isset($_REQUEST["eveID"])) {
	$i_eveID = intval($_REQUEST["eveID"]);
} else {
	if (isset($_POST["eveID"])) {
		$i_eveID = intval($_POST["eveID"]);
	}
}
$i_dir=1;
if (isset($_REQUEST["dir"])) {
	$i_dir = intval($_REQUEST["dir"]);
} else {
	if (isset($_POST["dir"])) {
		$i_dir = intval($_POST["dir"]);
	}
}
$i_sort=1;
if (isset($_REQUEST["sort"])) {
	$i_sort = intval($_REQUEST["sort"]);
} else {
	if (isset($_POST["sort"])) {
		$i_sort = intval($_POST["sort"]);
	}
}
function die_well($error="",$detail="") {
	echo $line.": ".$error." Detail: ".$detail;
	exit;
}
$s_sort = "";
$g_break = chr(10).chr(13);
$s_server = "65.175.107.2:3306";
$s_userName = "webapp";
$s_password = "alvahugh";
$s_db = "braddoro";
$o_conn = mysql_connect($server=$s_server,$username=$s_userName,$password=$s_password);
if (!$o_conn) {die_well(mysql_error());}
$o_sel = mysql_select_db($s_db);
if (!$o_sel) {die_well(mysql_error());}
if ($i_delete == 1) {
	$s_sql = 'delete FROM braddoro.cfg_eve_market_region;';
	$q_data = mysql_query($s_sql);
	if (!$q_data) {die_well(mysql_error());}
}

if ($i_eveID > 0) {
	$s_sql = "SELECT regionID, regionName FROM braddoro.cfg_eve_regions order by regionName;";
	$q_data = mysql_query($s_sql);
	if (!$q_data) {die_well(mysql_error());}
	$i_rows = 0;
	while ($rowData = mysql_fetch_row($q_data)) {
		$i_volume = 0;
		$i_avg = 0;
		$i_min = 0;
		$i_max = 0;
		$i_stddev = 0;
		$i_median = 0;
		$s_itemname = "";
		$i_regionID = $rowData[0];
		$s_regionName = $rowData[1];
		$s_type = "sell";
		if ($i_regionID > 0) {
			$s_pageName = "http://eve-central.com/api/quicklook?typeid=".$i_eveID."&regionlimit=".$i_regionID;
			$xml = @simplexml_load_file($s_pageName) or die ("quicklook: "."no file loaded"); 
			$o_currentNode = $xml->xpath("/evec_api/quicklook");
			foreach ($o_currentNode as $s_node) {
				$s_itemname = $s_node->itemname;
			}
			$s_pageName = "http://eve-central.com/api/marketstat?typeid=".$i_eveID."&regionlimit=".$i_regionID;
			$xml = @simplexml_load_file($s_pageName) or die ("marketstat: "."no file loaded"); 
			$o_currentNode = $xml->xpath("/evec_api/marketstat/type/".$s_type."");
			foreach ($o_currentNode as $s_node) {
				$i_volume = $s_node->volume;
				$i_avg = $s_node->avg;
				$i_min = $s_node->min;
				$i_max = $s_node->max;
				$i_stddev = $s_node->stddev; 
				$i_median = $s_node->median; 
			}
			if ($i_volume > 0) {
				$s_sql = "insert into cfg_eve_market_region (regionID, regionName, eveID, type, itemName, volume, avg, min, max, stddev, median, dateUpdated)
		        values (".$i_regionID.",'".$s_regionName."',".$i_eveID.",'".$s_type."','".$s_itemname."',".$i_volume.",".$i_avg.",".$i_min.",".$i_max.",".$i_stddev.",".$i_median.",'".date('Y-m-d H:i:00')."');";
				$q_update = mysql_query($s_sql);
				if (!$q_update) {die_well(mysql_error());}
			}
		}
		$i_rows++;
	}
}
echo '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'.$g_break; 
echo '<html xmlns="http://www.w3.org/1999/xhtml">'.$g_break;
echo '<head>'.$g_break;
echo '<meta name="generator" content="Eve Region Analysis." />'.$g_break; 
echo '<title>Eve Region Analysis.</title>'.$g_break; 
echo '<style type="text/css">'.$g_break; 
echo '.body {background-color: #F1EFDE;font-family: sans-serif;font-size: .8em}'.$g_break;
echo '.cellr {text-align: right;padding: 3px;}'.$g_break;
echo '.celll {text-align: left;padding: 3px;}'.$g_break;
echo '.title {font-size: 1.25em;font-weight:bold;}'.$g_break;
echo '.odd {background-color: #99A68C;}'.$g_break;
echo '.even {background-color: #A6A68C;}'.$g_break;
echo '</style>'.$g_break; 
echo '</head>'.$g_break; 
echo '<body class="body">'.$g_break;
echo '<img src="../../images/32px-Icon02_09.png" border="0">';
echo '<span class="title">Eve Region Analysis</span>'.$g_break;
//loading.gif
echo '<span id="swirly" style="display">&nbsp;<img src="../../images/new-spinner.gif" border="0" height="12" width="12" title="loading..."></span>';
echo '<br /><br />'.$g_break;
if ($i_output <> 0) {
	if ($i_sort == 1) {$s_sort="regionName";}
	if ($i_sort == 2) {$s_sort="itemName";}
	if ($i_sort == 3) {$s_sort="volume";}
	if ($i_sort == 4) {$s_sort="avg";}
	if ($i_sort == 5) {$s_sort="min";}
	if ($i_sort == 6) {$s_sort="max";}
	if ($i_sort == 7) {$s_sort="stddev";}
	if ($i_sort == 8) {$s_sort="median";}
	if ($i_sort == 9) {$s_sort="regionType";}
	if ($i_dir == 1) {$s_dir="asc";}else{$s_dir="desc";}
	echo '<table style="border-collapse:collapse;">'.$g_break;
	$s_sql = "select M.regionName, M.itemName, M.volume, M.avg, M.min, M.max, M.stddev, M.median, R.regionType 
	FROM braddoro.cfg_eve_market_region M 
	inner join braddoro.cfg_eve_regions R
	on M.regionID = R.regionID
	order by ".$s_sort." ".$s_dir.";";
	$q_data = mysql_query($s_sql);
	if (!$q_data) {die_well(mysql_error(),$s_sql);}
	if (mysql_num_rows($q_data) > 0) {	
		echo '<tr>'.$g_break;
		echo '<th class="celll">Region&nbsp;<img src="../../images/down.gif" onclick="js_sort(1,1);" title="Sort Ascending" style="cursor:pointer;"><img src="../../images/up.gif" onclick="js_sort(1,2);" title="Sort Descending" style="cursor:pointer;"></th>'.$g_break;
		echo '<th class="celll">Item&nbsp;<img src="../../images/down.gif" onclick="js_sort(2,1);" title="Sort Ascending" style="cursor:pointer;"><img src="../../images/up.gif" onclick="js_sort(2,2);" title="Sort Descending" style="cursor:pointer;"></th>'.$g_break;
		echo '<th class="cellr">Volume&nbsp;<img src="../../images/down.gif" onclick="js_sort(3,1);" title="Sort Ascending" style="cursor:pointer;"><img src="../../images/up.gif" onclick="js_sort(3,2);" title="Sort Descending" style="cursor:pointer;"></th>'.$g_break;
		echo '<th class="cellr">Average&nbsp;<img src="../../images/down.gif" onclick="js_sort(4,1);" title="Sort Ascending" style="cursor:pointer;"><img src="../../images/up.gif" onclick="js_sort(4,2);" title="Sort Descending" style="cursor:pointer;"></th>'.$g_break;
		echo '<th class="cellr">Minimum&nbsp;<img src="../../images/down.gif" onclick="js_sort(5,1);" title="Sort Ascending" style="cursor:pointer;"><img src="../../images/up.gif" onclick="js_sort(5,2);" title="Sort Descending" style="cursor:pointer;"></th>'.$g_break;
		echo '<th class="cellr">Maximum&nbsp;<img src="../../images/down.gif" onclick="js_sort(6,1);" title="Sort Ascending" style="cursor:pointer;"><img src="../../images/up.gif" onclick="js_sort(6,2);" title="Sort Descending" style="cursor:pointer;"></th>'.$g_break;
		echo '<th class="cellr">Std. Dev.&nbsp;<img src="../../images/down.gif" onclick="js_sort(7,1);" title="Sort Ascending" style="cursor:pointer;"><img src="../../images/up.gif" onclick="js_sort(7,2);" title="Sort Descending" style="cursor:pointer;"></th>'.$g_break;
		echo '<th class="cellr">Median&nbsp;<img src="../../images/down.gif" onclick="js_sort(8,1);" title="Sort Ascending" style="cursor:pointer;"><img src="../../images/up.gif" onclick="js_sort(8,2);" title="Sort Descending" style="cursor:pointer;"></th>'.$g_break;
		echo '<th class="cellr">Region Type&nbsp;<img src="../../images/down.gif" onclick="js_sort(9,1);" title="Sort Ascending" style="cursor:pointer;"><img src="../../images/up.gif" onclick="js_sort(9,2);" title="Sort Descending" style="cursor:pointer;"></th>'.$g_break;
		echo '<th class="cellr">monthly Income</th>'.$g_break;
		echo '</tr>'.$g_break;
	}
	$i_currRow = 1;
	while ($rowData = mysql_fetch_row($q_data)) {
		if ($i_currRow % 2) {
			$s_class="odd";			
		}else{
			$s_class="even";
		}
		echo '<tr>'.$g_break;
		echo '<td class="celll '.$s_class.'">'.$rowData[0].'</td>'.$g_break;
		echo '<td class="celll '.$s_class.'">'.$rowData[1].'</td>'.$g_break;
		echo '<td class="cellr '.$s_class.'">'.number_format($rowData[2]).'</td>'.$g_break;
		echo '<td class="cellr '.$s_class.'">$'.number_format($rowData[3],2).'</td>'.$g_break;
		echo '<td class="cellr '.$s_class.'">$'.number_format($rowData[4],2).'</td>'.$g_break;
		echo '<td class="cellr '.$s_class.'">$'.number_format($rowData[5],2).'</td>'.$g_break;
		echo '<td class="cellr '.$s_class.'">$'.number_format($rowData[6],2).'</td>'.$g_break;
		echo '<td class="cellr '.$s_class.'">$'.number_format($rowData[7],2).'</td>'.$g_break;
		echo '<td class="celll '.$s_class.'">'.$rowData[8].'</td>'.$g_break;
		echo '<td class="cellr '.$s_class.'">$'.number_format(($rowData[4]*72000),2).'</td>'.$g_break;
		echo '</tr>'.$g_break;
		$i_currRow++;
	}
	echo '</table>'.$g_break;
}
$s_param="js_collapseThis('paramHelp');";
echo '<br />';
echo '<img src="../../images/info.gif" border="0" onclick="'.$s_param.'" style="cursor:pointer;" title="Parameter Help">';
echo '<div id="paramHelp" name="paramHelp" style="display:none;">';
echo 'Optional Params<br /><br />';
echo '<b>delete</b> values: 1 = clear table<br />Example Call: http://braddoro.com/eve/region_scan.php?delete=1<br /><br />';
echo '<b>output</b> values: 0 = hide table output<br />Example Call: http://braddoro.com/eve/region_scan.php?output=0<br /><br />';
echo '<b>eveID</b> the eve id of data to add to table<br />Example Call: http://braddoro.com/eve/region_scan.php?eveID=34<br /><br />';
echo '<br />';
echo '* Note that you can stack parameters in the url:<br />Example Call: http://braddoro.com/eve/region_scan.php?eveID=34&delete=1<br />';
echo '</div>';
echo '</body>'.$g_break; 
echo '</html>'.$g_break;
?>
<script language="javascript">
function js_sort(scol,cdir) {
	s_url = "region_scan.php?sort=" + scol + "&dir=" + cdir;
	window.location = s_url;
}
function js_collapseThis(changeme) {
	if (document.getElementById(changeme).style.display == "block") {
		document.getElementById(changeme).style.display = "none";
	} else {
		document.getElementById(changeme).style.display = "block";
	}
}
document.getElementById("swirly").style.display = "none";
</script>