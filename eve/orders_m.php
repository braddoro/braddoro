<?php
	class c_data {
		function getData($s_sql){
			$s_server = "65.175.107.2:3306";
			$s_userName = "webapp";
			$s_password = "alvahugh";
			$s_db = "braddoro";
			$o_conn = mysql_connect($s_server,$s_userName,$s_password);
			if (!$o_conn) {die_well(mysql_error());}
			$o_sel = mysql_select_db($s_db);
			if (!$o_sel) {die_well(mysql_error());}
			return mysql_query($s_sql);
		}	
	}
?>