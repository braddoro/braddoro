function js_requestDate(Task, container, itemID) {
	var sPostString = "";
	sPostString += "Task=" + Task + "&";
	sPostString += "itemID=" + itemID + "&";
	//if (Task == "saveMessage") {
	//	sPostString += "messageText=" + document.getElementById("messageText").value.replace(/\r\n/g,"<br>") + "&";
	//	sPostString += "message_userID=" + document.getElementById("message_userID").value + "&";
	//}
	sPostString = sPostString.replace("%","%25");
	document.getElementById(container).innerHTML = http_post_request("/braddoro/message/message_ajax.cfm",sPostString);
}