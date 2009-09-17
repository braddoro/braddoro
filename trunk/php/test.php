<?php
$i_userID=0;
if (isset($_REQUEST["userID"])) {
	$i_userID = intval($_REQUEST["userID"]);
} else {
	if (isset($_POST["userID"])) {
		$i_userID = intval($_POST["userID"]);
	}
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<title>PHP Test</title>
		<?php include("test_lib_c.php"); ?>
	</head>
	<body>
		<?php
		echo "<form id='myform' name='myform' action='test.php' method='post'>";		
		$objDropdown = new dropdown("braddoro");
		echo $objDropdown->dataDropdown($name="userID",$id="userID",$currentValue=$i_userID,$sql="select userID, userName from dyn_users where active = 'Y' order by userName");
		echo "<input type='submit' name='submit' id='submit' value='Go'>";
		echo "</form>";

			$link = mysql_connect($server='65.175.107.2:3306',$username='webapp',$password='alvahugh');
			if (!$link) {
			    die('Error: '.mysql_error());
			    exit;
			}
			mysql_select_db("braddoro");
			$q_data = mysql_query("select * from dyn_posts where userID = ".$i_userID." order by addedDate desc");
			if (!$q_data) {
			    die('Error: '.mysql_error());
			    exit;
			}
			$i_fields = mysql_num_fields($q_data);
			echo "<table border='1'>";
			echo "<tr>";
			for ($i=0; $i < $i_fields; $i++) {
				// " - ".mysql_field_type($q_data, $i)." - ".mysql_field_len($q_data, $i).
				echo "<th>".mysql_field_name($q_data, $i)."</th>"; 
			}
			echo "</tr>";
			while ($rowData = mysql_fetch_row($q_data)) {
				echo "<tr>";
				for ($f=0; $f < $i_fields; $f++) {
			    	echo "<td>".$rowData[$f]."</td>";
				}
			    echo "</tr>";
			}
			echo "</table>";
		?>
	</body>
</html>