<?php
include "_functions.php";
header("Cache: private");
$s_fileName = basename(__FILE__);
$s_pageName = "Order Status";
$s_server = "65.175.107.2:3306";
$s_userName = "webapp";
$s_password = "alvahugh";
$s_db = "braddoro";
$s_publicID = set_var('pid',0);
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
$s_header .= '<span class="title">'.$s_pageName.'</span>'.$g_break;
$s_header .= '<br /><br />'.$g_break;
		echo $s_header;
		$page_task=$s_page_task;
		$s_sql = "select O.orderID, O.client, O.leadMiner, O.orderDate, O.dueDate, O.publicID, P.priority,  
S1.status, 
I.itemName, I.amount, S2.status, N.noteDate, N.noteBy, N.note   
from braddoro.dyn_eve_mining_order O
inner join braddoro.cfg_eve_mining_order_status S1
    on O.orderStatusID = S1.statusID 
inner join braddoro.dyn_eve_mining_order_item I
    on O.orderID = I.orderID
inner join braddoro.cfg_eve_mining_order_status S2
    on I.itemStatusID = S2.statusID 
inner join braddoro.cfg_eve_mining_priority P
    on O.priorityID = P.priorityID 
left join braddoro.dyn_eve_mining_order_note N
    on O.orderID = N.orderID
where O.publicID = '57118306-2336-11df-919e-7075fb89bd16'
order by O.orderID, N.noteDate; 
";
$q_data = mysql_query($s_sql);
if (!$q_data) {die_well(__LINE__,mysql_error());}
echo '<table border="0" style="border-collapse:collapse;" cellpadding="5">';
//echo '<tr>';
//echo '<th class="accentrow">&nbsp;</th>';
//echo '<th class="accentrow">Order ID</th>';
//echo '<th class="accentrow">Priority</th>';
//echo '<th class="accentrow">Client</th>';
//echo '<th class="accentrow">Lead Miner</th>';
//echo '<th class="accentrow">Status</th>';
//echo '<th class="accentrow">Order Date</th>';
//echo '<th class="accentrow">Due Date</th>';
//echo '<th class="accentrow">Deliver To</th>';
//echo '</tr>';
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
echo '</body>'.$g_break; 
echo '</html>'.$g_break;
?>