<?php
include "_functions.php";
header("Cache: private");
$s_filename = basename(__FILE__);
$s_pageName = "My Goal";
//&mdash; 
$s_server = "65.175.107.2:3306";
$s_userName = "webapp";
$s_password = "alvahugh";
$s_db = "braddoro";
$i_g = set_var('g',0);
$i_a = set_var('a',0);
$i_pct = $i_a/$i_g; 
$i_baseHeight = 200;
$i_redHeight = $i_baseHeight*$i_pct;
$i_greenHeight = $i_baseHeight-$i_redHeight;
$s_t = set_var('t','My Goal');
/*
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
*/
echo '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'.$g_break; 
echo '<html xmlns="http://www.w3.org/1999/xhtml">'.$g_break;
echo '<head>'.$g_break;
echo '<meta name="generator" content="'.$s_pageName.'" />'.$g_break;
echo '<meta name="keywords" content="Sun Tzu,The Art of War" />'.$g_break; 
echo '<meta name="description" content="Sun Tzu Database" />'.$g_break;
echo '<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1" />'.$g_break;
//echo '<meta http-equiv="refresh" content="30;url='.$s_filename.'">';
echo '<title>'.$s_pageName.'</title>'.$g_break; 
echo '<link rel="stylesheet" href="eve2.css">'.$g_break;
echo '</head>'.$g_break; 
echo '<body class="body">'.$g_break;
//echo '<img src="65px-Zhongwen.svg.png" border="0">';
echo '<span class="title">'.$s_t.'</span>&nbsp;'.$g_break;
//echo '<a href="'.$s_filename.'?goal='.$i_g.'&amt='.$i_a.'"><img src="Button-Refresh-16x16.png" border="0" height="'.$i_iconSize.'" width="'.$i_iconSize.'" title="refresh"></a>';
echo '<span id="swirly" style="display">&nbsp;<img src="../../images/new-spinner.gif" border="0" height="12" width="12" title="loading..."></span>'.$g_break;
echo '<br /><br />'.$g_break;
echo '<div align="center">';
	echo number_format($i_g);
	echo '<div style="background-color: green;width:50px;height: '.$i_greenHeight.'px;" title="'.number_format($i_g-$i_a,0).' remaining">';
	if ($i_pct < .9) {
		echo number_format($i_g-$i_a,0);
	}
	echo '</div>'; 
	echo '<div style="background-color: red;width:50px;height: '.$i_redHeight.'px;vertical-align:middle;" title="'.number_format($i_pct*100).'%">';
	if ($i_pct > .1) {
		echo number_format($i_pct*100).'%';
	}
	echo '</div>';
	echo number_format($i_a).'<br />'.$g_break;
echo '</div>';
echo '<script language="javascript">';
echo 'document.getElementById("swirly").style.display = "none";';
echo '</script>'.$g_break;
echo '</body>'.$g_break; 
echo '</html>'.$g_break;
?>