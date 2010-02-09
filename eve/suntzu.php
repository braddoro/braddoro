<?php
include "_functions.php";
header("Cache: private");
$s_filename = basename(__FILE__);
$s_pageName = "Sun Tzu &mdash; The Art of War";
$s_server = "65.175.107.2:3306";
$s_userName = "webapp";
$s_password = "alvahugh";
$s_db = "braddoro";
$i_chapterID = set_var('chapterID',0);
$i_paragraphID = set_var('paragraphID',0);
$o_conn = mysql_connect($server=$s_server,$username=$s_userName,$password=$s_password);
if (!$o_conn) {die_well(__LINE__,mysql_error());}
$o_sel = mysql_select_db($s_db);
if (!$o_sel) {die_well(__LINE__,mysql_error());}
if ($i_chapterID == 0 && $i_paragraphID == 0) {
	$s_sql = 'select chapterID, paragraphID, chapterName, paragraph from braddoro.suntzu order by RAND() limit 1;';
} else {
	$s_sql = 'select chapterID, paragraphID, chapterName, paragraph from braddoro.suntzu where chapterID = '.$i_chapterID.' and paragraphID = '.$i_paragraphID.' limit 1;';
}
$q_data = mysql_query($s_sql);
if (!$q_data) {die_well(__LINE__,mysql_error());}
while ($rowData = mysql_fetch_row($q_data)) {
	$i_chapterID = $rowData[0];
	$i_paragraphID = $rowData[1];
	$s_chapter = $rowData[2];
	$s_paragraph = $rowData[3];
}
mysql_free_result($q_data);
switch ($i_chapterID) 
{
case 1: 
	$i_max = 26;
	break;
case 2:
	$i_max = 20;
	break;
case 3:
	$i_max = 18;
	break;
case 4:
	$i_max = 20;
	break;
case 5:
	$i_max = 23;
	break;
case 6:
	$i_max = 24;
	break;
case 7:
	$i_max = 37;
	break;
case 8:
	$i_max = 14;
	break;
case 9:
	$i_max = 45;
	break;
case 10:
	$i_max = 31;
	break;
case 11:
	$i_max = 68;
	break;
case 12:
	$i_max = 22;
	break;
case 13:
	$i_max = 27;
	break;
default:
	$i_max = 0;
}
$i_less = $i_paragraphID;
$i_more = $i_paragraphID;
$i_less--;
$i_more++;
echo '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'.$g_break; 
echo '<html xmlns="http://www.w3.org/1999/xhtml">'.$g_break;
echo '<head>'.$g_break;
echo '<meta name="generator" content="'.$s_pageName.'" />'.$g_break;
echo '<meta name="keywords" content="Sun Tzu,The Art of War" />'.$g_break; 
echo '<meta name="description" content="Sun Tzu Database" />'.$g_break;
echo '<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1" />'.$g_break;
echo '<meta http-equiv="refresh" content="30;url='.$s_filename.'">';
echo '<title>'.$s_pageName.'</title>'.$g_break; 
echo '<link rel="stylesheet" href="eve2.css">'.$g_break;
echo '</head>'.$g_break; 
echo '<body class="body">'.$g_break;
echo '<img src="65px-Zhongwen.svg.png" border="0">';
echo '<span class="title">'.$s_pageName.'</span>&nbsp;'.$g_break;
echo '<a href="'.$s_filename.'?paragraphID=0&chapterID=0"><img src="Button-Refresh-16x16.png" border="0" height="'.$i_iconSize.'" width="'.$i_iconSize.'" title="refresh"></a>';
echo '<span id="swirly" style="display">&nbsp;<img src="../../images/new-spinner.gif" border="0" height="12" width="12" title="loading..."></span>'.$g_break;
echo '<br /><br />'.$g_break;
echo '<strong>'.$s_chapter.'</strong><br /><br />';
echo '<strong>'.$i_chapterID.'.'.$i_paragraphID.'</strong>&nbsp;'.$s_paragraph.'<br /><br />';
echo '<div align="center">';
if ($i_less > 0) {
	echo '<a href="'.$s_filename.'?chapterID='.$i_chapterID.'&paragraphID='.$i_less.'" title="Previous Paragraph">';
	echo '<img src="../../images/Button-Previous-16x16.png" border="0" height="'.$i_iconSize.'" width="'.$i_iconSize.'" title="previous" align="bottom"></a>&nbsp;'.$g_break;
}
echo '<strong>';
for ($i_chapt = 1; $i_chapt <= 13; $i_chapt++) {
	echo '<a href="'.$s_filename.'?chapterID='.$i_chapt.'&paragraphID=1" title="Jump to Chapter '.$i_chapt.'">'.$i_chapt.'</a>'.$g_break;
}
echo '</strong>&nbsp;';
if ($i_more < ($i_max+1)) {
	echo '<a href="'.$s_filename.'?chapterID='.$i_chapterID.'&paragraphID='.$i_more.'" title="Next Paragraph">';
	echo '<img src="../../images/Button-Next-16x16.png" border="0" height="'.$i_iconSize.'" width="'.$i_iconSize.'" title="next" align="bottom"></a>'.$g_break;
}
echo '</div>';
echo '<script language="javascript">';
echo 'document.getElementById("swirly").style.display = "none";';
echo '</script>'.$g_break;
echo '</body>'.$g_break; 
echo '</html>'.$g_break;
?>