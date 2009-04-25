function http_post_request(url,s_post) {
	var results = "";
	var ajax_http_request = false;
	var AjaxTime = new Date();
	s_post += "&ajaxTime=" + AjaxTime.getTime();
	if (window.XMLHttpRequest) {
		ajax_http_request = new XMLHttpRequest();
		if (ajax_http_request.overrideMimeType) {
			ajax_http_request.overrideMimeType("text/html");
		}
	} else if (window.ActiveXObject) {
		try {
			ajax_http_request = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e0) {
			try {
				ajax_http_request = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e1) {
				var strErr = "Object Error";
				strErr += "\nNumber: " + e1.number;
				strErr += "\nDescription: " + e1.description;
				results = strErr;
			}
		}
	}
	if (!ajax_http_request) {
		results = "Cannot create XML/HTTP instance";
	} else {
		ajax_http_request.open("POST", url, false);
		ajax_http_request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		ajax_http_request.setRequestHeader("Content-length", s_post.length);
		ajax_http_request.setRequestHeader("Connection", "close");
		ajax_http_request.send(s_post);
		results = ajax_http_request.responseText;
	}
	return results;
}
function js_validate() {
var isValid = true;
if (
	(document.getElementById("newinput_check").checked == true && document.getElementById("new_category").value != "") || 
	(document.getElementById("newinput_check").checked == false && document.getElementById("category").value != "")
	) {
	isValid = true;
}else{
	isValid = false;
	alert("You must enter a category.")
}

if (isValid && document.getElementById("snip_name").value == "")  {
	isValid = false;
	alert("You must enter a snip_name.")
}
if (isValid && document.getElementById("snippetStart").value == "")  {
	isValid = false;
	alert("You must enter a snippet.")
}

return isValid;
}
function js_ajax(Task,snipID,container) {
	var b_send = true;	
	var s_ajax = "Task=" + Task;
	s_ajax += "&snippetID=" + snipID;
	if (Task == "save") {
		if (js_validate()) {
			if (document.getElementById("newinput_check").checked == true) {
				s_ajax += "&category=" + encodeURIComponent(document.getElementById("new_category").value);
			}else{
				s_ajax += "&category=" + encodeURIComponent(document.getElementById("category").value);
			}
			s_ajax += "&snip_name=" + encodeURIComponent(document.getElementById("snip_name").value);
			s_ajax += "&snip_help=" + encodeURIComponent(document.getElementById("snip_help").value); 
			s_ajax += "&snippetStart=" + encodeURIComponent(document.getElementById("snippetStart").value);
			s_ajax += "&snippetEnd=" + encodeURIComponent(document.getElementById("snippetEnd").value);
		}else{
			b_send = false;
		}
	}
	if(b_send) {
		var tmpX = http_post_request("snip_ajax.cfm",s_ajax);
		document.getElementById(container).innerHTML = tmpX;
	}
	if (b_send && Task == "save") {
		document.getElementById("div_input").style.display = "none";
	} 
	if (Task == "edit") {
		document.getElementById("div_input").style.display = "block";
	} 
	if (Task == "show") {
		document.getElementById("div_input").style.display = "none";
		document.getElementById("div_output").style.display = "block";
	} 
}
function js_collapseThis(changeme) {
	if (document.getElementById(changeme).style.display == "block") {
		document.getElementById(changeme).style.display = "none";
	} else {
		document.getElementById(changeme).style.display = "block";
	}
}
function js_collapseThis2(changeme,changeImage) {
	if (document.getElementById(changeme).style.display == "block") {
		document.getElementById(changeme).style.display = "none";
		document.getElementById(changeImage).src = "2.gif"
	} else {
		document.getElementById(changeme).style.display = "block";
		document.getElementById(changeImage).src = "1.gif"
	}
}