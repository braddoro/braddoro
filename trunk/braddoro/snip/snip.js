function js_ajax(Task,itemID,container) {
	var s_ajax = "Task=" + Task;
	s_ajax += "&itemID=" + itemID;
	alert(Task);
	if (Task == "save") {
		s_ajax += "&category=" + encodeURIComponent(document.getElementById("category").value);
		s_ajax += "&title=" + encodeURIComponent(document.getElementById("title").value);
		s_ajax += "&snippet=" + encodeURIComponent(document.getElementById("snippet").value);
	}
	var tmpX = http_post_request("snip_ajax.cfm",s_ajax);
	alert(tmpX);
	document.getElementById(container).innerHTML = tmpX; 
}