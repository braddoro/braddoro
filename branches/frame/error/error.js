function js_requestError(Task, container, itemID) {
	var sPostString = "";
	sPostString += "Task=" + Task + "&";
	sPostString += "itemID=" + itemID + "&";
	sPostString = sPostString.replace("%","%25");
	document.getElementById(container).innerHTML = http_post_request("/braddoro/error/error_ajax.cfm",sPostString);
}