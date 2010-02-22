<?php
	class view {
		function outputHowTo($q_getData) {

			$s_chapterName_name = "";
			$s_html = '<table border="0">'.$g_break;
			$i_row = 0;
			while ($rowData = mysql_fetch_row($q_getData)) {
			    $s_howtoName		= $rowData[0];
			    $i_chapterID		= $rowData[1]; 
			    $s_chapterName		= $rowData[2]; 
			    $i_displayOrderCha	= $rowData[3];
			    $i_headingID		= $rowData[4];
			    $i_displayOrderHed	= $rowData[5];
			    $s_headingName		= $rowData[6];
			    $i_contentID		= $rowData[7];
			    $s_contentTitle		= $rowData[8];
			    $i_displayOrderCon	= $rowData[9];
			    $s_howtoContent		= $rowData[10];
			    
				if ($i_row == 0) {
					// Title
				    $s_html .= '<tr>'.$g_break;
				    $s_html .= '<td colspan="8" style="font-size:1.5em">'.$s_howtoName.'</td>'.$g_break;
				    $s_html .= '</tr>'.$g_break;
				}
				if ($s_chapterName_name != $s_chapterName) {
					// Chapter
				    $s_html .= '<tr>'.$g_break;
				    $s_html .= '<td>&nbsp;</td>'.$g_break;
				    $s_html .= '<td>'.$i_chapterID.'</td>'.$g_break;
				    $s_html .= '<td colspan="6" style="font-size:1.25em">'.$s_chapterName.'</td>'.$g_break;
				    $s_html .= '</tr>'.$g_break;
				}			    
				if ($s_chapterName_name != $s_chapterName) {
					// Heading
					$s_html .= '<tr>'.$g_break;
					$s_html .= '<td colspan="2">&nbsp;</td>'.$g_break;
				    $s_html .= '<td>'.$i_headingID.'</td>'.$g_break;
				    $s_html .= '<td colspan="5" style="font-size:1em">'.$s_headingName.'</td>'.$g_break;
				    $s_html .= '</tr>'.$g_break;
				}
				// Detail			    
				$s_html .= '<tr>'.$g_break;
				$s_html .= '<td colspan="4">&nbsp;</td>'.$g_break;
			    $s_html .= '<td colspan="4" style="font-size:.9em">'.$s_contentTitle.'</td>'.$g_break;
			    $s_html .= '</tr>'.$g_break;
				// Content			    
			    $s_html .= '<tr>'.$g_break;
			    $s_html .= '<td colspan="6">&nbsp;</td>'.$g_break;
				if ($i_displayOrderCon == 0) {
					$s_output = "";
				} else {
					$s_output = $i_displayOrderCon;
				}
			    $s_html .= '<td style="font-size:.9em">'.$s_output.'</td>'.$g_break;
			    $s_html .= '<td style="font-size:.9em">'.str_replace("\n","<br />",$s_howtoContent).'</td>'.$g_break;
			    $s_html .= '</tr>'.$g_break;
			    //$s_html .= '<td>'.$i_displayOrderCha.'</td>'.$g_break;
			    //$s_html .= '<td>'.$i_displayOrderHed.'</td>'.$g_break;
			    //$s_html .= '<td>'.$i_contentID.'</td>'.$g_break;
			    $s_chapterName_name = $s_chapterName;
			    $i_row++;
			}
			$s_html .= '</table>'.$g_break;
						
			return $s_html;
		}	
	}
?>