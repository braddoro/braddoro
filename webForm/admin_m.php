<?php
	class c_model {
		private $server		= "65.175.107.2:3306";
		private $username	= "webapp";
		private $password	= "alvahugh";
		private $dbname		= "braddoro";
		//private $s_errLog	= basename(__FILE__)."_log.txt";
		//private function dieEasy() {
		//	$last_error = error_get_last();
		//	if($last_error['type'] === E_ERROR || $last_error['type'] === E_USER_ERROR) {
		//		$this->write_file($this->s_errLog,"Error: ".$last_error['message']);
		//   }
		//}
		//
		//private function write_file($s_fileName,$s_text) {
		//	$fp=fopen($s_fileName,"a");
		//	$output = date('Y-m-d H:i:s')." | ".$s_text."\r\n";
		//	fputs($fp,$output);
		//	fclose($fp);
		//}

		public function genData($s_sql) {
			$sqlconnect=mysql_connect($this->server, $this->username, $this->password);
			$sqldb=mysql_select_db($this->dbname,$sqlconnect);
			$q_result = mysql_query($s_sql);
			//if (!$q_result) {
			//	$s_string = "Error: ".mysql_error()." | SQL String: ".$s_sql;
			//	$this->write_file($this->s_errLog,$s_string);
			//	$q_result = "";
			//	exit();
			//}
			return $q_result;
		}
	
	}
?>
