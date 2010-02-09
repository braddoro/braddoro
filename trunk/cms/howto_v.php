<?php
	class view {
		function outputHowTo($q_getData) {

			$s_html = '<table border="1">'.$g_break;
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
			    $s_html .= '<tr>'.$g_break;
			    $s_html .= '<td>'.$s_howtoName.'</td>'.$g_break;
			    $s_html .= '<td>'.$s_chapterName.'</td>'.$g_break;
			    $s_html .= '<td>'.$s_headingName.'</td>'.$g_break;
			    $s_html .= '<td>'.$s_contentTitle.'</td>'.$g_break;
			    $s_html .= '<td>'.$i_displayOrderCon.'</td>'.$g_break;
			    $s_html .= '<td>'.$s_howtoContent.'</td>'.$g_break;
			    //$s_html .= '<td>'.$i_chapterID.'</td>'.$g_break;
			    //$s_html .= '<td>'.$i_displayOrderCha.'</td>'.$g_break;
			    //$s_html .= '<td>'.$i_headingID.'</td>'.$g_break;
			    //$s_html .= '<td>'.$i_displayOrderHed.'</td>'.$g_break;
			    //$s_html .= '<td>'.$i_contentID.'</td>'.$g_break;
			    $s_html .= '</tr>'.$g_break;
			}
			$s_html .= '</table>'.$g_break;
						
			return $s_html;
		}	
	}
?>