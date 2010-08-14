<?php
$s_html = "";
$s_task = "";
if (isset($_POST['task'])) {$s_task = $_POST['task'];}

$s_server = "65.175.107.2:3306";
$s_userName = "cms_user";
$s_password = "alvahugh";
$s_db = "cms";
$o_conn = mysql_connect($server=$s_server,$username=$s_userName,$password=$s_password);
if (!$o_conn) {die_well(mysql_error());}
$o_sel = mysql_select_db($s_db);
if (!$o_sel) {die_well(mysql_error());}

switch ($s_task) {
case "getHeading":
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
	if (isset($_POST['howtoID'])) {
		$i_howtoID = intval($_POST["howtoID"]);
	} else {
		$i_howtoID = 0;
	}
	
	if (isset($_POST['chapterID'])) {
		$i_chapterID = intval($_POST["chapterID"]);
	} else {
		$i_chapterID = 0;
	}
	if (isset($_POST['headingID'])) {
		$i_headingID = intval($_POST["headingID"]);
	} else {
		$i_headingID = 0;
	}
	if (isset($_POST['displayOrder'])) {
		$i_displayOrder = intval($_POST["displayOrder"]);
	} else {
		$i_displayOrder = 0;
	}
	if (isset($_POST['contentTitle'])) {
		$s_contentTitle = trim($_POST["contentTitle"]);
	} else {
		$s_contentTitle = "";
	}
	if (isset($_POST['textContent'])) {
		$s_textContent = trim($_POST["textContent"]);
	} else {
		$s_textContent = "";
	}
	$s_sql = "insert into cms.dyn_howto_content (howtoID, chapterID, headingID, displayOrder, howtoContent, contentTitle)
	select $i_howtoID, $i_chapterID, $i_headingID, $i_displayOrder, '$s_textContent', '$s_contentTitle';";
	$q_data = mysql_query($s_sql);
	$s_error = "";
	if (!$q_data) {$s_error = mysql_error();}
	include("howto_c.php"); 
	$objhowTo = new howTo();
	$s_html = $objhowTo->outputHowTo();
	
	break;
case "getdetail":
	break;
}
echo $s_html;
?>