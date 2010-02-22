<?php
	$s_editIcon = "Button-Pause-16x16.png";
	$g_break = "\n";
		
	class c_view {
		function input($q_getData) {
			$s_html = "";
		    $i_itemID	= 0;
		    $i_orderID	= 0;
		    $s_itemName	= ""; 
		    $i_amount	= 0;
		    $i_itemStatusID	= 1;
			while ($rowData = mysql_fetch_row($q_getData)) {
			    $i_itemID	= $rowData[0];
			    $i_orderID	= $rowData[1];
			    $s_itemName	= $rowData[2]; 
			    $i_amount	= $rowData[3];
			    $i_itemStatusID	= $rowData[4];
			}
			$s_html .= '<table border="0" style="border-collapse:collapse;padding:5px;">'.$g_break;
			$s_html .= '<tr>'.$g_break;
			$s_html .= '<td class="accentrow">Add Item</td>'.$g_break;
			$s_html .= '<td class="body" style="width:75px;">&nbsp;</td>'.$g_break;
			$s_html .= '</tr>'.$g_break;
			$s_html .= $this->row_input_text($s_fieldName="input_itemName",$i_fieldSize=30,$s_data=trim($s_itemName),$left_class="odd",$right_class="even",$s_fieldString="Item Name").$g_break;
			$s_html .= $this->row_input_text($s_fieldName="input_amount",$i_fieldSize=10,$s_data=$i_amount,$left_class="odd",$right_class="even",$s_fieldString="Units").$g_break;
			$s_sel = "select statusID, status from braddoro.cfg_eve_mining_order_status where active = 1 order by status";
			$s_html .= $this->row_input_select($s_fieldName="input_itemStatusID",$s_sel,$i_itemStatusID,$left_class="odd",$right_class="even",$s_fieldString="Status").$g_break;
			if ($i_itemID > 0) {$s_text = "Save";}else{$s_text = "Add";}		
			$s_html .= '<tr>'.$g_break;
			$s_html .= '<td class="odd">&nbsp;</td>'.$g_break;
			$s_js = "js_ajax('saveItem',$i_itemID,$i_orderID,'div_output');js_ajax('editItem',0,$i_orderID,'div_input');";
			$s_html .= '<td class="even"><input type="button" id="go" name="go" value="'.$s_text.'" onclick="'.$s_js.'"></td>'.$g_break;
			$s_html .= '</tr>'.$g_break;
			$s_html .= '</table>'.$g_break;

			return $s_html;
		}	
		
		function output($q_getData) {
			$s_html = "";
			if (mysql_num_rows($q_getData) > 0) { 
				$s_html = '<table border="0" style="border-collapse:collapse;" cellpadding="5">'.$g_break;
				$s_html .= '<tr class="accentrow">'.$g_break;
				$s_html .= '<td>&nbsp;</td>'.$g_break;
			    $s_html .= '<td>Item Name</td>'.$g_break;
			    $s_html .= '<td align="right">Amount</td>'.$g_break;
			    $s_html .= '<td>Ice Units</td>'.$g_break;
			    $s_html .= '<td>Status</td>'.$g_break;
			    $s_html .= '</tr>'.$g_break;

			    $i_row = 1;
				while ($rowData = mysql_fetch_row($q_getData)) {
				    $i_itemID	= $rowData[0];
				    $i_orderID	= $rowData[1];
				    $s_itemName	= $rowData[2]; 
				    $i_amount	= $rowData[3];
				    $s_status	= $rowData[4];
					if ($i_row % 2) {$s_class="odd";}else{$s_class="even";}	
				    $s_html .= '<tr class="'.$s_class.'">'.$g_break;
				    $s_js = "js_ajax('editItem',$i_itemID,$i_orderID,'div_input');";
					$s_html .= '<td><img src="Button-Pause-16x16.png" border="0" height="12" width="12" title="Edit" onclick="'.$s_js.'"></td>'.$g_break;
				    $s_html .= '<td>'.$s_itemName.'</td>'.$g_break;
				    $s_html .= '<td align="right">'.number_format($i_amount).'</td>'.$g_break;
				    $i_ice = 0;
				    $s_type = "";
				    switch  ($s_itemName) {
					case "Nitrogen Isotopes":
						$i_ice = $i_amount/300;
						$s_type = "White Glaze";
						break;
					case "Helium Isotopes":
						$i_ice = $i_amount/300;
						$s_type = "Clear Icicle";
						break;
					case "Oxygen Isotopes":
						$i_ice = $i_amount/300;
						$s_type = "Blue Ice";
						break;
					case "Hydrogen Isotopes":
						$i_ice = $i_amount/300;
						$s_type = "Glacial Mass";
						break;
					case "Heavy Water":
						$i_ice = $i_amount/1000;
						$s_type = "Glare Crust";
						break;
					case "Liquid Ozone":
						$i_ice = $i_amount/1000;
						$s_type = "Dark Glitter";
						break;
					case "Strontium Clathrates":
						$i_ice = $i_amount/50;
						$s_type = "Dark Glitter";
						break;
					default:
						$i_ice = $i_amount;
				    }
				    $s_html .= '<td align="left">'.$s_type." ".number_format($i_ice).'</td>'.$g_break;
				    $s_html .= '<td>'.$s_status.'</td>'.$g_break;
				    $s_html .= '</tr>'.$g_break;
				    $i_row++;
				}
				$s_html .= '</table>'.$g_break;
			}
			return $s_html;
		}
	
	protected function row_input_text($s_fieldName="",$i_fieldSize=0,$s_data="",$left_class="",$right_class="",$s_fieldString="",$use_input=1,$use_hidden=0,$value_only=0) {
		$s_string = '<tr>';
		$s_string .= '<td class="'.$left_class.'">'.$s_fieldString.'</td>';
		$s_string .= '<td class="'.$right_class.'">';
		if ($use_input == 1) {
			$s_string .= '<input type="text" name="'.$s_fieldName.'" id="'.$s_fieldName.'" size="'.$i_fieldSize.'" value="'.$s_data.'" class="fields">';
		}
		if ($use_hidden == 1) {
			$s_string .= '<input type="hidden" name="'.$s_fieldName.'" id="'.$s_fieldName.'" value="'.$s_data.'">';
		}
		if ($value_only == 1) {
			$s_string .= $s_data;
		}
		$s_string .= '</td>';
		$s_string .= '</tr>';
		
		return $s_string;
	}
	
	protected function row_input_memo($s_fieldName="",$i_rows=0,$i_cols=0,$s_data="",$left_class="",$right_class="",$s_fieldString="",$use_input=1,$use_hidden=0,$value_only=0) {
		$s_string = '<tr>';
		$s_string .= '<td class="'.$left_class.'">'.$s_fieldString.'</td>';
		$s_string .= '<td class="'.$right_class.'">';
		if ($use_input == 1) {
			$s_string .= '<textarea id="'.$s_fieldName.'" name="'.$s_fieldName.'" rows="'.$i_rows.'" cols="'.$i_cols.'" class="fields">'.$s_data.'</textarea>';
		}
		if ($use_hidden == 1) {
			$s_string .= '<input type="hidden" name="'.$s_fieldName.'" id="'.$s_fieldName.'" value="'.$s_data.'">';
		}
		if ($value_only == 1) {
			$s_string .= $s_data;
		}
		$s_string .= '</td>';
		$s_string .= '</tr>';
		
		return $s_string;
	}
	
	protected function row_input_select($s_fieldName,$s_sql,$i_selected,$left_class="",$right_class="",$s_fieldString="") {
		$s_string = '<tr>';
		$s_string .= '<td class="'.$left_class.'">'.$s_fieldString.'</td>';
		$s_string .= '<td class="'.$right_class.'">';
		$q_select = mysql_query($s_sql);
		if (!$q_select) {die_well(__LINE__,mysql_error());}
		$s_string .= '<select id="'.$s_fieldName.'" name="'.$s_fieldName.'" class="fields">';
		//$s_string .= '<option value="0"></option>';
		while ($rowSelect = mysql_fetch_row($q_select)) {
			if ($rowSelect[0] == $i_selected) {
				$s_selected = " SELECTED";
			}else{
				$s_selected = "";
			}
			$s_string .= '<option value="'.$rowSelect[0].'"'.$s_selected.'>'.$rowSelect[1].'</option>';
		}
	    $s_string .= "</select>";
		$s_string .= '</td>';
		$s_string .= '</tr>';
		
		return $s_string;
		}

		function editNote($q_getData) {
			$s_html = "";
		    $noteID		= 1;
		    $orderID	= 0;
		    $noteBy		= ""; 
		    //$noteDate	= date("m/d/Y",time());
		    $noteDate	= time();
		    $note		= "";
			while ($rowData = mysql_fetch_row($q_getData)) {
			    $noteID		= intval($rowData[0]);
			    $orderID	= intval($rowData[1]);
			    $noteBy		= $rowData[2]; 
			    $noteDate	= $rowData[3];
			    $note		= $rowData[4];
			}
			$s_html .= '<table border="0" style="border-collapse:collapse;padding:5px;">'.$g_break;
			$s_html .= '<tr>'.$g_break;
			$s_html .= '<td class="accentrow">Add Note</td>'.$g_break;
			$s_html .= '<td class="body" style="width:75px;">&nbsp;</td>'.$g_break;
			$s_html .= '</tr>'.$g_break;
			$s_html .= $this->row_input_text($s_fieldName="input_noteBy",$i_fieldSize=20,$s_data=trim($noteBy),$left_class="odd",$right_class="even",$s_fieldString="Note By").$g_break;
			
			$s_html .= '<tr>'.$g_break;
			$s_html .= '<td class="odd">Note</td>'.$g_break;
			$s_html .= '<td class="even"><textarea id="input_note" name="input_note" rows="5" cols="60" class="fields">'.$note.'</textarea></td>'.$g_break;
			$s_html .= '</tr>'.$g_break;
			
			if ($noteID > 0) {$s_text = "Save";}else{$s_text = "Add";}		
			$s_html .= '<tr>'.$g_break;
			$s_html .= '<td class="odd">&nbsp;</td>'.$g_break;
			$s_js = "js_ajax('saveNote',$noteID,$orderID,'div_outputNote');js_ajax('editNote',0,$orderID,'div_inputNote');";
			$s_html .= '<td class="even"><input type="button" id="go" name="go" value="'.$s_text.'" onclick="'.$s_js.'"></td>'.$g_break;
			$s_html .= '</tr>'.$g_break;
			$s_html .= '</table>'.$g_break;

			return $s_html;
		}
			
		function showNote($q_getData, $s_sql="") {
			$s_html = '<table border="0" style="border-collapse:collapse;padding:15px;" width="600px">'.$g_break;
			$i_row = 0;
		    $noteID		= 0;
		    $orderID	= 0;
		    $noteBy		= ""; 
		    $noteDate	= time();
		    $note		= "";
			while ($rowData = mysql_fetch_row($q_getData)) {
			    $noteID		= intval($rowData[0]);
			    $orderID	= intval($rowData[1]);
			    $noteBy		= $rowData[2]; 
			    $noteDate	= $rowData[3];
			    $note		= $rowData[4];
				if ($i_row % 2) {$s_class="odd";}else{$s_class="even";}
				$s_html .= '<tr class="'.$s_class.'">'.$g_break;
				$s_html .= '<td><strong>Posted:</strong> '.date("m/d/Y",strtotime($noteDate)).' <strong>at</strong> '.date("h:i a",strtotime($noteDate)).'</td>'.$g_break;
				$s_html .= '<td><strong>By:</strong> '.$noteBy.'</td>'.$g_break;
				$s_html .= '</tr>'.$g_break;
				$s_html .= '<tr class="'.$s_class.'">'.$g_break;
				$s_html .= '<td colspan="2" style="border-bottom: 1px solid black">'.str_replace('\n','<br />',$note).'</td>'.$g_break;
				$s_html .= '</tr>'.$g_break;
				$i_row++;
			}
			$s_html .= '</table>'.$g_break;
			$s_html .= $s_sql;

			return $s_html;
		}	
		
	}
?>