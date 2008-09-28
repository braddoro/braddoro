function js_requestMessage(Task, container, itemID) {
	var sPostString = "";
	var b_callAJAX = true;
	sPostString += "Task=" + Task + "&";
	sPostString += "itemID=" + itemID + "&";
	if (Task == "replyTo") {
		var i_toUserID = http_post_request("/braddoro/message/message_ajax.cfm",sPostString);
		document.getElementById("message_userID").value = i_toUserID;
		document.getElementById("message_threadID").value = itemID;
		document.getElementById("messageText").focus();
		b_callAJAX = false;
	}
	if (Task == "saveMessage") {
		sPostString += "messageText=" + document.getElementById("messageText").value.replace(/\r\n/g,"<br>") + "&";
		sPostString += "message_userID=" + document.getElementById("message_userID").value + "&";
		sPostString += "threadID=" + document.getElementById("message_threadID").value + "&";
		
	}
	if (b_callAJAX) { 
		sPostString = sPostString.replace("%","%25");
		document.getElementById(container).innerHTML = http_post_request("/braddoro/message/message_ajax.cfm",sPostString);
	}
}