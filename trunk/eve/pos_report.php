<?php
header("Cache: private");
setlocale(LC_MONETARY, 'en_US');
$s_title = "POS Report";

function lib_error_trap($i_errorNumber, $s_errorString, $s_errorFile, $i_errorLine) {
    switch ($i_errorNumber) {
    case E_USER_ERROR:
        echo "<b>My ERROR</b> [$i_errorNumber] $s_errorString<br />\n";
        echo "  Fatal error on line $i_errorLine in file $s_errorFile";
        echo ", PHP " . PHP_VERSION . " (" . PHP_OS . ")<br />\n";
        echo "Aborting...<br />\n";
        exit(1);
        break;

    case E_USER_WARNING:
        echo "<b>My WARNING</b> [$i_errorNumber] $s_errorString<br />\n";
        break;

    case E_USER_NOTICE:
        echo "<b>My NOTICE</b> [$i_errorNumber] $s_errorString<br />\n";
        break;

    default:
        echo "Unknown error type: [$i_errorNumber] $s_errorString<br />\n";
        break;
    }

    /* Don't execute PHP internal error handler */
    return true;
}


$g_break = chr(10).chr(13);
$s_server = "65.175.107.2:3306";
$s_userName = "webapp";
$s_password = "alvahugh";
$s_db = "braddoro";
$o_conn = mysql_connect($server=$s_server,$username=$s_userName,$password=$s_password);
if (!$o_conn) {die_well(mysql_error());}
$o_sel = mysql_select_db($s_db);
if (!$o_sel) {die_well(mysql_error());}
$s_sql = "
select 
	case alliance 
		when 'None' then 'No Aliance' 
		when '' then 'No Aliance'
		else alliance 
	end as 'alliance', 
	corporation, 
	constellation, 
	system, 
	count(*) as 'total'
from 
	braddoro.dyn_intel_pos_list
where
    corporation <> 'none' 
    and corporation <> 'No Moons'
    and corporation <> ''
group by 
	alliance, 
	corporation, 
	constellation, 
	system 
order by 
	alliance, 
	corporation, 
	constellation, 
	system 
";	
$q_data = mysql_query($s_sql);
if (!$q_data) {die_well(mysql_error());}
echo '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'.$g_break; 
echo '<html xmlns="http://www.w3.org/1999/xhtml">'.$g_break;
echo '<head>'.$g_break;
echo '<meta name="generator" content="Eve market update tool." />'.$g_break; 
echo '<title>'.$s_title.'</title>'.$g_break; 
echo '<style type="text/css">'.$g_break; 
echo '.body {background-color: #F1EFDE;font-family: sans-serif;font-size: .8em}'.$g_break;
echo '.cell {text-align: right;}'.$g_break;
echo '.odd {padding: 2px;background-color: #99A68C;}'.$g_break;
echo '.even {padding: 2px;background-color: #8A8A6A;}'.$g_break;
echo '.accentrow {padding: 2px;background-color: #ACACAC;}'.$g_break;
echo '</style>'.$g_break; 
echo '</head>'.$g_break; 
echo '<body class="body">'.$g_break;
echo '<h3>'.$s_title.'<h3>';
echo '<table border="0" style="border-collapse:collapse;">'.$g_break;
$COLUMN_ALLIANCE		= 0;
$COLUMN_CORPORATION		= 1;
$COLUMN_CONSTELLATION	= 2;
$COLUMN_SYSTEM			= 3;
$COLUMN_TOTAL			= 4;
$s_alliance_hold 		= "";
$s_corporation_hold 	= "";
$i_total_alliance		= 0;
$i_total_corporation	= 0;
$b_write_alliance		= false;
$b_write_corporation	= false;
$i_cols 				= 5;
$i_rows 				= 0;
$s_bg					= ".odd";
while ($rowData = mysql_fetch_row($q_data)) {
	$s_alliance 		= $rowData[$COLUMN_ALLIANCE];
	$s_corporation 		= $rowData[$COLUMN_CORPORATION];
	$s_constellation	= $rowData[$COLUMN_CONSTELLATION];
	$s_system 			= $rowData[$COLUMN_SYSTEM];
	$i_total 			= $rowData[$COLUMN_TOTAL];
	if ($i_rows && $s_corporation_hold != $rowData[$COLUMN_CORPORATION]) {footer_corporation();}
	if ($i_rows && $s_alliance_hold != $rowData[$COLUMN_ALLIANCE]) {footer_alliance();}
	if ($s_alliance_hold != $s_alliance) {header_alliance();}
	if ($s_corporation_hold != $s_corporation) {header_corporation();}
	write_detail();
	$s_alliance_hold = $s_alliance;
	$s_corporation_hold = $s_corporation;
	$i_rows++;
}
footer_corporation();
footer_alliance();
echo '</table>'.$g_break;
echo '</body>'.$g_break; 
echo '</html>'.$g_break;

function die_well($error="") {
	echo $line.": ".$error;
	exit;
}
function header_alliance() {
	global 
		$s_alliance,
		$g_break;
		
	echo '<tr style="background-color: #B3B3B3;">'.$g_break;
	echo '<td>'.$s_alliance.'</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '</tr>'.$g_break;
}
function header_corporation() {
	global 
		$s_corporation,
		$b_write_corporation,
		$g_break;
		
	echo '<tr style="background-color: #ACACAC;">'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>'.$s_corporation.'</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '</tr>'.$g_break;
	$b_write_corporation = true;
}
function header_constellation() {
	global 
		$s_constellation,
		$g_break;

	echo '<tr style="background-color: #ACACAC;">'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>'.$s_constellation.'</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '</tr>'.$g_break;
}
function write_detail() {
	global 
		$i_total_corporation,
		$i_total_alliance,
		$s_constellation,
		$s_system,
		$i_total,
		$g_break,
		$s_bg;

	if ($s_bg == "#8A8A6A") {
		$s_bg = "#99A68C";
	} else {
		$s_bg = "#8A8A6A";
	}
	echo '<tr style="background-color:'.$s_bg.';">'.$g_break;
	echo '<td style="background-color: #ACACAC;">&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>'.$s_constellation.'</td>'.$g_break;
	echo '<td>'.$s_system.'</td>'.$g_break;
	echo '<td>'.$i_total.'</td>'.$g_break;
	echo '</tr>'.$g_break;
	$i_total_alliance = $i_total_alliance + $i_total; 
	$i_total_corporation = $i_total_corporation + $i_total;
}
function footer_corporation() {
	global 
		$s_corporation_hold,
		$i_total_corporation,
		$b_write_corporation,
		$g_break;
		
	echo '<tr style="background-color: #EEEECC;">'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>'.$s_corporation_hold.'</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>'.$i_total_corporation.'</td>'.$g_break;
	echo '</tr>'.$g_break;
	$i_total_corporation = 0;
	$b_write_corporation = false;
	echo '<tr style="background-color: #EEEECC;">'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '</tr>'.$g_break;
}
function footer_alliance() {
	global 
		$s_alliance_hold,
		$i_total_alliance,
		$g_break;
		
	echo '<tr style="background-color: #B3B3B3;">'.$g_break;
	echo '<td>'.$s_alliance_hold.'</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>'.$i_total_alliance.'</td>'.$g_break;
	echo '</tr>'.$g_break;
	$i_total_alliance = 0;
	echo '<tr>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '<td>&nbsp;</td>'.$g_break;
	echo '</tr>'.$g_break;
}
?>