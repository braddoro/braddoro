<?php
include "_functions.php";
header("Cache: private");
$s_fileName = basename(__FILE__);
$s_pageName = "Time Track";
$s_server = "65.175.107.2:3306";
$s_userName = "cms_user";
$s_password = "alvahugh";
$s_db = "cms";
$s_primaryKey = "actionID";
$s_tableName = "cms.log_timetrack";
$s_icon = "../../images/Clock-Icon-by-Nagaya.png";
$s_act = set_var('act','list');
$i_actionID = intval(set_var('actionID',0));
$i_projectID = intval(set_var('projectID',0));
$i_timeTypeID = intval(set_var('timeTypeID',0));
$s_actionDateTime = set_var('actionDateTime',date('Y-m-d H:i:s'));
$i_duration = intval(set_var('duration',0));
$s_action = set_var('action','');
$s_week = set_var('week','');
$s_description = set_var('description','');
$i_miles = intval(set_var('miles',0));
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
$s_header .= '<a href="timeTrack.php?act=list" target="_top"><img src="'.$s_icon.'" border="0" height="24" width="24"></a>';
$s_header .= '&nbsp;'.$g_break;
if ($s_act != "report") {
	$s_header .= '<span class="title">'.$s_pageName.'</span>'.$g_break;
	$s_header .= '<span id="swirly" style="display">&nbsp;<img src="../../images/new-spinner.gif" border="0" height="12" width="12" title="loading..."></span><br />';
	$s_header .= '<a href="actions_acd.php" target="_top"><img src="../../images/apply.gif" border="0" height="16" width="17" title="New Action"></a>&nbsp;';
	$s_header .= '<a href="projects_acd.php" target="_top"><img src="../../images/32px-Icon02_09.png" border="0" height="20" width="20" title="New Project"></a>&nbsp;';
	//$s_header .= '<a href="timeTrack.php?act=report" target="_top"><img src="../../images/text-file-16x16.png" border="0" height="16" width="16" title="Report"></a>';
	$s_header .= '<br />'.$g_break;
}
$s_header .= '<br />'.$g_break;
switch ($s_act) {
    case "save":
    	$act="list";
		if ($i_actionID > 0) {
			$s_sql = 'update log_timetrack set
				projectID = '.intval($i_projectID).',
				timeTypeID = '.intval($i_timeTypeID).',
				actionDateTime = "'.$s_actionDateTime.'",
				duration = '.intval($i_duration).',
				action = "'.SQLSafe($s_action).'",
				description = "'.SQLSafe($s_description).'",
				miles = '.intval($i_miles).'
				where actionID = '.intval($i_actionID).';';
		} else {
			if ($i_projectID > 0 && $i_timeTypeID > 0) { 
				$s_sql = 'insert into log_timetrack (projectID, timeTypeID, actionDateTime, duration, action, description, miles)
				values ('.intval($i_projectID).','.intval($i_timeTypeID).',"'.$s_actionDateTime.'",'.intval($i_duration).',"'.SQLSafe($s_action).'","'.SQLSafe($s_description).'",'.intval($i_miles).');';
			}
		}
		if ($s_sql > "") {
			$q_update = mysql_query($s_sql);
			if (!$q_update) {die_well(__LINE__,mysql_error(),$s_sql);}
		}
		header("Location: $s_fileName"); 		
    	break;
	case "list":
		echo $s_header;
		$act=$s_act;
		$s_sql = 'select T.actionID, T.projectID, T.timeTypeID, T.actionDateTime, T.duration, T.action, T.description, T.miles, P.project, A.timeType, (T.duration*60) as "eseconds" 
			from cms.log_timetrack T
			inner join cms.cfg_projects P
			    on T.projectID = P.projectID
			inner join cms.cfg_time_types A
			    on A.timeTypeID = T.timeTypeID
			order by T.actionDateTime DESC;';
		$q_data = mysql_query($s_sql);
		if (!$q_data) {die_well(__LINE__,mysql_error());}
		$i_fields = mysql_num_fields($q_data);
		//echo time();
		echo '<table border="0" style="border-collapse: collapse;">';
		echo '<tr>';
		echo '<th class="accentrow">';
		echo '<a href="'.$s_fileName.'?'.$s_primaryKey.'=0&act=show" target="_top"><img src="../../images/Button-Add-16x16.png" border="0" height="12" width="12" title="Add"></a>';
		echo '</th>';
		echo '<th class="accentrow" align="right">Day</th>';
		//echo '<th class="accentrow" align="right">Start</th>'; 
		//echo '<th class="accentrow" align="right">End</th>';
		echo '<th class="accentrow" align="right">Duration</th>';
		echo '<th class="accentrow" align="right">Miles</th>';
		echo '<th class="accentrow" align="right">Project</th>';
		echo '<th class="accentrow">Type</th>';
		echo '<th class="accentrow">Action</th>';
		echo '<th class="accentrow">Description</th>';
		echo '</tr>';
		$s_project_hold = "";
		$i_totalRows=7;
		$i_currRow=0;
		$i_totalTime=0;
		while ($rowData = mysql_fetch_row($q_data)) {
			$i_seconds = $rowData[10];
			$s_starttime = $rowData[3];
			echo '<tr>';
			if ($i_currRow % 2) {$s_class="odd";}else{$s_class="even";}	
			echo '<td class="'.$s_class.'"><a href="'.$s_fileName.'?'.$s_primaryKey.'='.$rowData[0].'&act=show" target="_top"><img src="../../images/Button-Pause-16x16.png" border="0" height="12" width="12" title="show"></a></td>';
			echo '<td class="'.$s_class.'">'.$s_starttime.'</td>';
			//echo '<td class="'.$s_class.'">'.date("h:m A",strtotime($rowData[3])).' - '.strtotime($rowData[3]).'</td>';
			//echo '<td class="'.$s_class.'">'.date("h:m A",strtotime($s_starttime+$i_seconds)).'</td>';
			echo '<td class="'.$s_class.'" align="right">'.$rowData[4].'</td>';
			echo '<td class="'.$s_class.'" align="right">'.$rowData[7].'</td>';
			echo '<td class="'.$s_class.'">'.$rowData[9].'</td>';
			echo '<td class="'.$s_class.'">'.$rowData[8].'</td>';
			echo '<td class="'.$s_class.'">'.$rowData[5].'</td>';
			echo '<td class="'.$s_class.'">'.$rowData[6].'</td>';
		    echo '</tr>';
		    $i_currRow++;
		}
		echo '</table>'.$g_break;
		mysql_free_result($q_data);

		$num_weeks = 26;  
		$timestamp = strtotime("1/4/2010");
		$i_total = 9;
		echo '<br />'.$g_break;
		echo '<div class="subheader">Weekly Invoice</div>';
		echo '<table>'.$g_break;
		echo '<tr>';
		echo '<td valign="top">';
		for($i=1;$i<=$num_weeks;$i++) {
			if ($i_count == $i_total) {
				$i_count = 0;
				echo '</td><td valign="top">';
			}
			echo $i.' <a href="'.$s_fileName.'?act=report&week='.date('Y',$timestamp)."".date('W',$timestamp).'">'.date('m/d/Y',$timestamp).'</a><br />';
			$timestamp = strtotime('+1 week', $timestamp);
			$i_count++;
		}
		echo '</td>';
		echo '</tr>';
		echo '</table>'.$g_break;  		
		
		break;
    	case "list2":
		echo $s_header;
		$act=$s_act;
		$s_sql = 'select T.actionID, T.projectID, T.timeTypeID, T.actionDateTime, T.duration, T.action, T.description, T.miles, P.project, A.timeType 
			from cms.log_timetrack T
			inner join cms.cfg_projects P
			    on T.projectID = P.projectID
			inner join cms.cfg_time_types A
			    on A.timeTypeID = T.timeTypeID
			order by P.project, actionDateTime;';
		$q_data = mysql_query($s_sql);
		if (!$q_data) {die_well(__LINE__,mysql_error());}
		$i_fields = mysql_num_fields($q_data);
		echo '<table border="0" style="border-collapse: collapse;">';
		echo '<tr>';
		echo '<th class="accentrow">';
		echo '<a href="'.$s_fileName.'?'.$s_primaryKey.'=0&act=show" target="_top"><img src="../../images/Button-Add-16x16.png" border="0" height="12" width="12" title="Add"></a>';
		echo '</th>';
		echo '<th class="accentrow">Date Time</th>';
		echo '<th class="accentrow" align="right">Duration</th>'; 
		echo '<th class="accentrow" align="right">Miles</th>';
		echo '<th class="accentrow">Type</th>';
		echo '<th class="accentrow">Action</th>';
		echo '<th class="accentrow">Description</th>';
		echo '</tr>';
		$s_project_hold = "";
		$i_totalRows=7;
		$i_currRow=0;
		$i_totalTime=0;
		while ($rowData = mysql_fetch_row($q_data)) {
			if ($s_project_hold != $rowData[8] || $i_currRow == 0) {
				if ($i_totalTime > 0) {
					echo '<tr><td class="emphasisrow" colspan="'.$i_totalRows.'"><strong>Time: '.$i_totalTime.'</strong></td></tr>';
				}
				echo '<tr><td class="offsetrow" colspan="'.$i_totalRows.'"><strong>'.$rowData[8].'</strong></td></tr>';
				$i_totalTime = 0;
			}
			echo '<tr>';
			if ($i_currRow % 2) {$s_class="odd";}else{$s_class="even";}	
			echo '<td class="'.$s_class.'"><a href="'.$s_fileName.'?'.$s_primaryKey.'='.$rowData[0].'&act=show" target="_top"><img src="../../images/Button-Pause-16x16.png" border="0" height="12" width="12" title="show"></a></td>';
			echo '<td class="'.$s_class.'">'.$rowData[3].'</td>';
			echo '<td class="'.$s_class.'" align="right">'.$rowData[4].'</td>';
			echo '<td class="'.$s_class.'" align="right">'.$rowData[7].'</td>';
			echo '<td class="'.$s_class.'">'.$rowData[9].'</td>';
			echo '<td class="'.$s_class.'">'.$rowData[5].'</td>';
			echo '<td class="'.$s_class.'">'.$rowData[6].'</td>';
		    echo '</tr>';
		    $i_totalTime = $i_totalTime + $rowData[4];
		    $s_project_hold = $rowData[8];
		    $i_currRow++;
		}
		if ($i_totalTime > 0) {
			echo '<tr><td class="emphasisrow" colspan="'.$i_totalRows.'"><strong>Time: '.number_format($i_totalTime,0).'</strong></td></tr>';
		}
		echo '</table>'.$g_break;
		mysql_free_result($q_data);

		$num_weeks = 26;  
		$timestamp = strtotime("1/4/2010");
		$i_total = 9;
		echo '<br />'.$g_break;
		echo '<div class="subheader">Weekly Invoice</div>';
		echo '<table>'.$g_break;
		echo '<tr>';
		echo '<td valign="top">';
		for($i=1;$i<=$num_weeks;$i++) {
			if ($i_count == $i_total) {
				$i_count = 0;
				echo '</td><td valign="top">';
			}
			echo $i.' <a href="'.$s_fileName.'?act=report&week='.date('Y',$timestamp)."".date('W',$timestamp).'">'.date('m/d/Y',$timestamp).'</a><br />';
			$timestamp = strtotime('+1 week', $timestamp);
			$i_count++;
		}
		echo '</td>';
		echo '</tr>';
		echo '</table>'.$g_break;  		
		
		break;
    case "show":
    	echo $s_header;
    	$act="save";
		$s_sql = 'select actionID, projectID, timeTypeID, actionDateTime, duration, action, description, miles from cms.log_timetrack where actionID = '.$i_actionID.';';
		$q_data = mysql_query($s_sql);
		if (!$q_data) {die_well(__LINE__,mysql_error(),$s_sql);}
		while ($rowData = mysql_fetch_row($q_data)) {
			$i_actionID = $rowData[0]; 
			$i_projectID = $rowData[1]; 
			$i_timeTypeID = $rowData[2];
			if (trim($rowData[3]) == "" || trim($rowData[3]) == "0000-00-00 00:00:00") {
				$s_actionDateTime = date('Y-m-d h:i A');
			}else{
				$s_actionDateTime = $rowData[3];	
			}
			$i_duration = $rowData[4];
			$s_action = $rowData[5];
			$s_description = $rowData[6]; 
			$i_miles = $rowData[7];
		}
		mysql_free_result($q_data);
		echo '<a href="'.$s_fileName.'?pid='.$s_pid.'" target="_top"><img src="../../images/Button-Info-16x16.png" border="0" height="12" width="12" title="List"></a>';
		echo '<form id="frmEdit" name="frmEdit" action="'.$s_fileName.'" method="post">';
		echo '<input type="hidden" name="act" id="act" value="'.$act.'">';
		echo '<input type="hidden" name="'.$s_primaryKey.'" id="'.$s_primaryKey.'" value="'.$i_actionID.'">';
		echo '<table style="border-collapse: collapse;">'.$g_break;
		$s_sql = 'select projectID, project from cms.cfg_projects where active = 1 order by project;';
		$q_list = mysql_query($s_sql);
		if (!$q_list) {die_well(__LINE__,mysql_error(),$s_sql);}
		echo row_input_select($q_list=$q_list,$s_fieldName="projectID",$i_items=0,$i_data=$i_projectID,$left_class="odd",$right_class="even",$s_fieldString="Project",$use_input=1,$use_hidden=0,$value_only=0).$g_break;
		mysql_free_result($q_list);
		$s_sql = 'select timeTypeID, timeType from cms.cfg_time_types where active = 1 order by timeType;';
		$q_list = mysql_query($s_sql);
		if (!$q_list) {die_well(__LINE__,mysql_error(),$s_sql);}
		echo row_input_select($q_list=$q_list,$s_fieldName="timeTypeID",$i_items=0,$i_data=$i_timeTypeID,$left_class="odd",$right_class="even",$s_fieldString="Action",$use_input=1,$use_hidden=0,$value_only=0).$g_break;
		mysql_free_result($q_list);
		echo row_input_text($s_fieldName="actionDateTime",$i_fieldSize=20,$s_data=$s_actionDateTime,$left_class="odd",$right_class="even",$s_fieldString="Action Date/Time",$use_input=1,$use_hidden=0,$value_only=0).$g_break;
		echo row_input_text($s_fieldName="duration",$i_fieldSize=5,$s_data=$i_duration,$left_class="odd",$right_class="even",$s_fieldString="Duration",$use_input=1,$use_hidden=0,$value_only=0).$g_break;
		echo row_input_text($s_fieldName="action",$i_fieldSize=50,$s_data=$s_action,$left_class="odd",$right_class="even",$s_fieldString="Action",$use_input=1,$use_hidden=0,$value_only=0).$g_break;
		echo row_input_memo($s_fieldName="description",$i_rows=10,$i_cols=80,$s_data=$s_description,$left_class="odd",$right_class="even",$s_fieldString="Description",$use_input=1,$use_hidden=0,$value_only=0).$g_break;
		echo row_input_text($s_fieldName="miles",$i_fieldSize=5,$s_data=$i_miles,$left_class="odd",$right_class="even",$s_fieldString="Miles",$use_input=1,$use_hidden=0,$value_only=0).$g_break;		
		if ($i_actionID > 0) {$s_text = "Save";}else{$s_text = "Add";}		
		echo '<tr>'.$g_break;
		echo '<td class="odd">&nbsp;</td>'.$g_break;
		echo '<td class="even"><input type="submit" id="submit_form" name="submit_form" value="'.$s_text.'"></td>'.$g_break;
		echo '</tr>'.$g_break;
		echo '</table>'.$g_break;
		echo '</form>';		
        break;
	case "report":
    	echo $s_header;

		$s_sql = 'select min(actionDateTime), max(actionDateTime) from cms.log_timetrack where yearweek(actionDateTime,0) = '.$s_week.';';
		$q_head = mysql_query($s_sql);
		if (!$q_head) {die_well(__LINE__,mysql_error(),$s_sql);}
		while ($rowhead = mysql_fetch_row($q_head)) {
			$s_from = $rowhead[0]; 
			$s_to = $rowhead[1]; 
		}
		mysql_free_result($q_head);
		echo '<table border="0" style="border-collapse: collapse;">';
		echo '<tr>'.$g_break;
		echo '<td colspan="5" style="font-size: 2em;" valign="top"><strong>Invoice</strong></td>';
	    echo '</tr>'.$g_break;
		echo '<tr>';
		echo '<td class="title" valign="top">Remit To:</td>';
		echo '<td class="header" valign="top" rowspan="3">Brad Hughes<br />2535 Clover RD NW<br />Concord NC, 28027</td>';
		echo '<td class="title" valign="top">&nbsp;&nbsp;&nbsp;</td>';
		echo '<td class="title" valign="top"><strong>Invoice Number:</strong></td>';
		echo '<td class="header" valign="top" colspan="2">'.$s_week.'</td>';		
	    echo '</tr>'.$g_break;
	    echo '<tr>';
		echo '<td class="title" valign="top">&nbsp;</td>';
		echo '<td class="header" valign="top">&nbsp;</td>';
		echo '<td class="title" valign="top"><strong>Week Of:</strong></td>';
		echo '<td class="header" valign="top" colspan="2">'.date_format(date_create($s_from),'m/d/Y').' &mdash; '.date_format(date_create($s_to),'m/d/Y').'</td>';
	    echo '</tr>'.$g_break;
   	    echo '<tr>';
		echo '<td class="title" valign="top">&nbsp;</td>';
		echo '<td class="header" valign="top">&nbsp;</td>';
		echo '<td class="title" valign="top">Date:</td>';
		echo '<td class="header" valign="top">'.date('m/d/Y').'</td>';
	    echo '</tr>'.$g_break;
		echo '</table>'.$g_break;
		echo '<br />'.$g_break;
		$s_sql = 'select yearweek(T.actionDateTime,0) as "week", T.actionDateTime, T.duration, T.miles, P.project, A.timeType, T.action, T.description 
			from cms.log_timetrack T
			inner join cms.cfg_projects P
			    on T.projectID = P.projectID
			inner join cms.cfg_time_types A
			    on A.timeTypeID = T.timeTypeID
			where yearweek(T.actionDateTime,0) = '.$s_week.'
			order by T.actionDateTime, P.project;';
		$q_data = mysql_query($s_sql);
		if (!$q_data) {die_well(__LINE__,mysql_error(),$s_sql);}
		echo '<table border="0" style="border-collapse: collapse;">';
		echo '<tr>';
		echo '<th class="accentrow">Date Time</th>';
		echo '<th class="accentrow" align="right">Minutes</th>'; 
		echo '<th class="accentrow" align="right">Miles</th>';
		echo '<th class="accentrow">Project</th>';
		echo '<th class="accentrow" colspan="2">Detail</th>';
		echo '</tr>';
		$i_totalRows=7;
		$i_currRow=0;
		$i_totalTime=0;
		while ($rowData = mysql_fetch_row($q_data)) {
			if ($i_currRow % 2) {$s_class="odd";}else{$s_class="even";}
			echo '<tr>';
			echo '<td class="'.$s_class.'">'.$rowData[1].'</td>';
			echo '<td class="'.$s_class.'" align="right">'.($rowData[2]).'</td>';
			echo '<td class="'.$s_class.'" align="right">'.$rowData[3].'</td>';
			echo '<td class="'.$s_class.'">'.$rowData[4].'</td>';
			echo '<td class="'.$s_class.'">'.$rowData[5].' '.$rowData[6].'</td>';
		    echo '</tr>';
		    $i_totalTime = $i_totalTime + $rowData[2];
		    $i_currRow++;
		}
		mysql_free_result($q_data);
		echo '<tr>';
		echo '<td class="accentrow">Total</td>';
		echo '<td class="accentrow" align="right">'.number_format($i_totalTime,0).'</td>';
		echo '<td class="accentrow" colspan="3">&nbsp;</td>';
	    echo '</tr>'.$g_break;
		echo '<tr>';
		echo '<td class="accentrow"><strong>Amount Due</strong></td>';
		echo '<td class="accentrow" align="right"><strong>$'.number_format(($i_totalTime/60)*38,2).'</strong></td>';
		echo '<td class="accentrow" colspan="3">&nbsp;</td>';
	    echo '</tr>'.$g_break;
	    echo '</table>'.$g_break;		
		echo '<br /><br /><br />'.$g_break;
		echo '<table border="0" style="border-collapse: collapse;">';
		echo '<tr>';
		echo '<td class="title" valign="top">Consultant Signature:</td>';
		echo '<td class="title" valign="top" style="border-bottom: 1px solid black;width:300px;">&nbsp;</td>';
	    echo '</tr>'.$g_break;
	    echo '<tr>';
		echo '<td colspan="2"><br /><br /><br /></td>';
	    echo '</tr>'.$g_break;
		echo '<tr>';
		echo '<td class="title" valign="top">Supervisor Signature:</td>';
		echo '<td class="title" valign="top" style="border-bottom: 1px solid black;;width:300px;">&nbsp;</td>';
	    echo '</tr>'.$g_break;
		echo '</table>'.$g_break;
		
		break;
}
echo '<script language="javascript">'.$g_break;
echo 'document.getElementById("swirly").style.display = "none";'.$g_break;
echo '</script>'.$g_break;
echo '</body>'.$g_break; 
echo '</html>'.$g_break;
?>