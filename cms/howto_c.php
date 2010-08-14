<?php 
	include_once "howto_m.php";
	include_once "howto_v.php";
	class howTo {
		public function saveItem($i_howtoID, $s_sql) {
			$objThis_M = new data();
			$q_getData = $objThis_M->runSQL($s_sql);
			
			$this->outputHowTo($i_howtoID);
		}
		
		public function outputHowTo($i_howtoID) {
			$objThis_M = new data();
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
			left join cms.cfg_howto_headings H
			    on T.headingID = H.headingID 
			inner join cms.cfg_howto_chapters C
			    on T.chapterID = C.chapterID 
			where D.howtoID = $i_howtoID 
			order by
			    C.displayOrder,
			    H.displayOrder,
			    T.displayOrder,
			    T.howtoContent;";
			$q_getData = $objThis_M->runSQL($s_sql);
			
			$objThis_V = new view();
			$s_main = $objThis_V->outputHowTo($q_getData);
			
			return $s_main;
		}
	}
?>