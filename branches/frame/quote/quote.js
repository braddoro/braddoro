function js_requestQuote(Task, container, itemID) {
	var sPostString = "";
	sPostString += "Task=" + Task + "&";
	sPostString += "quoteID=" + itemID + "&";
	sPostString += "outputDiv=" + "div_main" + "&";
	if (Task == "nav_First" || Task == "nav_Prev" || Task == "nav_Next" || Task == "nav_Last") {
		sPostString += "firstRow=" + document.getElementById("firstRow").value + "&";
		sPostString += "numRows=" + document.getElementById("numRows").value + "&";
		sPostString += "outputDiv=" + container + "&";
	}
	if (Task == "saveQuote") {
		sPostString += "quoteBy=" + document.getElementById("quoteBy").value + "&";
		sPostString += "quoteWhen=" + document.getElementById("quoteWhen").value + "&";
		sPostString += "active=" + document.getElementById("quoteActive").value + "&";
		sPostString += "quote=" + document.getElementById("quoteText").value.replace(/\r\n/g,"<br>") + "&";
	}
	sPostString = sPostString.replace("%","%25");
	document.getElementById(container).innerHTML = http_post_request("/braddoro/quote/quote_ajax.cfm",sPostString);
}