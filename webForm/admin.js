function js_ajax(task,itemID,container) {
	var s_ajax = "task=" + task;
	s_ajax += "&itemID=" + itemID;
	if (task == "itemOutput") {
		s_ajax += "&groupID=" + 		document.getElementById("item_groupID").value;
		s_ajax += "&itemType=" + 		document.getElementById("item_itemName").value;
	}
	if (task == "blueprintSearch") {
		s_ajax += "&blueprintName=" +	document.getElementById("search_blueprintName").value;
		s_ajax += "&bpc=" + 			document.getElementById("search_bpc").value;
		s_ajax += "&ownerID=" + 		document.getElementById("search_ownerID").value;
		s_ajax += "&location=" + 		document.getElementById("search_location").value;
	}
	if (task == "blueprintSave") {
		s_ajax += "&eveID=" + 			document.getElementById("eveID").value;
		s_ajax += "&mat_lev=" + 		document.getElementById("mat_lev").value;
		s_ajax += "&prod_lev=" + 		document.getElementById("prod_lev").value;
		s_ajax += "&blueprintName=" +	document.getElementById("blueprintName").value;
		s_ajax += "&bpc=" + 			document.getElementById("bpc").value;
		s_ajax += "&runs=" + 			document.getElementById("runs").value;
		s_ajax += "&copies=" + 			document.getElementById("copies").value;
		s_ajax += "&ownerID=" + 		document.getElementById("ownerID").value;
		s_ajax += "&location=" + 		document.getElementById("location").value;
	}
	var s_return = http_post_request("admin_ajax.php",s_ajax);
	
	if (container != "") {
		if (document.getElementById(container)) {
			document.getElementById(container).innerHTML = s_return;
		}
	} else {
		return s_return;
	}
}
function js_showPanel(tab,panelName,task,iLeft,iTop,iRight,iBottom) {
	var panel = tab.panel;
	var o_panel = new cPanel("panel_"+panelName,iLeft,iTop,iRight,iBottom,guiFolder);
	
	s_divName = "div_"+panelName;
	var txt = "<div id='"+s_divName+"' name='"+s_divName+"'>";
	txt += js_ajax(task,0,"");
	txt += "</div>";
	o_panel.html(txt);
	panel.add(o_panel);
}
var tabs = new cTabset("tabForm",15,50,800,600);
var tab_blueprint = tabs.addTab("Blueprints");
js_showPanel(tab_blueprint,"blueprintInput","blueprintInput",10,10,780,120);
js_showPanel(tab_blueprint,"blueprintOutput","blueprintOutput",10,140,780,430);
var tab_ship = tabs.addTab("Ships");
js_showPanel(tab_ship,"shipInput","shipInput",10,10,780,40);
js_showPanel(tab_ship,"shipOutput","shipOutput",10,60,780,500);
var tab_suntzu = tabs.addTab("Sun Tzu");
js_showPanel(tab_suntzu,"suntzuInput","suntzuInput",10,10,780,40);
js_showPanel(tab_suntzu,"suntzuOutput","suntzuOutput",10,60,780,500);
var tab_quote = tabs.addTab("Quotes");
js_showPanel(tab_quote,"quoteInput","quoteInput",10,10,780,40);
js_showPanel(tab_quote,"quoteOutput","quoteOutput",10,60,780,500);
var tab_market = tabs.addTab("Market");
js_showPanel(tab_market,"emarketInput","marketInput",10,10,780,40);
js_showPanel(tab_market,"marketOutput","marketOutput",10,60,780,500);
var tab_item = tabs.addTab("Items");
js_showPanel(tab_item,"itemInput","itemInput",10,10,780,100);
js_showPanel(tab_item,"itemOutput","itemOutput",10,120,780,430);
tabs.showTabIndex(0);
