<?php
include "_functions.php";
header("Cache: private");
$s_fileName = basename(__FILE__);
$s_pageName = "Projects";
$s_server = "65.175.107.2:3306";
$s_userName = "cms_user";
$s_password = "alvahugh";
$s_db = "cms";
$s_page_task = set_var('page_task','list');
$i_projectID = set_var('projectID',0);
$s_project = set_var('project',"");
$s_projectCode = set_var('projectCode',"");
$i_active = set_var('active',1);
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
$s_header .= '<link rel="stylesheet" href="cms.css">'.$g_break;
$s_header .= '</head>'.$g_break; 
$s_header .= '<body class="body">'.$g_break;
$s_header .= '<img src="../../images/32px-Icon02_09.png" border="0">';
$s_header .= '<span class="title">'.$s_pageName.'</span>'.$g_break;
$s_header .= '<span id="swirly" style="display">&nbsp;<img src="../../images/new-spinner.gif" border="0" height="12" width="12" title="loading..."></span><br />';
$s_header .= '<a href="timeTrack.php" target="_top"><img src="../../images/arrow_l.gif" border="0" height="10" width="10" title="Main Screen"></a>';
$s_header .= '<br /><br />'.$g_break;
switch ($s_page_task) {
    case "save":
    	$page_task="list";
		if ($s_submit > "") {
			if ($i_projectID > 0) {
				$s_sql = 'update cms.cfg_projects set project = "'.$s_project.'", projectCode = "'.$s_projectCode.'", active = '.$i_active.' where projectID = '.$i_projectID.';';
			} else {
				if ($s_project > "") { 
					$s_sql = 'insert into cms.cfg_projects (project, projectCode, active) select "'.$s_project.'", "'.$s_projectCode.'", '.$i_active.';';
				}
			}
			if ($s_sql > "") {
				$q_update = mysql_query($s_sql);
				if (!$q_update) {die_well(__LINE__,mysql_error(),$s_sql);}
			}
		}
		header("Location: $s_fileName"); 		
    	break;
	case "list":
		echo $s_header;
		$page_task=$s_page_task;
		$s_sql = 'select projectID, projectCode, project, active from cms.cfg_projects order by project;';
		$q_data = mysql_query($s_sql);
		if (!$q_data) {die_well(__LINE__,mysql_error());}
		$i_fields = mysql_num_fields($q_data);
		echo '<table border="0" style="border-collapse: collapse;">';
		echo '<tr>';
		echo '<th class="accentrow">';
		echo '<a href="'.$s_fileName.'?projectID=0&page_task=edit" target="_top"><img src="../../images/Button-Add-16x16.png" border="0" height="12" width="12" title="Add"></a>';
		echo '</th>';
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
			echo '<a href="'.$s_fileName.'?projectID='.$rowData[0].'&page_task=edit" target="_top">';
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
		$s_sql = 'select projectID, project, active from cms.cfg_projects where projectID = '.$i_projectID.';';
		$q_data = mysql_query($s_sql);
		if (!$q_data) {die_well(__LINE__,mysql_error());}
		while ($rowData = mysql_fetch_row($q_data)) {
			$i_projectID = $rowData[0]; 
			$s_project = $rowData[1];
			$i_active = $rowData[2];
		}
		echo '<a href="'.$s_fileName.'" target="_top"><img src="../../images/Button-Info-16x16.png" border="0" height="12" width="12" title="List"></a>';
		echo '<form id="frmForm" name="frmForm" action="'.$s_fileName.'" method="post">';
		echo '<input type="hidden" name="page_task" id="page_task" value="'.$page_task.'">';
		echo '<table style="border-collapse: collapse;">'.$g_break;
		echo row_input_text($s_fieldName="projectID",$i_fieldSize=5,$s_data=$i_projectID,$left_class="odd",$right_class="even",$s_fieldString="Project ID",$use_input=0,$use_hidden=1,$value_only=1).$g_break;
		echo row_input_text($s_fieldName="projectCode",$i_fieldSize=10,$s_data=trim($s_projectCode),$left_class="odd",$right_class="even",$s_fieldString="Project Code").$g_break;
		echo row_input_text($s_fieldName="project",$i_fieldSize=30,$s_data=trim($s_project),$left_class="odd",$right_class="even",$s_fieldString="Project").$g_break;
		echo row_input_text($s_fieldName="active",$i_fieldSize=5,$s_data=$i_active,$left_class="odd",$right_class="even",$s_fieldString="Active").$g_break;
		if ($i_projectID > 0) {$s_text = "Save";}else{$s_text = "Add";}		
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