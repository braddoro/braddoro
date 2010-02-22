<?php 
	include_once "orders_m.php";
	include_once "orders_v.php";
	
	class c_order {
		public function main($i_orderID) {
			$s_main = '<div id="div_input">';
			$s_main .= $this->input(0,$i_orderID);
			$s_main .= '</div>';
			$s_main .= '<br />';
			$s_main .= '<div id="div_output">';
			$s_main .= $this->output($i_orderID);
			$s_main .= '</div>';
			return $s_main;
		}
		
		public function input($i_itemID,$i_orderID) {
			$objThis_m = new c_data();
			$objThis_v = new c_view();
						
			$s_sql = "select itemID, orderID, itemName, amount, itemStatusID from dyn_eve_mining_order_item where itemID = $i_itemID;";
			$q_getData = $objThis_m->getData($s_sql);
			
			$s_input = $objThis_v->input($q_getData);
			
			return $s_input;
		}

		public function output($i_orderID) {
			$objThis_m = new c_data();
			$objThis_v = new c_view();

			$s_sql = "select itemID, orderID, itemName, amount, status from dyn_eve_mining_order_item I left join braddoro.cfg_eve_mining_order_status S on I.itemStatusID = S.statusID where orderID = $i_orderID order by itemName;";
			$q_getData = $objThis_m->getData($s_sql);
			
			$s_output = $objThis_v->output($q_getData);
			
			return $s_output;
		}
		
		public function saveItem($i_itemID, $i_orderID, $s_itemName, $i_amount, $i_itemStatusID){
			$objThis_m = new c_data();
			if ($i_itemID > 0) {
				if ($i_amount == 0) {
					$s_sql = "delete from braddoro.dyn_eve_mining_order_item where itemID = $i_itemID;"; 
					
				} else {
					$s_sql = "update dyn_eve_mining_order_item set itemName = '$s_itemName', amount = $i_amount, itemStatusID = $i_itemStatusID, updatedDate = now() where itemID = $i_itemID;";
				}
			}else{
				$s_sql = "insert into dyn_eve_mining_order_item (orderID, itemName, amount, itemStatusID, addedDate, updatedDate) select $i_orderID, '$s_itemName', $i_amount, $i_itemStatusID, now(), now();";
			}
			$q_data = $objThis_m->getData($s_sql);
			
			return $this->output($i_orderID);
		}	
		
		public function mainNote($i_orderID=0,$i_noteID=0){
			$s_main = '<div id="div_inputNote">';
			$s_main .= $this->editNote($i_noteID);
			$s_main .= '</div>';
			$s_main .= '<br />';
			$s_main .= '<div id="div_outputNote">';
			$s_main .= $this->showNote($i_orderID);
			$s_main .= '</div>';
			return $s_main;		
		}
		
		public function showNote($i_orderID){
			$objThis_m = new c_data();
			$objThis_v = new c_view();
			
			$s_sql = "select noteID, orderID, noteBy, noteDate, note from braddoro.dyn_eve_mining_order_note where orderID = $i_orderID order by noteDate desc"; 
			$q_data = $objThis_m->getData($s_sql);
			return $objThis_v->showNote($q_data);
		}	

		public function editNote($i_noteID){
			$objThis_m = new c_data();
			$objThis_v = new c_view();
			
			$s_sql = "select noteID, orderID, noteBy, noteDate, note from braddoro.dyn_eve_mining_order_note where noteID = $i_noteID"; 
			$q_data = $objThis_m->getData($s_sql);
			return $objThis_v->editNote($q_data);
		}	
	
		public function saveNote($orderID, $noteBy, $note){
			$objThis_m = new c_data();
			$objThis_v = new c_view();
			
			$s_sql = "insert into braddoro.dyn_eve_mining_order_note (orderID, noteBy, note, notedate) select $orderID, '$noteBy', '$note', now();"; 
			$q_data = $objThis_m->getData($s_sql);
			return $this->showNote($orderID,$s_sql);
		}	
		
	}
?>