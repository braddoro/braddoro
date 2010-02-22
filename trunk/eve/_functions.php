<?php 
$g_break = chr(10).chr(13);
function SQLSafe($InString) {
	$OutString = str_replace("'", "''",$InString);
	//$OutString = addslashes($InString);
	return $OutString;
}
function die_well($line,$error="",$detail="") {
	echo $line.": ".$error." Detail: ".$detail;
	exit;
}

function set_var($testName,$s_default) {
	$varName=$s_default;
	if (isset($_REQUEST[$testName])) {
		$varName = $_REQUEST[$testName];
	} else {
		if (isset($_POST[$testName])) {
			$varName = $_POST[$testName];
		}
	}
	return $varName;
}

function row_input_text($s_fieldName="",$i_fieldSize=0,$s_data="",$left_class="",$right_class="",$s_fieldString="",$use_input=1,$use_hidden=0,$value_only=0) {
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

function row_input_memo($s_fieldName="",$i_rows=0,$i_cols=0,$s_data="",$left_class="",$right_class="",$s_fieldString="",$use_input=1,$use_hidden=0,$value_only=0) {
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

function row_input_select($s_fieldName,$s_sql,$i_selected,$left_class="",$right_class="",$s_fieldString="") {
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
?>