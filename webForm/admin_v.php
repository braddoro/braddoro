<?php
class c_view {

	function blueprintInput($q_getData,$q_owner,$q_location) {
		$blueprintID   = 0;
		$eveID         = 0;
		$mat_lev       = 0;
		$prod_lev      = 0;
		$blueprintName = "";
		$bpc           = 0;
		$runs          = 0;
		$copies        = 0;
		$ownerID       = 2; 
		while($row = mysql_fetch_array($q_getData)) {
			$blueprintID   = $row["blueprintID"];
			$eveID         = $row["eveID"];
			$mat_lev       = $row["mat_lev"];
			$prod_lev      = $row["prod_lev"];
			$blueprintName = $row["blueprintName"];
			$bpc           = $row["bpc"];
			$runs          = $row["runs"];
			$copies        = $row["copies"];
			$ownerID       = $row["ownerID"];
			$location       = $row["location"];
		}
		mysql_free_result($q_getData);
		
		$s_owner = "<select id='ownerID' name='ownerID'>";
		$s_owner .= "<option value='0'></option>";
		$s_owner2 = "<select id='search_ownerID' name='search_ownerID'>";
		$s_owner2 .= "<option value='0'></option>";
		while($row = mysql_fetch_array($q_owner)) {
			if ($row["ownerID"] == $ownerID) {
				$s_select = " SELECTED";
			}else{
				$s_select = "";
			}
			$s_owner .= "<option value='".$row["ownerID"]."'$s_select>".$row["owner"]."</option>";
			$s_owner2 .= "<option value='".$row["ownerID"]."'>".$row["owner"]."</option>";
		}
		$s_owner .= "</select>";
		$s_owner2 .= "</select>";
		mysql_free_result($q_owner);
		
		$s_bpc = "<select id='bpc' name='bpc'>";
		if ($bpc == 0) {$s_sel = " SELECTED";} else {$s_sel = "";}
		$s_bpc .= "<option value='0'$s_sel>BPO</option>";
		if ($bpc == 1) {$s_sel = " SELECTED";} else {$s_sel = "";}
		$s_bpc .= "<option value='1'$s_sel>BPC</option>";
		$s_bpc .= "</select>";

		$s_bpc2 = "<select id='search_bpc' name='search_bpc'>";
		$s_bpc2 .= "<option value=''></option>";
		$s_bpc2 .= "<option value='0'>BPO</option>";
		$s_bpc2 .= "<option value='1'>BPC</option>";
		$s_bpc2 .= "</select>";
		
		$s_loc_sea = "<select id='search_location' name='search_location'>";
		$s_loc_sea .= "<option value=''></option>";
		while($row = mysql_fetch_array($q_location)) {
			$s_loc_sea .= "<option value='".$row["location"]."'>".$row["location"]."</option>";
		}
		$s_loc_sea .= "</select>";
		mysql_free_result($q_location);
		
		$s_js = 'js_ajax("blueprintSave",'.$blueprintID.',"div_blueprintOutput");js_ajax("blueprintInput",0,"div_blueprintInput");';
		$s_js2 = 'js_ajax("blueprintInput",0,"div_blueprintInput");';
		$s_js3 = 'js_ajax("blueprintSearch",0,"div_blueprintOutput");';
		$s_html = "<table border='0'>";
		$s_html .= "<tr>";
		$s_html .= "<td>Owner</td><td>".$s_owner."</td>";
		$s_html .= "<td>Blueprint</td><td colspan='3'><input id='blueprintName' name='blueprintName' size='40' maxlength='100' value='$blueprintName'></input></td>";
		$s_html .= "<td rowspan='4'>&nbsp;&nbsp;</td>";
		$s_html .= "<td rowspan='4' style='border:1px solid #999999;background-color:#CCA97B;'>";
		$s_html .= "<strong>Filter By:</strong><br/>";
		$s_html .= "Owner: ".$s_owner2."<br/>";
		$s_html .= "BP Type: ".$s_bpc2."<br/>";
		$s_html .= "BP Name <input id='search_blueprintName' name='search_blueprintName' size='10' maxlength='10' value=''></input><br/>";
		//$s_html .= "Location <input id='search_location' name='search_location' size='10' maxlength='10' value=''></input>&nbsp;";
		$s_html .= "Location $s_loc_sea&nbsp;";
		$s_html .= "<input type='button' id='search' name='search' value='search' onClick='$s_js3'></input>";
		$s_html .= "</td>";
		$s_html .= "</tr>";
		$s_html .= "<tr>";
		$s_html .= "<td>ME</td>";
		$s_html .= "<td>PL</td>";
		$s_html .= "<td>Copies</td>";
		$s_html .= "<td>Type</td>";
		$s_html .= "<td>Runs</td>";
		$s_html .= "<td>eveID</td>";
		$s_html .= "</tr>";
		$s_html .= "<tr>";
		$s_html .= "<td><input id='mat_lev' name='mat_lev' size='6' maxlength='6' value='$mat_lev'></input></td>";
		$s_html .= "<td><input id='prod_lev' name='prod_lev' size='6' maxlength='6' value='$prod_lev'></input></td>";
		$s_html .= "<td><input id='copies' name='copies' size='6' maxlength='6' value='$copies'></input></td>";
		$s_html .= "<td>$s_bpc</td>";
		$s_html .= "<td><input id='runs' name='runs' size='6' maxlength='6' value='$runs'></input></td>";
		$s_html .= "<td><input id='eveID' name='eveID' size='8' maxlength='6' value='$eveID'></input></td>";
		$s_html .= "</tr>";
		$s_html .= "<tr>";
		$s_html .= "<td>&nbsp;</td><td ><input type='button' id='go' name='go' value='save' onClick='$s_js'></input><input type='button' id='clear' name='clear' value='clear' onClick='$s_js2'></input></td>";
		$s_html .= "<td colspan='4'>Location <input id='location' name='location' size='40' maxlength='50' value='$location'></input></td>";
		$s_html .= "</tr>";
		$s_html .= "</table>";
		
		return $s_html;
	}
	function blueprintOutput($q_getData) {
		$i_cols = mysql_num_fields($q_getData);
		$s_html = "<table class='data' style = 'width:100%;'>";
		$s_html .= "<tr>";
		$s_html .= "<th>&nbsp;</th>";
		$s_html .= "<th>Owner</th>";
		$s_html .= "<th>Name</th>";
		$s_html .= "<th>ML</th>";
		$s_html .= "<th>PL</th>";
		$s_html .= "<th>Type</th>";
		$s_html .= "<th>Copies</th>";
		$s_html .= "<th>Runs</th>";
		$s_html .= "<th>Description</th>";
		$s_html .= "<th>eveID</th>";
		$s_html .= "<th>Location</th>";
		//for($i=0;$i<=$i_cols-1;$i++) {
		//  $s_html .= "<th>".$this->prettyName(mysql_field_name($q_getData,$i))."</th>";
		//}
		$s_html .= "</tr>";
		while($row = mysql_fetch_array($q_getData)) {
			$s_html .= "<tr>";
			$s_js = 'js_ajax("blueprintInput",'.$row[0].',"div_blueprintInput");';
			$s_html .= "<td align='center'><img src='..\images\adv_grey_harvey.gif' onclick='$s_js' title='edit' style='cursor:pointer;'></td>";
			$s_html .= "<td>".$row[1]."</td>";
			$s_html .= "<td>".$row[2]."</td>";
			$s_html .= "<td>".$row[3]."</td>";
			$s_html .= "<td>".$row[4]."</td>";
			if ($row[5] == 1) {$s_field = "C";}else{$s_field = "O";}
			$s_html .= "<td>".$s_field."</td>";
			$s_html .= "<td>".$row[6]."</td>";
			$s_html .= "<td>".$row[7]."</td>";
			$s_html .= "<td>".$row[10]."</td>";
			$s_html .= "<td>".$row[8]."</td>";
			$s_html .= "<td>".$row[9]."</td>";
			//for($i=0;$i<=$i_cols-1;$i++) {
			//	$temp = $row[$i];
			//	if ($temp == NULL) {$temp = "&nbsp;";}
			//	$s_html .= "<td>".$temp."</td>";
			//}
			$s_html .= "</tr>";
		}
		$s_html .= "<tr>";
		$s_html .= "<td colspan='11'>Total: ".mysql_num_rows($q_getData)."</td>";
		$s_html .= "</tr>";
		$s_html .= "</table>";

		return $s_html;
	}

	function shipInput() {
		$s_js = "js_ajax('shipOutput',0,'div_shipOutput');";
		//$s_html = "<input type='button' id='go' name='go' value='go' onClick='$s_js'></input>";
		$s_html = "<img src='..\..\images\sport_8ball.png' onclick='$s_js'>";
		return $s_html;
	}

	function itemInput($q_group) {
		$s_html = "";
		$s_js = 'js_ajax("itemOutput",0,"div_itemOutput");';
		$s_group = "<select id='item_groupID' name='item_groupID'>";
		$s_group .= "<option value='0'></option>";
		while($row = mysql_fetch_array($q_group)) {
			$s_group .= "<option value='".$row["groupID"]."'>".$row["groupName"]."</option>";
		}
		$s_group .= "</select><br/>";
		mysql_free_result($q_group);
		$s_html .= $s_group;
		$s_html .= "Text <input id='item_itemName' name='item_itemName' size='20' maxlength='20' value=''></input></td>";
		$s_html .= "<input type='button' id='filter' name='filter' value='filter' onclick='$s_js'></input>";
		return $s_html;
	}

	function genOutput($q_getData) {
		if (!$q_getData) {
			$s_html = "";
		} else {
			$i_cols = mysql_num_fields($q_getData);
			$s_html = "<table class='data' style = 'width:100%;'>";
			$s_html .= "<tr>";
			for($i=0;$i<=$i_cols-1;$i++) {
			  $s_html .= '<th>'.$this->prettyName(mysql_field_name($q_getData,$i)).'</th>';
			}
			$s_html .= "</tr>";
			while($row = mysql_fetch_array($q_getData)) {
				$s_html .= '<tr>';
				for($i=0;$i<=$i_cols-1;$i++) {
					$temp = $row[$i];
					if ($temp == NULL) {$temp = "&nbsp;";}
					$s_html .= '<td>'.$temp.'</td>';
				}
				$s_html .= '</tr>';
			}
			$s_html .= "</table>";
		}
		return $s_html;
	}

	function prettyName($s_instring) {
		return preg_replace('/(?<=[a-z])(?=[A-Z])/',' ',$s_instring);
	}

}
?>
