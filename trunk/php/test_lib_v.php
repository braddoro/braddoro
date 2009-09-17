<?php
	class display {
		
		function showBox($name,$id,$q_query,$currentValue,$defaultDisplay="Choose an Option",$defaultValue=0) {
		
			$s_output = '<select id="'.$id.'" name="'.$name.'">';
			$s_output .= '<option value="'.$defaultValue.'">'.$defaultDisplay.'</option>';
			while ($rowData = mysql_fetch_row($q_query)) {
				if ($rowData[0] == $currentValue) {
					$selected = " SELECTED";
				} else {
					$selected = "";
				}
   				$s_output .= '<option value="'.$rowData[0].'"'.$selected.'>'.$rowData[1].'</option>';
			}
			$s_output .= '</select>';
						
			return $s_output;
		}	
	
	}
?>