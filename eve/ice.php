<?php
$i_iceOperationID=0;
if (isset($_REQUEST["iceOperationID"])) {
	$i_iceOperationID = intval($_REQUEST["iceOperationID"]);
} else {
	if (isset($_POST["iceOperationID"])) {
		$i_iceOperationID = intval($_POST["iceOperationID"]);
	}
}
$s_task="";
if (isset($_REQUEST["task"])) {
	$s_task = $_REQUEST["task"];
} else {
	if (isset($_POST["task"])) {
		$s_task = $_POST["task"];
	}
}

if ($i_iceOperationID <> 0) {
	if ($s_task == "edit") {
		$sql = "update dyn_eve_operation_ice
				set
				  pilot = '".$_POST['pilot']."',
				  iceTime = ".($_POST['iceTime']).",
				  startTime = '".$_POST['startTime']."',
				  endTime = '".$_POST['endTime']."',
				  turrets = ".intval($_POST['turrets']).",
				  turretYield = ".intval($_POST['turretYield']).",
				  split = ".intval($_POST['split'])."
				where
				  iceOperationID = ".intval($i_iceOperationID).";";
		$link = mysql_connect($server='65.175.107.2:3306',$username='webapp',$password='alvahugh');
		if (!$link) {
		    die('Error: '.mysql_error());
		    exit;
		}
		mysql_select_db("braddoro");
		$q_data = mysql_query($sql);
		if (!$q_data) {
		    die('Error: '.mysql_error());
		    exit;
		}
	}
	if ($s_task == "add") {
		$sql = "insert into dyn_eve_operation_ice (operationID, pilot, iceTime, startTime, endTime, turrets, turretYield, split)
				values(1,'".$_POST['pilot']."',".($_POST['iceTime']).",'".$_POST['startTime']."','".$_POST['endTime']."',".intval($_POST['turrets']).",".intval($_POST['turretYield']).",".intval($_POST['split']).")";
		$link = mysql_connect($server='65.175.107.2:3306',$username='webapp',$password='alvahugh');
		if (!$link) {
		    die('Error: '.mysql_error());
		    exit;
		}
		mysql_select_db("braddoro");
		$q_data = mysql_query($sql);
		if (!$q_data) {
		    die('Error: '.mysql_error());
		    exit;
		}
	}
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<title>PHP Test</title>
		<style media="screen" type="text/css">
			.body {font-family:sans-serif;}
			.phead {border:1px solid black;padding:2px;background-color:#7994B7;color:white;font-family:Arial sans-serif;font-size:1em;font-weight:bold;}
			.pbody {border-left:1px solid black;border-right:1px solid black;border-bottom:1px solid black;padding:2px;background-color:#DDDDDD;font-family:Arial sans-serif;font-size:1em;}
		</style>
	</head>
	<body class="body">
		<?php
			$sql = "select 
				iceOperationID, 
				pilot, startTime, endTime, icetime,
				turrets,
				turretYield,
				(60*60)/iceTime AS 'cyclesPerHour',
				turrets*turretYield AS 'yieldPerCycle', 
				(60*60)/iceTime*(turrets*turretYield) AS 'icePerHour', 
				(60*60)/iceTime*(turrets*turretYield)/60 AS 'icePerminute',
				timestampdiff(minute, startTime, endTime) AS 'minutesMined',
				floor((60*60)/iceTime*(turrets*turretYield)/60*timestampdiff(minute, startTime, endTime)) AS 'iceProduction'
				from dyn_eve_operation_ice
				where split = 1
				and operationID = 1
				order by pilot, startTime";
			$link = mysql_connect($server='65.175.107.2:3306',$username='webapp',$password='alvahugh');
			if (!$link) {
			    die('Error: '.mysql_error());
			    exit;
			}
			mysql_select_db("braddoro");
			$q_data = mysql_query($sql);
			if (!$q_data) {
			    die('Error: '.mysql_error());
			    exit;
			}
			if (mysql_num_rows($q_data) > 0) {
				$i_fields = mysql_num_fields($q_data);
				echo "<table border='1'>";
				echo "<tr>";
				echo "<th></th>";
				for ($i=0; $i < $i_fields; $i++) {
					echo "<th>".mysql_field_name($q_data, $i)."</th>"; 
				}
				echo "</tr>";
				while ($rowData = mysql_fetch_row($q_data)) {
					echo "<tr>";
					echo "<td><a href='ice.php?iceOperationID=".$rowData[0]."'>Edit</a></td>";
					for ($f=0; $f < $i_fields; $f++) {
				    	echo "<td>".$rowData[$f]."</td>";
					}
				    echo "</tr>";
				}
				echo "</table>";
			}
			echo "<a href='ice.php?iceOperationID=0&task=new'>New</a>";			
			if ($i_iceOperationID > 0) {
				$sql2 = "select iceOperationID, pilot, startTime, endTime, iceTime, turrets, turretYield, split from dyn_eve_operation_ice where iceOperationID = $i_iceOperationID";
				$q_edit = mysql_query($sql2);
				if (!$q_edit) {
				    die('Error: '.mysql_error());
				    exit;
				}
				echo "<br/>";
				echo "<form id='myform' name='myform' action='ice.php' method='post'>";
				echo "<input type='hidden' name='task' id='task' value='edit'>";
				echo "<table border='0'>";
				$i_fields = mysql_num_fields($q_edit);
				while ($rowData2 = mysql_fetch_row($q_edit)) {
					for ($f=0; $f < $i_fields; $f++) {
						if ($f > 0) {
						echo "<tr>";
						echo "<th>".mysql_field_name($q_edit, $f)."</th>";
						echo "<td><input type='text' name='".mysql_field_name($q_edit, $f)."' id='".mysql_field_name($q_edit, $f)."' value='".$rowData2[$f]."' size='30'></td>";
				    	echo "</tr>\n";
						}else{
							echo "<input type='hidden' name='".mysql_field_name($q_edit, $f)."' id='".mysql_field_name($q_edit, $f)."' value='".$rowData2[$f]."'>";
						}
					}
				}
				echo "</table>";
				echo "<input type='submit' name='submit' id='submit' value='Go'>";
				echo "</form>";
			}

			if ($s_task == "new") {
				$s_dateTime = date('Y-m-d H:i:00'); 
				echo "<br/>";
				echo "<form id='myform' name='myform' action='ice.php' method='post'>";
				echo "<input type='hidden' name='task' id='task' value='add'>";
				echo "<input type='hidden' name='iceOperationID' id='iceOperationID' value='-1'>";
				echo "<table border='0'>";
				echo "<tr>";
				echo "<th>pilot</th>";
				echo "<td><input type='text' name='pilot' id='pilot' value='' size='30'></td>";
				echo "</tr>\n";

				echo "<tr>";
				echo "<th>startTime</th>";
				echo "<td><input type='text' name='startTime' id='startTime' value='".$s_dateTime."' size='30'></td>";
				echo "</tr>\n";
				
				echo "<tr>";
				echo "<th>endTime</th>";
				echo "<td><input type='text' name='endTime' id='endTime' value='".$s_dateTime."' size='30'></td>";
				echo "</tr>\n";
				
				echo "<tr>";
				echo "<th>iceTime</th>";
				echo "<td><input type='text' name='iceTime' id='iceTime' value='0' size='30'></td>";
				echo "</tr>\n";
				
				echo "<tr>";
				echo "<th>turrets</th>";
				echo "<td><input type='text' name='turrets' id='turrets' value='2' size='30'></td>";
				echo "</tr>\n";
				
				echo "<tr>";
				echo "<th>turretYield</th>";
				echo "<td><input type='text' name='turretYield' id='turretYield' value='2' size='30'></td>";
				echo "</tr>\n";

				echo "<tr>";
				echo "<th>split</th>";
				echo "<td><input type='text' name='split' id='split' value='1' size='30'></td>";
				echo "</tr>\n";
				
				echo "</table>";
				echo "<input type='submit' name='submit' id='submit' value='Go'>";
				echo "</form>";
			}
			
		?>
	</body>
</html>