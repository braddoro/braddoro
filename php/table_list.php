<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>table list</title>
</head>
<body>
<?php
$link = mysql_connect('instance8471.db.xeround.com.:6245', 'webapp', 'alvahugh1');
if (!$link) {
    die('Error: '.mysql_error());
    exit;
}

$db_selected = mysql_select_db('default', $link);
if (!$db_selected) {
    die ('Can\'t use default: ' . mysql_error());
}

/*
// Mf8jU4zp6dd2

$q_data = mysql_query("
INSERT INTO default.db_log (log_time, log_type, log_item, log_detail)
VALUES ('test', 'this is a test', 'this is a test record.');
", $link);
mysql_real_escape_string()

$result = mysql_query("INSERT INTO default.db_attribute (attribute_context, attribute_group, attribute_name, attribute_value) VALUES('USERS', '1', 'USER_NAME', 'Brad');", $link);
if (!$result) {
    die('Error: '.mysql_error());
    exit;
}

$result = mysql_query("UPDATE default.db_attribute
SET
attribute_group = 1,
attribute_value = 'Brad Hughes',
updated_date = now()
WHERE id = 1;", $link);
if (!$result) {
    die('Error: '.mysql_error());
    exit;
}



$result = mysql_query("INSERT INTO default.db_attribute (attribute_context, attribute_id, attribute_name, attribute_value) VALUES('USERS', '1', 'FIRST_NAME', 'Brad');", $link);
if (!$result) {
    die('Error: '.mysql_error());
    exit;
}

$result = mysql_query("
UPDATE default.db_attribute SET
attribute_value = 'braddoro',
updated_date = now()
WHERE attribute_id = 1
and attribute_name = 'USER_NAME'
;", $link);
if (!$result) {
    die('Error: '.mysql_error());
    exit;
}

$result = mysql_query("INSERT INTO default.db_attribute (attribute_context, attribute_id, attribute_name, attribute_value) VALUES('USERS', '1', 'LAST_NAME', 'Hughes');", $link);
if (!$result) {
    die('Error: '.mysql_error());
    exit;
}

$result = mysql_query("UPDATE default.db_attribute SET attribute_context = 'USER_DATA';", $link);
if (!$result) {
    die('Error: '.mysql_error());
    exit;
}

*/

$result = mysql_query("select * from default.db_attribute order by id desc", $link);
if (!$result) {
    die('Error: '.mysql_error());
    exit;
}

$i_fields = mysql_num_fields($result);
echo "<table border='1'>";
echo "<tr>";
for ($i=0; $i < $i_fields; $i++) {
  echo "<th>".mysql_field_name($result, $i)."</th>"; 
}

echo "</tr>";
while ($rowData = mysql_fetch_row($result)) {
  echo "<tr>";
  for ($f=0; $f < $i_fields; $f++) {
  echo "<td>".$rowData[$f]."</td>";
  }
  echo "</tr>";
}
echo "</table>";

echo "</br>";

$result = mysql_query("select * from db_log order by log_time desc", $link);
if (!$result) {
    die('Error: '.mysql_error());
    exit;
}

$i_fields = mysql_num_fields($result);
echo "<table border='1'>";
echo "<tr>";
for ($i=0; $i < $i_fields; $i++) {
  echo "<th>".mysql_field_name($result, $i)."</th>"; 
}

echo "</tr>";
while ($rowData = mysql_fetch_row($result)) {
  echo "<tr>";
  for ($f=0; $f < $i_fields; $f++) {
  echo "<td>".$rowData[$f]."</td>";
  }
  echo "</tr>";
}
echo "</table>";

mysql_free_result($result);
mysql_close($link);
?>
</body>
</html>

Mf8jU4zp6dd2