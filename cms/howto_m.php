<?php
	class data {
	private $server = "65.175.107.2:3306";
	private $userName = "cms_user";
	private $password = "alvahugh";
	private $db = "cms";
		function runSQL($s_sql){
			$o_conn = mysql_connect($this->server,$this->userName,$this->password);
			if (!$o_conn) {die_well(mysql_error());}
			$o_sel = mysql_select_db($this->db);
			if (!$o_sel) {die_well(mysql_error());}
			return mysql_query($s_sql);
		}	
	}
?>