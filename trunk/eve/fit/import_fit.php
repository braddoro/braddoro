<?php
$uploaddir = "upload/";
$uploadfile = $uploaddir.basename($_FILES['userfile']['name']);
//echo '<pre>';
//echo $uploadfile;
if ($_FILES['userfile']['name'] > "") {
	if (move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile)) {
		$server		= "65.175.107.2:3306";
		$username	= "webapp";
		$password	= "alvahugh";
		$dbname		= "braddoro";
		$o_conn = mysql_connect($server,$username,$password);
		if (!$o_conn) {die_well(__LINE__,mysql_error());}
		$o_sel = mysql_select_db($dbname);
		if (!$o_sel) {die_well(__LINE__,mysql_error());}
		$s_pageName = $uploadfile;
		$o_xml = simplexml_load_file($s_pageName);
		$s_purpose = $o_xml->fitting[0]["name"];
		$s_shipType = $o_xml->fitting[0]->shipType[0]["value"];
		//echo $o_xml->fitting[0]->description[0]["value"]."<br/>";
		$i_hardware = count($o_xml->fitting[0]->hardware);
		for ($x=0;$x<$i_hardware;$x++) {
			$s_slot = $o_xml->fitting[0]->hardware[$x]["slot"];
			$s_mod = $o_xml->fitting[0]->hardware[$x]["type"];
			if (isset($o_xml->fitting[0]->hardware[$x]["qty"])) {
				$s_qty = $o_xml->fitting[0]->hardware[$x]["qty"];
			}else{
				$s_qty = ""; 
			}
			if (substr($s_slot,0,7) == "hi slot") {
				$s_slot = "High";
			}
			if (substr($s_slot,0,8) == "med slot") {
				$s_slot = "Medium";
			}
			if (substr($s_slot,0,8) == "low slot") {
				$s_slot = "Low";
			}
			if (substr($s_slot,0,8) == "rig slot") {
				$s_slot = "Rig";
			}
			if (substr($s_slot,0,9) == "drone bay") {
				$s_slot = "Drone";
			}
			$s_purpose = str_replace("'","''",$s_purpose);
			$s_shipType = str_replace("'","''",$s_shipType);
			$s_slot = str_replace("'","''",$s_slot);
			$s_mod = str_replace("'","''",$s_mod);
			$s_sql = "insert into braddoro.dyn_ship_fitting2 (purpose, shipName, slot, module, updated_date) select '$s_purpose', '$s_shipType', '$s_slot', ltrim('$s_qty $s_mod'), now();";
			mysql_query($s_sql);	
		}
	} else {
	   // echo "Possible file upload attack!\n";
	}
}
//echo 'Here is some more debugging info:';
//print_r($_FILES);
//print "</pre>";
?>
<html>
<head><title>FWA Ship Fitting</title>
<body>
<div class="fontfamily s5">FWA Ship Fitting Guide</div><br/>
<?php
$b_command = 0;
if (isset($_REQUEST["command"])) {
	if ($_REQUEST["command"] == 1) {
		$b_command = 1;	
	} else {
		$b_command = 0;
	}
}
//if ($b_command == 1) {
	//<!-- The data encoding type, enctype, MUST be specified as below -->
	echo '<div class="label s2" style="border:1px solid #999999;width:66%">';
	echo '<form enctype="multipart/form-data" action="input.php" method="POST">';
	//<!-- MAX_FILE_SIZE must precede the file input field -->
	echo '<input type="hidden" name="command" id="command" value="'.$b_command.'" />';
	echo '<input type="hidden" name="MAX_FILE_SIZE" value="30000" />';
	//<!-- Name of input element determines name in $_FILES array -->
	echo '<span class="s2">EvE Export File:</span> <input name="userfile" type="file" /> <input type="submit" value="Upload Fitting" />';
	echo '</form>';
	echo '</div>';
	echo '<br/>';
//}
?>
</body>
</html>
