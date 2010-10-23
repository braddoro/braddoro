<?php
function die_well($error="")
	{
	echo $line.": ".$error;
	exit;
	}
header("Cache: private");
setlocale(LC_MONETARY, 'en_US');
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
select distinct
	P.postID,
	T.topicID,
	T.topic,
	T.description,
	P.userID, 
	U.siteName,
	P.title, 
	P.post, 
	P.addedDate,
	count(R.postID) as 'replies'
from braddoro.dyn_posts P
inner join braddoro.dyn_users U
	on P.userID = U.userID 
inner join braddoro.cfg_topics T
	on P.topicID = T.topicID
left join braddoro.dyn_replies R
	on P.postID = R.postID
where 
	P.active = 'Y'
group by
	P.postID,
	T.topicID,
	T.topic,
	T.description,
	P.userID, 
	U.siteName,
	P.title, 
	P.post, 
	P.addedDate		
order by 
	P.addedDate desc
limit 20;";	
$q_data = mysql_query($s_sql);
if (!$q_data) {die_well(mysql_error());}
$i_rows = 0;
$s_html = "<table style='border-collapse:collapse;'>\n";
while ($Row = mysql_fetch_row($q_data))
	{
	$postID		= $Row[0];
	$topicID	= $Row[1];
	$topic		= $Row[2];
	$description= $Row[3];
	$userID		= $Row[4]; 
	$siteName	= $Row[5];
	$title		= $Row[6]; 
	$post		= $Row[7]; 
	$addedDate	= $Row[8];
	
	$s_html .= "<tr class='accentrow' id='row_$i_rows'>\n";
	$s_html .= "<td><strong>$title : $topic</strong></td>\n";
	$s_html .= "<td align='right'><strong>$siteName $addedDate</strong></td>\n";
	$s_html .= "</tr>\n";
	$s_html .= "<tr>\n";
	$s_html .= "<td colspan='2'>$post</td>\n";
	$s_html .= "</tr>\n";
	$s_html .= "<tr>\n";
	$s_html .= "<td><br/></td>\n";
	$s_html .= "</tr>\n";
	$i_rows++;
	}
$s_html .= "</table>\n";
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="generator" content="Braddoro for Mobile" />
<title>Braddoro</title>
<style type="text/css">
.body {background-color: #F1EFDE;font-family: sans-serif;font-size: .8em}
.cell {text-align: right;}
.odd {padding: 2px;background-color: #99A68C;}
.even {padding: 2px;background-color: #8A8A6A;}
.accentrow {padding: 2px;background-color: #ACACAC;}
</style>
</head>
<body class="body">
<?php echo $s_html; ?>
</body>
</html>