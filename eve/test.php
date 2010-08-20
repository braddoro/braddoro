<?php
$s_filename = basename(__FILE__);
$s_pageName = "test";
$s_server = "65.175.107.2:3306";
$s_userName = "webapp";
$s_password = "alvahugh";
$s_db = "braddoro";
$o_conn = mysql_connect($server=$s_server,$username=$s_userName,$password=$s_password);
if (!$o_conn) {die_well(__LINE__,mysql_error());}
$o_sel = mysql_select_db($s_db);
if (!$o_sel) {die_well(__LINE__,mysql_error());}
$s_sql = 'select ownerID, owner from braddoro.dyn_owners where;';
$q_data = mysql_query($s_sql);
if (!$q_data) {die_well(__LINE__,mysql_error());}
while ($rowData = mysql_fetch_row($q_data)) {
	$i_ownerID = $rowData[0];
	$s_owner = $rowData[1];
}
mysql_free_result($q_data);
$s_html = "Contact eve at braddoro dot com for assistance.";
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<script language="javascript"></script>
<style <style media="all" type="text/css">></style>
</head>
<body>
<?php echo $s_html; ?>
</body>
</html>
