<?php
	class data {
		function outputTable(){

			$s_server = "65.175.107.2:3306";
			$s_userName = "cms_user";
			$s_password = "alvahugh";
			$s_db = "cms";
			$o_conn = mysql_connect($server=$s_server,$username=$s_userName,$password=$s_password);
			if (!$o_conn) {die_well(mysql_error());}
			$o_sel = mysql_select_db($s_db);
			if (!$o_sel) {die_well(mysql_error());}
			$s_sql = "select
			    D.howtoName,
			    C.chapterID, 
			    C.chapterName, 
			    C.displayOrder,
			    H.headingID,
			    H.displayOrder,
			    H.headingName,
			    T.contentID,
			    T.contentTitle,
			    T.displayOrder,
			    T.howtoContent
			from cms.dyn_howto_document D
			inner join cms.dyn_howto_content T
			    on D.howtoID = T.howtoID
			inner join cms.cfg_howto_headings H
			    on H.headingID = T.headingID
			inner join cms.cfg_howto_chapters C
			    on C.chapterID = H.chapterID 
			order by
			    C.displayOrder,
			    H.displayOrder,
			    T.displayOrder,
			    T.howtoContent;";
			$q_data = mysql_query($s_sql);
			
			return $q_data;
		}	
	}
?>