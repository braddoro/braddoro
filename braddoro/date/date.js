function js_requestDate(Task, container, itemID) {
	var sPostString = "";
	sPostString += "Task=" + Task + "&";
	sPostString += "outputDiv=" + container + "&";
	sPostString += "dateID=" + itemID + "&";
	if (Task == "saveDate") {
		sPostString += "userID=" + document.getElementById("userID").value + "&";
		sPostString += "dateData=" + document.getElementById("dateData").value + "&";
		sPostString += "dateDescription=" + document.getElementById("dateDescription").value.replace(/\r\n/g,"<br>") + "&";
		sPostString += "recurring=" + document.getElementById("recurring").value + "&";
		sPostString += "active=" + document.getElementById("active").value + "&";
		sPostString += "private=" + document.getElementById("private").value + "&";
	}
	sPostString = sPostString.replace("%","%25");
	document.getElementById(container).innerHTML = http_post_request("/braddoro/date/date_ajax.cfm",sPostString);
}