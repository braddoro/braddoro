<?php
include "_functions.php";
header("Cache: private");
$s_fileName = basename(__FILE__);
$s_pageName = "Tower";
$s_server = "65.175.107.2:3306";
$s_userName = "webapp";
$s_password = "alvahugh";
$s_db = "braddoro";
$s_page_task = set_var('page_task','list');
$i_towerID = set_var('towerID',0);
$i_towerTypeID = set_var('towerTypeID',0);
$i_planet = set_var('planet',0);
$i_moon = set_var('moon',0);
$i_active = set_var('active',0);
$i_ownerID = set_var('ownerID',0);
$s_pid = set_var('pid',0);
$s_system = set_var('system',"");
$s_submit = set_var('submit_form',"");
$o_conn = mysql_connect($server=$s_server,$username=$s_userName,$password=$s_password);
if (!$o_conn) {die_well(__LINE__,mysql_error());}
$o_sel = mysql_select_db($s_db);
if (!$o_sel) {die_well(__LINE__,mysql_error());}
$s_header = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'.$g_break; 
$s_header .= '<html xmlns="http://www.w3.org/1999/xhtml">'.$g_break;
$s_header .= '<head>'.$g_break;
$s_header .= '<meta name="generator" content="'.$s_pageName.'" />'.$g_break; 
$s_header .= '<title>'.$s_pageName.'</title>'.$g_break; 
$s_header .= '<link rel="stylesheet" href="eve2.css">'.$g_break;
$s_header .= '</head>'.$g_break; 
$s_header .= '<body class="body">'.$g_break;
$s_header .= '<img src="../../images/32px-Icon02_09.png" border="0">';
$s_header .= '<span class="title">'.$s_pageName.'</span>'.$g_break;
$s_header .= '<span class="headerlabel"><a href="tower_overview.cfm?task=home&pid='.$s_pid.'">home</a>'.$g_break;
$s_header .= '<span id="swirly" style="display">&nbsp;<img src="../../images/new-spinner.gif" border="0" height="12" width="12" title="loading..."></span>';
$s_header .= '<br /><br />'.$g_break;
switch ($s_page_task) {
    case "save":
    	$page_task="list";
		if ($s_submit > "") {
			if ($i_towerID > 0) {
				$s_sql = 'update braddoro.dyn_pos_tower set towerTypeID = '.$i_towerTypeID.', system = "'.$s_system.'", planet = '.$i_planet.', moon = '.$i_moon.', active = '.$i_active.', ownerID = '.$i_ownerID.' where towerID = '.$i_towerID.';';
				$q_update = mysql_query($s_sql);
				if (!$q_update) {die_well(__LINE__,mysql_error());}
			} else {
				if ($s_system > "") { 
					$s_sql = 'insert into braddoro.dyn_pos_tower (towerTypeID, system, planet, moon, active, ownerID, publicID) select '.$i_towerTypeID.', "'.$s_system.'", '.$i_planet.', '.$i_moon.', '.$i_active.', '.$i_ownerID.', uuid();';
					$q_update = mysql_query($s_sql);
					if (!$q_update) {die_well(__LINE__,mysql_error());}
					$i_towerID = mysql_insert_id();
				}
			}
			$s_sql = 'select towerID, towerTypeID, attributeGroup, attribute, attributeValue from dyn_pos_tower_attributes where towerID = '.$i_towerID.';';
			$q_update = mysql_query($s_sql);
			if (!$q_update) {die_well(__LINE__,mysql_error());}
			$i_rows = mysql_num_rows($q_update);
			if ($i_rows == 0) {
				$s_sql = 'insert into dyn_pos_tower_attributes (towerID, towerTypeID, attributeGroup, attribute, attributeValue) select '.$i_towerID.', '.$i_towerTypeID.', attributeGroup, attribute, attributeValue from dyn_pos_tower_attributes where towerID = -1;';
				$q_update = mysql_query($s_sql);
				if (!$q_update) {die_well(__LINE__,mysql_error());}
			} else {
				$s_sql = 'update dyn_pos_tower_attributes set towerTypeID = '.$i_towerTypeID.' where towerID = '.$i_towerID.';';
				$q_update = mysql_query($s_sql);
				if (!$q_update) {die_well(__LINE__,mysql_error());}
			} 
		}
		header("Location: $s_fileName?pid=$s_pid");
    	break;
	case "list":
		echo $s_header;
		$page_task=$s_page_task;
		$s_sql = 'select T.towerID, T.towerTypeID, T.system, T.planet, T.moon, T.active, T.ownerID 
			from braddoro.dyn_pos_tower T 
			inner join dyn_pos_owners O
			    on T.ownerID = O.ownerID
			    and O.publicID = "'.$s_pid.'" 
			order by towerID desc;';
		$q_data = mysql_query($s_sql);
		if (!$q_data) {die_well(__LINE__,mysql_error());}
		$i_fields = mysql_num_fields($q_data);
		echo '<a href="'.$s_fileName.'?towerID=0&page_task=edit&pid='.$s_pid.'" target="_top"><img src="../../images/Button-Play-16x16.png" border="0" height="12" width="12" title="Add"></a>';
		echo '<table border="0" style="border-collapse: collapse;">';
		echo '<tr>';
		echo '<th class="accentrow">&nbsp;</th>';
		for ($i=0; $i < $i_fields; $i++) {
			echo '<th class="accentrow">'.mysql_field_name($q_data, $i).'</th>'; 
		}
		echo '</tr>';
		while ($rowData = mysql_fetch_row($q_data)) {
			echo '<tr>';
			if ($i_currRow % 2) {
					$s_class="odd";			
				}else{
					$s_class="even";
			}	
			echo '<td class="'.$s_class.'">';
			echo '<a href="'.$s_fileName.'?towerID='.$rowData[0].'&page_task=edit&pid='.$s_pid.'" target="_top">';
			echo '<img src="../../images/Button-Pause-16x16.png" border="0" height="12" width="12" title="Edit">';
			echo '</a></td>';
			for ($f=0; $f < $i_fields; $f++) {
		    	echo '<td class="'.$s_class.'">'.$rowData[$f].'</td>';
			}
		    echo '</tr>';
		    $i_currRow++;
		}
    	break;
    case "edit":
    	echo $s_header;
    	$page_task="save";
		$s_sql = 'select towerID, towerTypeID, system, planet, moon, active, ownerID from braddoro.dyn_pos_tower where towerID = '.$i_towerID.';';
		$q_data = mysql_query($s_sql);
		if (!$q_data) {die_well(__LINE__,mysql_error());}
		while ($rowData = mysql_fetch_row($q_data)) {
			$i_towerID = $rowData[0]; 
			$i_towerTypeID = $rowData[1]; 
			$s_system = $rowData[2];
			$i_planet = $rowData[3]; 
			$i_moon = $rowData[4];
			$i_active = $rowData[5];
			$i_ownerID = $rowData[6];
		}
		echo '<a href="'.$s_fileName.'&pid='.$s_pid.'" target="_top"><img src="../../images/Button-Info-16x16.png" border="0" height="12" width="12" title="List"></a>';
		echo '<form id="frmForm" name="frmForm" action="'.$s_fileName.'" method="post">';
		echo '<input type="hidden" name="page_task" id="page_task" value="'.$page_task.'">';
		echo '<input type="hidden" name="pid" id="pid" value="'.$s_pid.'">';
		echo '<table style="border-collapse: collapse;">'.$g_break;
		echo row_input_text($s_fieldName="towerID",$i_fieldSize=5,$s_data=$i_towerID,$left_class="odd",$right_class="even",$s_fieldString="Tower ID",$use_input=0,$use_hidden=1,$value_only=1).$g_break;
		echo row_input_text($s_fieldName="towerTypeID",$i_fieldSize=5,$s_data=$i_towerTypeID,$left_class="odd",$right_class="even",$s_fieldString="Tower Size").$g_break;
		echo row_input_text($s_fieldName="system",$i_fieldSize=30,$s_data=trim($s_system),$left_class="odd",$right_class="even",$s_fieldString="System").$g_break;
		echo row_input_text($s_fieldName="planet",$i_fieldSize=5,$s_data=$i_planet,$left_class="odd",$right_class="even",$s_fieldString="Planet").$g_break;
		echo row_input_text($s_fieldName="moon",$i_fieldSize=5,$s_data=$i_moon,$left_class="odd",$right_class="even",$s_fieldString="Moon").$g_break;
		echo row_input_text($s_fieldName="active",$i_fieldSize=5,$s_data=$i_active,$left_class="odd",$right_class="even",$s_fieldString="Active").$g_break;	
		echo row_input_text($s_fieldName="ownerID",$i_fieldSize=5,$s_data=$i_ownerID,$left_class="odd",$right_class="even",$s_fieldString="Owner ID").$g_break;
		if ($i_towerID > 0) {$s_text = "Save";}else{$s_text = "Add";}		
		echo '<tr>'.$g_break;
		echo '<td class="odd">&nbsp;</td>'.$g_break;
		echo '<td class="even"><input type="submit" id="submit_form" name="submit_form" value="'.$s_text.'"></td>'.$g_break;
		echo '</tr>'.$g_break;
		echo '</table>'.$g_break;
		echo '</form>';		
        break;
}

echo '</table>';
echo '<script language="javascript">'.$g_break;
echo 'document.getElementById("swirly").style.display = "none";'.$g_break;
echo '</script>'.$g_break;
echo '</body>'.$g_break; 
echo '</html>'.$g_break;
?>