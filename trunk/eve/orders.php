<?php
/* Report
 select O.orderID, O.client, O.leadMiner, O.orderDate, O.dueDate, O.publicID, 
S1.status, I.itemName, I.amount, S2.status, N.noteDate, N.noteBy, N.note   
from braddoro.dyn_eve_mining_order O
inner join braddoro.cfg_eve_mining_order_status S1
    on O.orderStatusID = S1.statusID 
inner join braddoro.dyn_eve_mining_order_item I
    on O.orderID = I.orderID
inner join braddoro.cfg_eve_mining_order_status S2
    on I.itemStatusID = S2.statusID 
left join braddoro.dyn_eve_mining_order_note N
    on O.orderID = N.orderID
where O.publicID = '80d6cdd5-1b6b-11df-919e-7075fb89bd16'
order by O.orderID, N.noteDate 
 */
include "_functions.php";
header("Cache: private");
$s_fileName = basename(__FILE__);
$s_pageName = "Orders";
$s_server = "65.175.107.2:3306";
$s_userName = "webapp";
$s_password = "alvahugh";
$s_db = "braddoro";
$s_page_task = set_var('page_task','list');
$i_orderID = set_var('orderID',0);
$s_client = set_var('client',"");
$s_leadMiner = set_var('leadMiner',"");
$s_deliverySystem = set_var('deliverySystem',"");
$s_orderDate = set_var('orderDate',0);
$s_dueDate = set_var('dueDate',0);
$i_orderStatusID = set_var('orderStatusID',0);
$i_priorityID = set_var('priorityID',0);
$s_publicID = set_var('pid',0);
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
$s_header .= '<script type="text/javascript" src="..\common\ajax.js"></script>'.$g_break;
$s_header .= '<script type="text/javascript" src="orders.js"></script>'.$g_break;
$s_header .= '<script language="javascript" type="text/javascript" src="..\common\mootools-1.2.4-core-nc.js"></script>'.$g_break;
$s_header .= '<script language="javascript" type="text/javascript" src="..\common\datepicker.js"></script>'.$g_break;
$s_header .= '<link rel="stylesheet" href="..\common\datepicker_vista.css" type="text/css">'.$g_break;
$s_header .= '<style type="text/css">'.$g_break;
$s_header .= '	input.date {width: 70px;color: #000;background-color:ivory;};'.$g_break;
$s_header .= '</style>'.$g_break;
$s_header .= '<script language="javascript" type="text/javascript">'.$g_break;
$s_header .= '	window.addEvent("load", function() {new DatePicker(".demo_vista", {pickerClass: "datepicker_vista", format: "m/d/Y", positionOffset: { x: 0, y: 5 }});});'.$g_break;
$s_header .= '</script>'.$g_break;
$s_header .= '</head>'.$g_break; 
$s_header .= '<body class="body">'.$g_break;
$s_header .= '<img src="../../images/32px-Icon02_09.png" border="0">';
$s_header .= '<span class="title">'.$s_pageName.'</span>'.$g_break;
//$s_header .= '<span class="headerlabel"><a href="tower_overview.cfm?task=home&pid='.$s_publicID.'">home</a>'.$g_break;
$s_header .= '<span id="swirly" style="display">&nbsp;<img src="../../images/new-spinner.gif" border="0" height="12" width="12" title="loading..."></span>';
$s_header .= '<br /><br />'.$g_break;
switch ($s_page_task) {
    case "save":
    	$page_task="list";
		if ($s_submit > "") {
			if ($i_orderID > 0) {
				//echo $s_orderDate;
				//echo $s_dueDate;
				$s_sql = "update braddoro.dyn_eve_mining_order set orderStatusID=$i_orderStatusID, client='$s_client', leadMiner='$s_leadMiner', deliverySystem = '$s_deliverySystem', orderDate='".date("Y-m-d",$s_orderDate)."', dueDate='".date("Y-m-d",$s_dueDate)."', priorityID = $i_priorityID where orderID=$i_orderID;";
				//echo $s_sql;
				$q_update = mysql_query($s_sql);
				if (!$q_update) {die_well(__LINE__,mysql_error());}
			} else {
				if ($s_client > "") { 
					$s_sql = "insert into braddoro.dyn_eve_mining_order (orderStatusID, client, leadMiner, deliverySystem, orderDate, dueDate, publicID, priorityID) select $i_orderStatusID, '$s_client', '$s_leadMiner', '$s_deliverySystem', '".date("Y-m-d",$s_orderDate)."', '".date("Y-m-d",$s_dueDate)."', uuid(), $i_priorityID;";
					$q_update = mysql_query($s_sql);
					if (!$q_update) {die_well(__LINE__,mysql_error());}
					$i_orderID = mysql_insert_id();
				}
			}
		}
		header("Location: $s_fileName?pid=$s_publicID");
    	break;
	case "list":
		echo $s_header;
		$page_task=$s_page_task;
		$s_sql = "select orderID, client, leadMiner, S.status, orderDate, dueDate, deliverySystem, P.priority 
		from braddoro.dyn_eve_mining_order O 
		left join braddoro.cfg_eve_mining_order_status S 
			on O.orderStatusID = S.statusID 
		left join cfg_eve_mining_priority P
			on O.priorityID = P.priorityID
		order by orderID desc;";
		$q_data = mysql_query($s_sql);
		if (!$q_data) {die_well(__LINE__,mysql_error());}
		$i_fields = mysql_num_fields($q_data);
		echo '<a href="'.$s_fileName.'?orderID=0&page_task=edit&pid='.$s_publicID.'" target="_top"><img src="../../images/Button-Play-16x16.png" border="0" height="12" width="12" title="Add"></a>';
		echo '<table border="0" style="border-collapse:collapse;" cellpadding="5">';
		echo '<tr>';
		echo '<th class="accentrow">&nbsp;</th>';
		echo '<th class="accentrow">Order ID</th>';
		echo '<th class="accentrow">Priority</th>';
		echo '<th class="accentrow">Client</th>';
		echo '<th class="accentrow">Lead Miner</th>';
		echo '<th class="accentrow">Status</th>';
		echo '<th class="accentrow">Order Date</th>';
		echo '<th class="accentrow">Due Date</th>';
		echo '<th class="accentrow">Deliver To</th>';
		echo '</tr>';
		while ($rowData = mysql_fetch_row($q_data)) {
			if ($i_currRow % 2) {$s_class="odd";}else{$s_class="even";}
			echo '<tr class="'.$s_class.'">';
			echo '<td><a href="'.$s_fileName.'?orderID='.$rowData[0].'&page_task=edit" target="_top"><img src="../../images/Button-Pause-16x16.png" border="0" height="12" width="12" title="Edit"></a></td>';
			echo '<td>'.$rowData[0].'</td>';
			echo '<td>'.$rowData[7].'</td>';
			echo '<td>'.$rowData[1].'</td>';
			echo '<td>'.$rowData[2].'</td>';
			echo '<td>'.$rowData[3].'</td>';
			echo '<td>'.date("m/d/Y",strtotime($rowData[4])).'</td>';
			echo '<td>'.date("m/d/Y",strtotime($rowData[5])).'</td>';
			echo '<td>'.$rowData[6].'</td>';
		    echo '</tr>';
		    $i_currRow++;
		}
		echo '</table>';
		echo '<br />';
		$s_sql = "SELECT
			O.orderID, O.client, N.noteDate, N.noteBy, N.note 
			from braddoro.dyn_eve_mining_order_note N
			inner join braddoro.dyn_eve_mining_order O
			on N.orderID = O.orderID 
			
			union 
			
			SELECT
			O.orderID, O.client, I.updatedDate as 'noteDate', Concat(I.itemName, ' ', I.amount, ' ', S2.status) as 'noteBy', '' as 'note' 
			from braddoro.dyn_eve_mining_order_item I
			inner join braddoro.dyn_eve_mining_order O
			on I.orderID = O.orderID
			inner join braddoro.cfg_eve_mining_order_status S2
			    on I.itemStatusID = S2.statusID 
			
			ORDER BY noteDate desc
			limit 10
			;";
		$q_data = mysql_query($s_sql);
		if (!$q_data) {die_well(__LINE__,mysql_error());}
		echo '<table border="0" style="border-collapse:collapse;" cellpadding="5">';
		echo '<tr>';
		echo '<th class="accentrow" colspan="3">Recent Activities</th>';
		echo '</tr>';
		$i_currRow=1;
		while ($rowData = mysql_fetch_row($q_data)) {
			if ($i_currRow % 2) {$s_class="odd";}else{$s_class="even";}
			echo '<tr class="'.$s_class.'">';
			echo '<td>'.$rowData[0].' - '.$rowData[1].'</td>';
			echo '<td>'.date("m/d/Y h:i:s a",strtotime($rowData[2])).'</td>';
			echo '<td>'.$rowData[3].'</td>';
			echo '</tr>';
			echo '<tr class="'.$s_class.'">';
			echo '<td colspan="3">'.$rowData[4].'</td>';
		    echo '</tr>';
		    $i_currRow++;
		}
		echo '</table>';

    	break;
    case "edit":
    	echo $s_header;
    	$page_task="save";
		$s_sql = "select orderID, orderStatusID, client, leadMiner, orderDate, dueDate, publicID, deliverySystem, priorityID from braddoro.dyn_eve_mining_order where orderID = $i_orderID;";
		$q_data = mysql_query($s_sql);
		if (!$q_data) {die_well(__LINE__,mysql_error());}
		while ($rowData = mysql_fetch_row($q_data)) {
			$i_orderID = $rowData[0]; 
			$i_orderStatusID = $rowData[1]; 
			$s_client = $rowData[2];
			$s_leadMiner = $rowData[3];
			$s_orderDate = $rowData[4]; 
			$s_dueDate = $rowData[5];
			$s_publicID = $rowData[6];
			$s_deliverySystem = $rowData[7];
			$i_priorityID = $rowData[8];
		}
		echo '<a href="'.$s_fileName.'" target="_top"><img src="../../images/Button-Info-16x16.png" border="0" height="12" width="12" title="List"></a>';
		echo '<form id="frmForm" name="frmForm" action="'.$s_fileName.'" method="post">';
		echo '<input type="hidden" name="page_task" id="page_task" value="'.$page_task.'">';
		echo '<input type="hidden" name="pid" id="pid" value="'.$s_publicID.'">';
		echo '<table style="border-collapse: collapse;">'.$g_break;
		echo '<tr>'.$g_break;
		echo '<td class="accentrow">Order Information</td>'.$g_break;
		echo '<td class="body" style="width:75px;">&nbsp;</td>'.$g_break;
		echo '</tr>'.$g_break;
	
		echo row_input_text($s_fieldName="orderID",$i_fieldSize=5,$s_data=$i_orderID,$left_class="odd",$right_class="even",$s_fieldString="Order ID",$use_input=0,$use_hidden=1,$value_only=1).$g_break;
    	$s_sel = "select statusID, status from braddoro.cfg_eve_mining_order_status where active = 1 order by status";		
		echo row_input_select($s_fieldName="orderStatusID",$s_sel,$i_orderStatusID,$left_class="odd",$right_class="even",$s_fieldString="Status").$g_break;

    	$s_sel = "select priorityID, priority from braddoro.cfg_eve_mining_priority where active = 1 order by displayOrder";		
		echo row_input_select($s_fieldName="priorityID",$s_sel,$i_priorityID,$left_class="odd",$right_class="even",$s_fieldString="Priority").$g_break;

		echo row_input_text($s_fieldName="client",$i_fieldSize=30,$s_data=trim($s_client),$left_class="odd",$right_class="even",$s_fieldString="Client").$g_break;

		echo '<tr>'.$g_break;
		echo '<td class="odd">Order Date</td>'.$g_break;
		echo '<td class="even"><input id="orderDate" name="orderDate" type="text" value="'.strtotime($s_orderDate).'" class="date demo_vista" /></td>';
		echo '</tr>'.$g_break;
		
		echo '<tr>'.$g_break;
		echo '<td class="odd">Due Date</td>'.$g_break;
		echo '<td class="even"><input id="dueDate" name="dueDate" type="text" value="'.strtotime($s_dueDate).'" class="date demo_vista"/></td>'.$g_break;
		echo '</tr>'.$g_break;

		echo '<tr>'.$g_break;
		echo '<td class="odd">Lead Miner</td>'.$g_break;
		echo '<td class="even"><input id="leadMiner" name="leadMiner" type="text" value="'.$s_leadMiner.'" class="fields"/></td>';
		echo '</tr>'.$g_break;

		echo '<tr>'.$g_break;
		echo '<td class="odd">Deliver To</td>'.$g_break;
		echo '<td class="even"><input id="deliverySystem" name="deliverySystem" type="text" value="'.$s_deliverySystem.'" class="fields"/></td>';
		echo '</tr>'.$g_break;
		
		if ($i_orderID > 0) {$s_text = "Save";}else{$s_text = "Add";}		
		echo '<tr>'.$g_break;
		echo '<td class="odd">&nbsp;</td>'.$g_break;
		echo '<td class="even"><input type="submit" id="submit_form" name="submit_form" value="'.$s_text.'"></td>'.$g_break;
		echo '</tr>'.$g_break;
		echo '</table>'.$g_break;
		echo '</form>';		
		echo '<br />';
		include("orders_c.php"); 
		$objorders = new c_order();		
		echo $objorders->main($i_orderID);
		echo '<br />';
		echo $objorders->mainNote($i_orderID);
		break;
}
echo '<script language="javascript">'.$g_break;
echo 'document.getElementById("swirly").style.display = "none";'.$g_break;
echo '</script>'.$g_break;
echo '</body>'.$g_break; 
echo '</html>'.$g_break;
?>