function js_requestPost(Task, container, itemID) {
	var sPostString = "";
	sPostString += "Task=" + Task + "&";
	sPostString += "itemID=" + itemID + "&";
	if (Task == "addPost" || Task == "updatePost") {
		sPostString += "TopicID=" + document.getElementById("topicID").value + "&";
		sPostString += "Subject=" + encodeURIComponent(document.getElementById("subject").value) + "&";
		sPostString += "Post=" + encodeURIComponent(document.getElementById("post").value.replace(/\r\n/g,"<br>")) + "&";
	}
	if (Task == "getSearch") {
		sPostString += "TopicID=" + encodeURIComponent(document.getElementById("topicFilter").value) + "&";
		sPostString += "Filter=" + encodeURIComponent(document.getElementById("filter").value) + "&";
		sPostString += "postID=" + document.getElementById("postID").value + "&";
	}
	if (Task == "saveReply") {
		sPostString += "replyText=" + encodeURIComponent(document.getElementById("replytext_"+itemID).value.replace(/\r\n/g,"<br>")) + "&";
	}
	if (Task == "updateReply") {
		sPostString += "replyText=" + encodeURIComponent(document.getElementById("replytext_"+itemID).value.replace(/\r\n/g,"<br>")) + "&";
		sPostString += "replyID=" + document.getElementById("postReplyID_"+itemID).value + "&";
	}
	sPostString = sPostString.replace("%","%25");
	document.getElementById(container).innerHTML = http_post_request("/braddoro/post/post_ajax.cfm",sPostString);
}