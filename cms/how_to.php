<?php
$s_title = "How-To";
$g_break = chr(10).chr(13);

$s_server = "65.175.107.2:3306";
$s_userName = "cms_user";
$s_password = "alvahugh";
$s_db = "cms";
$o_conn = mysql_connect($server=$s_server,$username=$s_userName,$password=$s_password);
if (!$o_conn) {die_well(mysql_error());}
$o_sel = mysql_select_db($s_db);
if (!$o_sel) {die_well(mysql_error());}
$s_sql = "select chapterID, displayOrder, chapterName from cms.cfg_howto_chapters order by displayOrder, chapterName";
$q_data = mysql_query($s_sql);
if (!$q_data) {die_well(mysql_error());}
$s_chapterText = '<select id="chapterID" name="chapterID" onchange="js_getHeading(this.value);">'.$g_break;
while ($rowData = mysql_fetch_row($q_data)) {
	$s_chapterText .= '<option value="'.$rowData[0].'">'.$rowData[1].'. '.$rowData[2].'</option>'.$g_break;	
}
$s_chapterText .= '</select>'.$g_break;

$i_chapterID = 1;
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
	$s_headingText .= '<input type="hidden" id="headerID" name="headerID" value="0">'."\n";
}
include("howto_c.php"); 
$objhowTo = new howTo();		
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html>
<head>
<link rel="stylesheet" href="eve2.css">
<script type="text/javascript" src="ajax.js"></script>
<script type="text/javascript" language="JavaScript1.2">
	function js_getHeading(chapterID) {
		var s_ajax = "task=getHeading";
		s_ajax += "&chapterID=" + chapterID;
		var s_return = http_post_request("how_to_ajax.php", s_ajax);
		document.getElementById("span_heading").innerHTML = s_return; 
	}
	function js_save() {
		if (document.getElementById("headingID")) {
			var s_ajax = "task=saveContent";
			s_ajax += "&howtoID=1";
			s_ajax += "&headingID=" + document.getElementById("headingID").value;
			s_ajax += "&displayOrder=" + document.getElementById("displayOrder").value;
			s_ajax += "&contentTitle=" + document.getElementById("contentTitle").value;
			s_ajax += "&textContent=" + document.getElementById("textContent").value;
			s_ajax += "&";
			var s_return = http_post_request("how_to_ajax.php", s_ajax);
			document.getElementById("div_output").innerHTML = s_return;
			document.getElementById("displayOrder").value = "";
			document.getElementById("contentTitle").value = "";
			document.getElementById("textContent").value = "";
		}
	}
	function js_collapseThis(changeme,showType) {
		var s_showType = "block";
		if (arguments.length == 2) {
			s_showType = showType; 
		}
		if (document.getElementById(changeme).style.display == "none") {
			document.getElementById(changeme).style.display = s_showType;
		} else {
			document.getElementById(changeme).style.display = "none";
		}
	}
	function js_changeBG(changeme,colorbg) {
		document.getElementById(changeme).style.backgroundColor = colorbg;
	}
	function js_opener(myurl) {
		window.open(myurl,"_self","","false");
	}
</script>
<style type="text/css"> 
	.body {background-color: #F1EFDE;font-family: sans-serif;font-size: .8em}
	.cell {text-align: right;}
	.odd {padding: 2px;background-color: #99A68C;}
	.even {padding: 2px;background-color: #8A8A6A;}
	.accentrow {padding: 2px;background-color: #ACACAC;}
</style> 
<meta name="generator" content="<?php echo $s_title; ?>" /> 
<title><?php echo $s_title; ?></title>
</head>
<body class="body">
<?php
echo '<h3>'.$s_title.'<h3>'.$g_break;
echo '<br />'.$g_break;
echo '<span id="span_chapter" name="span_chapter">'.$s_chapterText.'</span>&nbsp;<span id="span_heading" name="span_heading">'.$s_headingText.'</span><br />'.$g_break;
echo '<input id="displayOrder" name="displayOrder" size="3"><br />'.$g_break;
echo '<input id="contentTitle" name="contentTitle" size="74" maxlength="500"><br />'.$g_break;
echo '<textarea id="textContent" name="textContent" rows="10" cols="60"></textarea><br />'.$g_break;
echo '<button id="button_click" name="button_click" value="Save" onclick="js_save();">Save</button><br />'.$g_break;
echo '<hr />';
echo '<div id="div_output" name="div_output">';
echo $objhowTo->outputHowTo();
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
from 
	cms.dyn_howto_document D
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
echo '<table border="1">'.$g_break;
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
    echo '<tr>'.$g_break;
    echo '<td>'.$s_howtoName.'</td>'.$g_break;
    echo '<td>'.$s_chapterName.'</td>'.$g_break;
    echo '<td>'.$s_headingName.'</td>'.$g_break;
    echo '<td>'.$s_contentTitle.'</td>'.$g_break;
    echo '<td>'.$i_displayOrderCon.'</td>'.$g_break;
    echo '<td>'.$s_howtoContent.'</td>'.$g_break;
    echo '</tr>'.$g_break;
    //echo '<td>'.$i_chapterID.'</td>'.$g_break;
    //echo '<td>'.$i_displayOrderCha.'</td>'.$g_break;
    //echo '<td>'.$i_headingID.'</td>'.$g_break;
    //echo '<td>'.$i_displayOrderHed.'</td>'.$g_break;
    //echo '<td>'.$i_contentID.'</td>'.$g_break;
}
echo '</table>'.$g_break;
*/
echo '</div>';
echo '</body>'.$g_break; 
echo '</html>'.$g_break;
?>