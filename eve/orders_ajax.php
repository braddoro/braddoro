<?php
$s_html = "";
$s_task = "";
if (isset($_POST['task'])) {$s_task = $_POST['task'];}
if (isset($_POST['itemID'])) {$i_itemID = $_POST['itemID'];}
if (isset($_POST['orderID'])) {$i_orderID = $_POST['orderID'];}
include("orders_c.php"); 
$objorders = new c_order();

switch ($s_task) {
	
case "output":
	$s_html = $objorders->main($i_orderID);		
	break;

case "editItem":
	$s_html = $objorders->input($i_itemID, $i_orderID);
	break;

case "saveItem":
	if (isset($_POST['itemName'])) {$s_itemName = $_POST['itemName'];}
	if (isset($_POST['amount'])) {$i_amount = $_POST['amount'];}
	if (isset($_POST['itemStatusID'])) {$i_itemStatusID = $_POST['itemStatusID'];}
	$s_html = $objorders->saveItem($i_itemID, $i_orderID, $s_itemName, $i_amount, $i_itemStatusID);
	break;
case "saveNote":
	if (isset($_POST['noteBy'])) {$noteBy = $_POST['noteBy'];}
	if (isset($_POST['note'])) {$note = $_POST['note'];}
	$s_html = $objorders->saveNote($i_orderID, $noteBy, $note);
	break;
case "showNote":
	$s_html = $objorders->showNote($i_orderID);
	break;
case "editNote":
	$s_html = $objorders->editNote($i_orderID);
	break;
	
}
echo $s_html;
?>