<?php 
	class howTo {
		public function outputHowTo() {
			
			include_once "howto_m.php";
			$objThis_M = new data();
			$q_getData = $objThis_M->outputTable();
			
			include_once "howto_v.php";
			$objThis_V = new view();
			$s_main = $objThis_V->outputHowTo($q_getData);
			
			return $s_main;
		}
	}
?>