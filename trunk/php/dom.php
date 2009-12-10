<?php
$i_eveID=0;
if (isset($_REQUEST["eveID"])) {
	$i_eveID = intval($_REQUEST["eveID"]);
} else {
	if (isset($_POST["eveID"])) {
		$i_eveID = intval($_POST["eveID"]);
	}
}
$s_pageName = "http://eve-central.com/api/quicklook?typeid=".$i_eveID."&regionlimit=10000002"; 
$xml = @simplexml_load_file($s_pageName) or die ("no file loaded"); 
$o_currentNode = $xml->xpath("/evec_api/quicklook");
foreach ($o_currentNode as $s_node) {
	echo $s_node->item."<br />";
	echo $s_node->itemname."<br />";
}
$s_pageName = "http://api.eve-central.com/api/marketstat?typeid=".$i_eveID."&regionlimit=10000002"; 
$xml = @simplexml_load_file($s_pageName) or die ("no file loaded"); 
$o_currentNode = $xml->xpath("/evec_api/marketstat/type/sell");
foreach ($o_currentNode as $s_node) {
	echo "volume: " . $s_node->volume . "<br />";
	echo "avg: " . $s_node->avg . "<br />";
	echo "min: " . $s_node->max . "<br />"; 
	echo "stddev: " . $s_node->stddev . "<br />"; 
	echo "median: " . $s_node->median . "<br />"; 
	echo "<br />";
}

$link = mysql_connect($server='65.175.107.2:3306',$username='webapp',$password='alvahugh');
if (!$link) {
    die('Error: '.mysql_error());
    exit;
}
mysql_select_db("braddoro");
$q_data = mysql_query($sql);
if (!$q_data) {
    die('Error: '.mysql_error());
    exit;
}
}
if ($s_task == "add") {
	$sql = "insert into cfg_eve_market_updates (eveID, itemName, volume, avg, min, stddev, median, type, dateUpdated)
		values(1,'".$i_eveID."',".($_POST['iceTime']).",'".$_POST['startTime']."','".$_POST['endTime']."',".intval($_POST['turrets']).",".intval($_POST['turretYield']).",".intval($_POST['split']).")";
	$link = mysql_connect($server='65.175.107.2:3306',$username='webapp',$password='alvahugh');
	if (!$link) {
	    die('Error: '.mysql_error());
	    exit;
	}
	mysql_select_db("braddoro");
	$q_data = mysql_query($sql);
	if (!$q_data) {
	    die('Error: '.mysql_error());
	    exit;
	}
}


values ()

?>