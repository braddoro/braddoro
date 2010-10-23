<?php 
	require_once "admin_m.php";
	require_once "admin_v.php";
		
	class c_controller {
		public function genSQL($s_sql) {
			$objThis_m = new c_model();

			$q_data = $objThis_m->genData($s_sql);
			
			return $q_data;
		}
		public function genOutput($s_sql) {
			$objThis_m = new c_model();
			$objThis_v = new c_view();
			$s_return = "";
			
			$q_data = $objThis_m->genData($s_sql);
			$s_return = $objThis_v->genOutput($q_data);
			
			return $s_return;
		}
		public function shipInput() {
			$objThis_m = new c_model();
			$objThis_v = new c_view();
			
			$s_return = $objThis_v->shipInput();
			
			return $s_return;
		}
		public function itemInput() {
			$objThis_m = new c_model();
			$objThis_v = new c_view();
			
			$s_group = "select G.groupID, G.groupName from braddoro.invgroups G where G.published = 1 order by G.groupName;";
			$q_group = $objThis_m->genData($s_group);
		
			return $objThis_v->itemInput($q_group);
		}

		public function blueprintOutput($s_sql) {
			$objThis_m = new c_model();
			$objThis_v = new c_view();
			$s_return = "";
			
			$q_data = $objThis_m->genData($s_sql);
			$s_return = $objThis_v->blueprintOutput($q_data);
			
			return $s_return;
		}
		public function blueprintInput($blueprintID=0) {
			$objThis_m = new c_model();
			$objThis_v = new c_view();
			
			$s_location = "select distinct location from braddoro.dyn_blueprints where location > '' order by location;";
			$q_location = $objThis_m->genData($s_location);
			$s_owner = "select ownerID, owner from braddoro.dyn_blueprint_owners where active = 1 order by owner;";
			$q_owner = $objThis_m->genData($s_owner);
			$s_sql = "select blueprintID, eveID, mat_lev, prod_lev, blueprintName, bpc, runs, copies, ownerID, location from braddoro.dyn_blueprints where blueprintID = $blueprintID;";
			$q_data = $objThis_m->genData($s_sql);
			
			$s_return = $objThis_v->blueprintInput($q_data,$q_owner,$q_location);
			
			return $s_return;
		}
	}
?>
