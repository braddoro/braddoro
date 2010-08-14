<?php 
	include_once "orders_m.php";
	include_once "orders_v.php";
	
	class c_order {
		public function main() {
			$objThis_M = new c_data();
			$q_getData = $objThis_M->output();
			
			$objThis_V = new c_view();
			$s_main = $objThis_V->output($q_getData);
			
			return $s_main;
		}
	}
?>