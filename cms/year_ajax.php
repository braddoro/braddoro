<?php  
$s_html = "";
$s_task = lib_set_var("task","");
$i_overlayID = intval(lib_set_var("overlayID","0"));
$i_julianDate = intval(lib_set_var("julian","0"));
$s_input = lib_set_var("input","");

$server		= "65.175.107.2:3306";
$username	= "cms_user";
$password	= "alvahugh";
$dbname		= "cms";
$sqlconnect=mysql_connect($server,$username,$password);
$sqldb=mysql_select_db($dbname,$sqlconnect);

switch ($s_task) {

case "save":
	$s_sql = "update cms.dyn_julian_dates set event = '$s_input' where overlayID = $i_overlayID and julianDate = $i_julianDate";
	$s_html = $s_sql;
	mysql_query($s_sql,$sqlconnect);
	$i_result = mysql_affected_rows($sqlconnect);
	if ($i_result == 0) {
		$s_sql = "insert into cms.dyn_julian_dates (overlayID, julianDate, event) select $i_overlayID, $i_julianDate, '$s_input'";
		$s_html .= "\n".$s_sql;
		mysql_query($s_sql,$sqlconnect);
	}
	mysql_close($sqlconnect);
	break;

case "scroll":
	//$s_output = "";
	//$s_date = 	lib_set_var("date","01/01/1900");
	//$s_sql = "select T.due_date, T.name, T.notes, T.task_id, A.first_name, A.last_name, O.org_name, L.street, L.city, L.state, L.zip 
	//from nightly_update.dbo.crm_task_table_copy T
	//left join nightly_update.dbo.crm_accounts_table_copy A on T.assgn_acct_id = A.acct_id
	//left join nightly_update.dbo.crm_org_table_copy O on T.org_id = O.org_id
	//left join nightly_update.dbo.crm_org_addrs_table_copy L on O.org_id = L.org_id
	//where due_date > '$s_date' and due_date < '$s_date 23:59:59' order by T.due_date desc;";	
	//$q_result = mssql_query($s_sql);
	//if (mssql_num_rows($q_result) == 0) {
	//	$s_output = "No Tasks";
	//}
	//while($row = mssql_fetch_array($q_result)) {
	//	$s_output .= "<div>".$row["org_name"]."</div>";
	//	$s_output .= "<div>".$row["due_date"]."</div>";
	//	$s_output .= "<div>".$row["street"]."<br/>".$row["city"]." ".$row["state"]." ".$row["zip"]."</div>";
	//	$s_output .= "<div>".$row["first_name"]." ".$row["last_name"]."</div>";
	//	$s_output .= "<div>".$row["name"]."</div>";
	//	$s_output .= "<div>".$row["notes"]."</div>";
	//	$s_output .= "<hr>";
	//}
	//$s_html = $s_output;
	break;

default:
	$s_html = "$s_task";
	break;

}

function lib_set_var($testName,$s_default) {
	$varName=$s_default;
	
	if (isset($_REQUEST[$testName])) {
		$varName = $_REQUEST[$testName];
	} else { 
		if (isset($_POST[$testName])) {
			$varName = $_POST[$testName];
		}
	}

	return $varName;
}

echo $s_html;
?>
