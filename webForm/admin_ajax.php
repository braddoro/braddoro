<?php
require "..\common\lib_functions.php";
$s_html = "";
$s_task = lib_set_var("task","error");
$i_itemID = intval(lib_set_var("itemID","0"));

require_once "admin_c.php"; 
$objAdmin = new c_controller();

switch ($s_task) {
case "itemInput":
	$s_html = $objAdmin->itemInput();
	break;
case "itemOutput":
	$groupID = 	intval(lib_set_var("groupID","0"));
	$itemType =	lib_set_var("itemType","");
	$s_sql = "select I.typeID, I.typeName, MG.metaGroupName, G.groupName, M.marketGroupName, M.description, I.description
		from braddoro.invtypes I
		inner join braddoro.invmarketgroups M
			on  I.marketGroupID = M.marketGroupID
		inner join braddoro.invgroups G
			on I.groupID = G.groupID 
		inner join braddoro.invmetatypes MT
			on I.typeID = MT.typeID
		inner join braddoro.invmetagroups MG
		on MT.metaGroupID = MG.metaGroupID
		where 1=1 "; 
	if ($groupID > 0) {
		$s_sql .= "and I.groupID = $groupID ";
	}
	if ($itemType > "") {
		$s_sql .= "and I.typeName like '%$itemType%' ";
	}
	$s_sql .= "order by I.typeName limit 500;";
	$s_html = $objAdmin->genOutput($s_sql);
	break;
case "marketInput":
	$s_html = "";
	break;
case "marketOutput":
	$s_sql = "select marketID, eveID, type, itemName, outputModifier, volume, avg, min, max, stddev, median, dateUpdated FROM braddoro.cfg_eve_market;";
	$s_html = $objAdmin->genOutput($s_sql);
	break;
case "quoteInput":
	$s_html = "";
	break;
case "quoteOutput":
	$s_sql = "select quoteID, quote, quoteBy, quoteWhen, active FROM braddoro.cfg_quotes order by quote;";
	$s_html = $objAdmin->genOutput($s_sql);
	break;
case "suntzuInput":
	$s_html = "";
	break;
case "suntzuOutput":
	$s_sql = "select lineID, chapterID, paragraphID, chapterName, paragraph FROM braddoro.suntzu order by chapterID, chapterName, paragraphID, paragraph;";
	$s_html = $objAdmin->genOutput($s_sql);
	break;
case "shipInput":
	$s_html = $objAdmin->shipInput();
	break;
case "shipOutput":
	$s_sql = "select shipID, eveID, race, class, techLevel, tier, shipName, strength from braddoro.dyn_eve_ship_class order by shipName;";
	$s_html = $objAdmin->genOutput($s_sql);
	break;
case "blueprintInput":
	$itemID = intval(lib_set_var("itemID","0"));
	$s_html = $objAdmin->blueprintInput($itemID);
	break;
case "blueprintSearch":
	$ownerID = 			intval(lib_set_var("ownerID","0"));
	$bpc = 				lib_set_var("bpc","");
	$blueprintName =	lib_set_var("blueprintName","");
	$location =			lib_set_var("location","");
	$s_sql = "select B.blueprintID, O.owner, B.blueprintName, B.mat_lev, B.prod_lev, B.bpc, B.copies, B.runs, B.eveID, B.location, M.description  
	from braddoro.dyn_blueprints B 
	left join braddoro.dyn_blueprint_owners O on B.ownerID = O.ownerID
	left join braddoro.invtypes T on B.eveID = T.typeID
	left join braddoro.invmarketgroups M on T.marketGroupID = M.marketGroupID
	where 1=1 "; 
	if ($ownerID != "") {
		$s_sql .= "and B.ownerID = $ownerID ";
	}
	if ($bpc != "") {
		$s_sql .= "and B.bpc = ".intval($bpc)." ";
	}
	if ($blueprintName != "") {
		$s_sql .= "and B.blueprintName like '%$blueprintName%' ";
	}
	if ($location != "") {
		$s_sql .= "and B.location like '%$location%' ";
	}
	$s_sql .= "order by B.blueprintName;";
	$s_html = $objAdmin->blueprintOutput($s_sql);
	break;
case "blueprintOutput":
	$s_sql = "select B.blueprintID, O.owner, B.blueprintName, B.mat_lev, B.prod_lev, B.bpc, B.copies, B.runs, B.eveID, B.location, M.description  
	from braddoro.dyn_blueprints B 
	left join braddoro.dyn_blueprint_owners O on B.ownerID = O.ownerID
	left join braddoro.invtypes T on B.eveID = T.typeID
	left join braddoro.invmarketgroups M on T.marketGroupID = M.marketGroupID
	order by B.blueprintName;";
	$s_html = $objAdmin->blueprintOutput($s_sql);
	break;
case "blueprintSave":
	$eveID = 			intval(lib_set_var("eveID","0"));
	$mat_lev = 			intval(lib_set_var("mat_lev","0"));
	$prod_lev = 		intval(lib_set_var("prod_lev","0"));
	$blueprintName =	lib_set_var("blueprintName","");
	$bpc = 				intval(lib_set_var("bpc","0"));
	$runs = 			intval(lib_set_var("runs","0"));
	$copies = 			intval(lib_set_var("copies","0"));
	$ownerID = 			intval(lib_set_var("ownerID","0"));
	$location =			lib_set_var("location","");
	if ($i_itemID > 0) {
		$s_sql = "update braddoro.dyn_blueprints set mat_lev = $mat_lev, prod_lev = $prod_lev, blueprintName = rtrim('$blueprintName'), bpc = $bpc, runs = $runs, copies = $copies, ownerID = $ownerID, updateDate = now(), location = '$location', eveID = $eveID where blueprintID = $i_itemID;";
	}else{
		$s_sql = "INSERT INTO braddoro.dyn_blueprints (eveID,mat_lev,prod_lev,blueprintName,bpc,runs,copies,ownerID,updateDate,location) select $eveID,$mat_lev,$prod_lev,rtrim('$blueprintName'),$bpc,$runs,$copies,$ownerID,now(), '$location';";
	}
	$s_html = $objAdmin->genSQL($s_sql);

	$s_sql = "update braddoro.dyn_blueprints, braddoro.invtypes set eveID = typeID where (eveID is null or eveID = 0) AND typeName = concat(rtrim(blueprintName),' Blueprint');";
	$s_html = $objAdmin->genSQL($s_sql);

	$s_sql = "select B.blueprintID, O.owner, B.blueprintName, B.mat_lev, B.prod_lev, B.bpc, B.copies, B.runs, B.eveID, B.location, M.description  
	from braddoro.dyn_blueprints B 
	left join braddoro.dyn_blueprint_owners O on B.ownerID = O.ownerID
	left join braddoro.invtypes T on B.eveID = T.typeID
	left join braddoro.invmarketgroups M on T.marketGroupID = M.marketGroupID order by B.blueprintName;";
	$s_html = $objAdmin->blueprintOutput($s_sql);
	break;
case "error":
	$s_html = $s_task;
	break;
}
echo $s_html;
?>