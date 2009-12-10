<?php
	class dropdown {

		function dataDropdown($name,$id,$currentValue,$sql){
			include("test_lib_m.php");
			$objThis_S = new data();
			$q_data = $objThis_S->getData($sql=$sql);

			include("test_lib_v.php");
			$objThis_V = new display();
			$tmpX = $objThis_V->showBox($name=$name,$id=$id,$q_query=$q_data,$currentValue=$currentValue);
			
			return $tmpX;
		}	
		
	}
?>

