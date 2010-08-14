<?php
$s_html = "";
$i_itemID = intval(lib_set_var("itemID","0"));
$s_task = lib_set_var("task","");
$s_purpose = lib_set_var("purpose","");
$s_shipName = lib_set_var("shipName","");
$s_slot = lib_set_var("slot","");
$s_module = lib_set_var("module","");
$b_command = lib_set_var("command",0);

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

switch ($s_task) {
case "edit":
	$s_sql = "select fitID, purpose, shipName, slot, module from braddoro.dyn_ship_fitting2 where fitID = $i_itemID";
	$q_data = mysql_query($s_sql);
	
	if (!$q_data) {die_well(__LINE__,mysql_error());}
	$fitID = 0;
	$purpose = "";
	$shipName = "";
	$slot = "";
	$module = "";
	while($row = mysql_fetch_array($q_data)) {
		$fitID = $row["fitID"];
		$purpose = $row["purpose"];
		$shipName = $row["shipName"];
		$slot = $row["slot"];
		$module = $row["module"];
	}
	$s_sql = "select distinct purpose from braddoro.dyn_ship_fitting2 order by purpose";
	$q_data = mysql_query($s_sql);
	if (!$q_data) {die_well(__LINE__,mysql_error());}
	$s_value = "";
	$s_sel_purpose = '<select class="s3" id="purpose" name="purpose" onchange="js_clearMe(this.id,\'purpose_new\');">';
	$s_sel_purpose .= '<option value=""></option>';
	while($row = mysql_fetch_array($q_data)) {
		$s_value = $row["purpose"];
		if ($s_value == $purpose) {
			$s_selected = " SELECTED";
		} else {
			$s_selected = "";
		}
		$s_sel_purpose .= '<option value="'.$s_value.'"'.$s_selected.'>'.$s_value.'</option>';
	}
	$s_sel_purpose .= '</select>';

	$s_sql = "select distinct shipName from braddoro.dyn_ship_fitting2 order by shipName";
	$q_data = mysql_query($s_sql);
	if (!$q_data) {die_well(__LINE__,mysql_error());}
	$s_value = "";
	$s_sel_shipName = '<select class="s3" id="shipName" name="shipName" onchange="js_clearMe(this.id,\'shipName_new\');">';
	$s_sel_shipName .= '<option value=""></option>';
	while($row = mysql_fetch_array($q_data)) {
		$s_value = $row["shipName"];
		if ($s_value == $shipName) {
			$s_selected = " SELECTED";
		} else {
			$s_selected = "";
		}
		$s_sel_shipName .= '<option value="'.$s_value.'"'.$s_selected.'>'.$s_value.'</option>';
	}
	$s_sel_shipName .= '</select>';
		
	$s_sql = "select distinct slot from braddoro.dyn_ship_fitting2 order by slot";
	$q_data = mysql_query($s_sql);
	if (!$q_data) {die_well(__LINE__,mysql_error());}
	$s_value = "";
	$s_sel_slot = '<select class="s3" id="slot" name="slot" onchange="js_clearMe(this.id,\'slot_new\');">';
	$s_sel_slot .= '<option value=""></option>';
	while($row = mysql_fetch_array($q_data)) {
		$s_value = $row["slot"];
		if ($s_value == $slot) {
			$s_selected = " SELECTED";
		} else {
			$s_selected = "";
		}
		$s_sel_slot .= '<option value="'.$s_value.'"'.$s_selected.'>'.$s_value.'</option>';
	}
	$s_sel_slot .= '</select>';

	$s_html .= '<table class="tabledata" cellpadding="0" cellspacing="0">';
	$s_html .= '<tr>';
	$s_html .= '<td class="label">Purpose</td>';
	$s_html .= '<td class="label2">';
	$s_html .= $s_sel_purpose;
	$s_html .= '&nbsp;<input class="s3" type="text" size="20" name="purpose_new" id="purpose_new" value=""/>';
	$s_html .= '</td>';
	$s_html .= '</tr>';
	$s_html .= '<tr>';
	$s_html .= '<td class="label">Ship</td>';
	$s_html .= '<td class="label2">';
	$s_html .= $s_sel_shipName;
	$s_html .= '&nbsp;<input class="s3" type="text" size="20" name="shipName_new" id="shipName_new" value=""/>';
	$s_html .= '</td>';
	$s_html .= '</tr>';
	$s_html .= '<tr>';
	$s_html .= '<td class="label">Slot</td>';
	$s_html .= '<td class="label2">';
	$s_html .= $s_sel_slot;
	$s_html .= '&nbsp;<input class="s3" type="text" size="20" name="slot_new" id="slot_new" value=""/>';
	$s_html .= '</td>';
	$s_html .= '</tr>';
	$s_html .= '<tr>';
	$s_html .= '<td class="label">Module</td>';
	$s_html .= '<td class="label2"><input class="s3" type="text" size="40" name="module" id="module" value="'.$module.'"/></td>';
	$s_html .= '</tr>';
	$s_html .= '<tr>';
	$s_html .= '<td class="label">&nbsp;</td>';
	$s_html .= '<td class="label2"><input class="s3" type="button" name="G01" id="G01" value="Save" onclick="js_ajax(\'save\','.$fitID.',\'\');js_ajax(\'show\',0,\'div_output\');js_ajax(\'edit\',0,\'div_input\');" /></td>';
	$s_html .= '</tr>';
	$s_html .= '</table>';
	break;
case "save":
	if ($i_itemID > 0) {
		$s_sql = "update braddoro.dyn_ship_fitting2 set purpose = '$s_purpose', shipName = '$s_shipName', slot = '$s_slot', module = '$s_module', updated_date = now() where fitID = $i_itemID";
	} else {
		$s_sql = "insert into braddoro.dyn_ship_fitting2 (purpose, shipName, slot, module, updated_date) select '$s_purpose', '$s_shipName', '$s_slot', '$s_module', now()";
	}
	$q_data = mysql_query($s_sql);
	break;
case "show":
	$s_sql = "select fitID, purpose, shipName, slot, module from braddoro.dyn_ship_fitting2 order by purpose, shipName, slot, module";
	$q_data = mysql_query($s_sql);
	if (!$q_data) {die_well(__LINE__,mysql_error());}
	$s_html .= '<table class="tabledata" cellpadding="0" cellspacing="0">';
	$purpose_hold = "";
	$shipName_hold = "";
	$module_hold = "";
	$i_same = 1;
	$s_spacer = "&nbsp;&nbsp;&nbsp;&nbsp;";
	while($row = mysql_fetch_array($q_data)) {
		$fitID = $row["fitID"];
		$purpose = $row["purpose"];
		$shipName = $row["shipName"];
		$slot = $row["slot"];
		$module = $row["module"];
		if ($purpose_hold != $purpose) {
			$s_html .= '<tr>';
			$s_html .= '<td class="label0" colspan="4">'.$purpose.'</td>';
			$s_html .= '</tr>';
		}
		if ($purpose_hold != $purpose || $shipName_hold != $shipName) {
			$s_html .= '<tr>';
			$s_html .= '<td class="label0">'.$s_spacer.'</td>';
			$s_html .= '<td class="label0" colspan="3">'.$shipName.'</td>';
			$s_html .= '</tr>';
		}
		$s_html .= '<tr>';
		$s_html .= '<td class="label">'.$s_spacer.'</td>';
		//if ($b_command == 1) {
			$s_html .= '<td class="label"><span id="row_'.$fitID.'" name="row_'.$fitID.'" class="links" title="edit" onclick="js_ajax(\'edit\','.$fitID.',\'div_input\');">&nbsp;&bull;&nbsp;</span></td>';
		//} else {
		//	$s_html .= '<td class="label">&nbsp;</td>';
		//}
		$s_html .= '<td class="label">'.$slot.'</td>';
		$s_html .= '<td class="label">'.$module.'</td>';
		$s_html .= '</tr>';
		$purpose_hold = $purpose;
		$shipName_hold = $shipName;
		$module_hold = $module;
	}
	$s_html .= '</table>';
	break;
default:
	$s_html = "$s_task";
	break;
}
function lib_set_var($testName,$s_default) {
	$varName=$s_default;
	if (isset($_REQUEST[$testName])) {
		$varName = $_REQUEST[$testName];
	} else { 
		if (isset($_POST[$testName])) {
			$varName = $_POST[$testName];
		}
	}
	return $varName;
}
echo $s_html;
?>
