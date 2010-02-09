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
	if (isset($_POST['textContent'])) {
		$s_textContent = trim($_POST["textContent"]);
	} else {
		$s_textContent = "";
	}
	if (isset($_POST['contentTitle'])) {
		$s_contentTitle = trim($_POST["contentTitle"]);
	} else {
		$s_contentTitle = "";
	}
	$s_sql = "insert into cms.dyn_howto_content (howtoID, headingID, displayOrder, howtoContent, contentTitle)
	select $i_howtoID, $i_headingID, $i_displayOrder, '$s_textContent', '$s_contentTitle';";
	$q_data = mysql_query($s_sql);
	
	include("howto_c.php"); 
	$objhowTo = new howTo();
	$s_html = $objhowTo->outputHowTo();		
	/*

	$s_sql = "select
	    D.howtoName,
	    C.chapterID, 
	    C.chapterName, 
	    C.displayOrder,
	    H.headingID,
	    H.displayOrder,
	    H.headingName,
	    T.contentID,
	    T.contentTitle,
	    T.displayOrder,
	    T.howtoContent
	from cms.dyn_howto_document D
	inner join cms.dyn_howto_content T
	    on D.howtoID = T.howtoID
	inner join cms.cfg_howto_headings H
	    on H.headingID = T.headingID
	inner join cms.cfg_howto_chapters C
	    on C.chapterID = H.chapterID 
	order by
	    C.displayOrder,
	    H.displayOrder,
	    T.displayOrder,
	    T.howtoContent;";
	$q_data = mysql_query($s_sql);
	if (!$q_data) {die_well(mysql_error());}
	$s_html = '<table border="1">'.$g_break;
	while ($rowData = mysql_fetch_row($q_data)) {
	    $s_howtoName		= $rowData[0];
	    $i_chapterID		= $rowData[1]; 
	    $s_chapterName		= $rowData[2]; 
	    $i_displayOrderCha	= $rowData[3];
	    $i_headingID		= $rowData[4];
	    $i_displayOrderHed	= $rowData[5];
	    $s_headingName		= $rowData[6];
	    $i_contentID		= $rowData[7];
	    $s_contentTitle		= $rowData[8];
	    $i_displayOrderCon	= $rowData[9];
	    $s_howtoContent		= $rowData[10];
	    $s_html .= '<tr>'.$g_break;
	    $s_html .= '<td>'.$s_howtoName.'</td>'.$g_break;
	    $s_html .= '<td>'.$s_chapterName.'</td>'.$g_break;
	    $s_html .= '<td>'.$s_headingName.'</td>'.$g_break;
	    $s_html .= '<td>'.$s_contentTitle.'</td>'.$g_break;
	    $s_html .= '<td>'.$i_displayOrderCon.'</td>'.$g_break;
	    $s_html .= '<td>'.$s_howtoContent.'</td>'.$g_break;
	    //$s_html .= '<td>'.$i_chapterID.'</td>'.$g_break;
	    //$s_html .= '<td>'.$i_displayOrderCha.'</td>'.$g_break;
	    //$s_html .= '<td>'.$i_headingID.'</td>'.$g_break;
	    //$s_html .= '<td>'.$i_displayOrderHed.'</td>'.$g_break;
	    //$s_html .= '<td>'.$i_contentID.'</td>'.$g_break;
	    $s_html .= '</tr>'.$g_break;
	}
	$s_html .= '</table>'.$g_break;
	*/
	
	break;
case "getdetail":
	break;
}
echo $s_html;
?>