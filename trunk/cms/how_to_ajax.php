<?php
include "..\common\ajax_include.php";
$s_html = "";
$s_task =  set_var("task","");

include("howto_c.php"); 
$objhowTo = new howTo();

switch ($s_task) {
case "getHeading":
$s_server = "65.175.107.2:3306";
$s_userName = "cms_user";
$s_password = "alvahugh";
$s_db = "cms";
$o_conn = mysql_connect($server=$s_server,$username=$s_userName,$password=$s_password);
if (!$o_conn) {die_well(mysql_error());}
$o_sel = mysql_select_db($s_db);
if (!$o_sel) {die_well(mysql_error());}


	if (isset($_POST['chapterID'])) {
		$i_chapterID = intval($_POST['chapterID']);
	} else {
		$i_chapterID = 0;
	}
	$s_sql = "select 	
	    headingID, displayOrder, headingName
	from 
	    cms.cfg_howto_headings
	WHERE 
	    chapterID = $i_chapterID 
	order by 
    	displayOrder, headingName";
	$q_data = mysql_query($s_sql);
	if (!$q_data) {die_well(mysql_error());}
	$s_headingText = '';
	if (mysql_num_rows($q_data)){
		$s_headingText = '<select id="headingID" name="headingID">'."\n";
		while ($rowData = mysql_fetch_row($q_data)) {
			$s_headingText .= '<option value="'.$rowData[0].'">'.$rowData[1].'. '.$rowData[2].'</option>'."\n";
		}
		$s_headingText .= '</select>'."\n";
	} else {
		$s_headingText .= '<input type="hidden" id="headingID" name="headingID" value="0">'."\n";
	}
	$s_html = $s_headingText;
	break;
case "saveContent":
	$i_howtoID =  intval(set_var("howtoID",0));
	$i_chapterID =  intval(set_var("chapterID",0));
	$i_headingID =  intval(set_var("headingID",0));
	$i_displayOrder =  intval(set_var("displayOrder",0));
	$s_contentTitle =  set_var("contentTitle","");
	$s_textContent =  set_var("textContent","");
	$s_sql = "insert into cms.dyn_howto_content (howtoID, chapterID, headingID, displayOrder, howtoContent, contentTitle, addedDate)
	select $i_howtoID, $i_chapterID, $i_headingID, $i_displayOrder, '$s_textContent', '$s_contentTitle', now();";
	
	$s_html = $objhowTo->saveItem(2, $s_sql);
	
	break;
case "getdetail":
	break;
}
echo $s_html;
?>