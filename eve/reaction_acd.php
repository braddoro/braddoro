<?php
include "_functions.php";
header("Cache: private");
$s_fileName = basename(__FILE__);
$s_pageName = "Tower Reaction";
$s_server = "65.175.107.2:3306";
$s_userName = "webapp";
$s_password = "alvahugh";
$s_db = "braddoro";
$s_page_task = set_var('page_task','list');
$i_xrefID = set_var('xrefID',0);
$s_pid = set_var('pid',0);
$i_towerID = set_var('towerID',0);
$i_reactionID = set_var('reactionID',0);
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
			if ($i_xrefID > 0) {
				$s_sql = 'update braddoro.dyn_pos_tower_reaction set reactionID = '.$i_reactionID.', towerID = '.$i_towerID.' where xrefID = '.$i_xrefID.';';
			} else {
				if ($i_reactionID > 0 && $i_towerID > 0) { 
					$s_sql = 'insert into braddoro.dyn_pos_tower_reaction (reactionID, towerID) select '.$i_reactionID.', '.$i_towerID.';';
				}
			}
			if ($s_sql > "") {
				$q_update = mysql_query($s_sql);
				if (!$q_update) {die_well(__LINE__,mysql_error());}
			}
		}
		header("Location: $s_fileName?pid=$s_pid"); 		
    	break;
	case "list":
		echo $s_header;
		$page_task=$s_page_task;
		$s_sql = 'select R.xrefID, O.owner, T.system, T.planet, T.moon, TT.race, TT.size, C.reaction, T.active  
			from braddoro.dyn_pos_tower_reaction R
			inner join dyn_pos_tower T
			    on R.towerID = T.towerID
			inner join cfg_pos_reactions C
			    on R.reactionID = C.reactionID   
			inner join cfg_pos_tower_types TT
			    on T.towerTypeID = TT.towerTypeID    
			inner join dyn_pos_owners O
			    on T.ownerID = O.ownerID
			    and O.publicID = "'.$s_pid.'" 
			order by O.owner, T.system, T.planet, T.moon, TT.race, TT.size, C.reaction;';
		$q_data = mysql_query($s_sql);
		if (!$q_data) {die_well(__LINE__,mysql_error());}
		$i_fields = mysql_num_fields($q_data);
		echo '<a href="'.$s_fileName.'?xrefID=0&page_task=edit&pid='.$s_pid.'" target="_top"><img src="../../images/Button-Play-16x16.png" border="0" height="12" width="12" title="Add"></a>';
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
			echo '<a href="'.$s_fileName.'?xrefID='.$rowData[0].'&page_task=edit&pid='.$s_pid.'" target="_top">';
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
		$s_sql = 'select R.xrefID, O.owner, T.system, T.planet, T.moon, TT.race, TT.size, R.reactionID, R.towerID  
			from braddoro.dyn_pos_tower_reaction R
			inner join dyn_pos_tower T
			    on R.towerID = T.towerID
			inner join cfg_pos_reactions C
			    on R.reactionID = C.reactionID   
			inner join cfg_pos_tower_types TT
			    on T.towerTypeID = TT.towerTypeID    
			inner join dyn_pos_owners O
			    on T.ownerID = O.ownerID
			    and O.publicID = "'.$s_pid.'"
			 where xrefID = '.$i_xrefID.';';
		$q_data = mysql_query($s_sql);
		if (!$q_data) {die_well(__LINE__,mysql_error());}
		while ($rowData = mysql_fetch_row($q_data)) {
			$i_xrefID = $rowData[0];
			$s_owner =  $rowData[1];
			$s_system = $rowData[2]; 
			$i_planet = $rowData[3];
			$i_moon = $rowData[4];
			$s_race = $rowData[5];
			$s_size = $rowData[6];
			$i_reactionID = $rowData[7];
			$i_towerID = $rowData[8];
		}
		echo '<a href="'.$s_fileName.'?pid='.$s_pid.'" target="_top"><img src="../../images/Button-Info-16x16.png" border="0" height="12" width="12" title="List"></a>';
		echo '<form id="frmForm" name="frmForm" action="'.$s_fileName.'" method="post">';
		echo '<input type="hidden" name="page_task" id="page_task" value="'.$page_task.'">';
		echo '<input type="hidden" name="pid" id="pid" value="'.$s_pid.'">';
		echo '<table style="border-collapse: collapse;">'.$g_break;
		echo row_input_text($s_fieldName="",$i_fieldSize=5,$s_data=$s_owner,$left_class="odd",$right_class="accentrow",$s_fieldString="Owner",$use_input=0,$use_hidden=1,$value_only=1).$g_break;
		echo row_input_text($s_fieldName="",$i_fieldSize=5,$s_data=$s_system,$left_class="odd",$right_class="accentrow",$s_fieldString="System",$use_input=0,$use_hidden=1,$value_only=1).$g_break;
		echo row_input_text($s_fieldName="",$i_fieldSize=5,$s_data=$i_planet,$left_class="odd",$right_class="accentrow",$s_fieldString="Planet",$use_input=0,$use_hidden=1,$value_only=1).$g_break;
		echo row_input_text($s_fieldName="",$i_fieldSize=5,$s_data=$i_moon,$left_class="odd",$right_class="accentrow",$s_fieldString="Moon",$use_input=0,$use_hidden=1,$value_only=1).$g_break;
		echo row_input_text($s_fieldName="",$i_fieldSize=5,$s_data=$s_race,$left_class="odd",$right_class="accentrow",$s_fieldString="Race",$use_input=0,$use_hidden=1,$value_only=1).$g_break;
		echo row_input_text($s_fieldName="",$i_fieldSize=5,$s_data=$s_size,$left_class="odd",$right_class="accentrow",$s_fieldString="Size",$use_input=0,$use_hidden=1,$value_only=1).$g_break;
		echo row_input_text($s_fieldName="xrefID",$i_fieldSize=5,$s_data=$i_xrefID,$left_class="odd",$right_class="even",$s_fieldString="xref ID",$use_input=0,$use_hidden=1,$value_only=1).$g_break;		
		
		echo '<tr>'.$g_break;
		echo '<td class="odd">Tower</td>'.$g_break;
		echo '<td class="even">'.$g_break;
		$s_sql = 'select T.towerID, T.system, T.planet, T.moon from dyn_pos_tower T order by T.system, T.planet, T.moon;';
		$q_list = mysql_query($s_sql);
		if (!$q_list) {die_well(__LINE__,mysql_error());}
		echo '<select id="towerID" name="towerID">'.$g_break;
		echo '<option value="0">Select an Option</option>'.$g_break;
		while ($listrow = mysql_fetch_row($q_list)) {
			$i_loop = $listrow[0]; 
			$s_string  = $listrow[1].' '.$listrow[2].'-'.$listrow[3];
			if ($i_loop == $i_towerID) {
				$s_sel = " SELECTED";
			} else {
				$s_sel = "";
			}
			echo '<option value="'.$i_loop.'"'.$s_sel.'>'.$s_string.'</option>'.$g_break;
		}
		echo '</select>';
		echo '</td>'.$g_break;
		echo '</tr>'.$g_break;

		echo '<tr>'.$g_break;
		echo '<td class="odd">Reaction</td>'.$g_break;
		echo '<td class="even">'.$g_break;
		$s_sql = 'select T.reactionID, T.reaction from cfg_pos_reactions T order by T.reaction;';
		$q_list = mysql_query($s_sql);
		if (!$q_list) {die_well(__LINE__,mysql_error());}
		echo '<select id="reactionID" name="reactionID">'.$g_break;
		echo '<option value="0">Select an Option</option>'.$g_break;
		while ($listrow = mysql_fetch_row($q_list)) {
			$i_loop = $listrow[0];
			if ($i_loop == $i_reactionID) {
				$s_sel = " SELECTED";
			} else {
				$s_sel = "";
			}
			echo '<option value="'.$listrow[0].'"'.$s_sel.'>'.$listrow[1].'</option>'.$g_break;
		}
		echo '</select>'.$g_break;
		echo '</td>'.$g_break;
		echo '</tr>'.$g_break;
		
		if ($i_xrefID > 0) {$s_text = "Save";}else{$s_text = "Add";}		
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