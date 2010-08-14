function http_post_request(url,sPostString) {
	var results = "";
	var ajax_http_request = false;
	var AjaxTime = new Date();
	sPostString += "&ajaxTime=" + AjaxTime.getTime();
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
		ajax_http_request.setRequestHeader("Content-length", sPostString.length);
		ajax_http_request.setRequestHeader("Connection", "close");
		ajax_http_request.send(sPostString);
		results = ajax_http_request.responseText;
	}
	return results;
}
function js_clearMe(Cname,Fname) {
	document.getElementById(Fname).value = "";
	if (document.getElementById(Cname).value == "") {
		document.getElementById(Fname).disabled = false;
	} else {
		document.getElementById(Fname).disabled = true;
	}
}
function js_hideMe() {
	document.getElementById("div_expand").style.display = "none";
}
function js_ajax(task,itemID,container) {
	var s_ajax = "task="+task;
	s_ajax += "&itemID="+itemID;
	s_ajax += "&command="+g_command;
	if (document.getElementById("purpose") && document.getElementById("purpose").value != "") {
		s_ajax += "&purpose="+document.getElementById("purpose").value;
	}
	if (document.getElementById("purpose_new") && document.getElementById("purpose_new").value != "") {
		s_ajax += "&purpose="+document.getElementById("purpose_new").value;
	}
	if (document.getElementById("shipName") && document.getElementById("shipName").value != "") {
		s_ajax += "&shipName="+document.getElementById("shipName").value;
	}
	if (document.getElementById("shipName_new") && document.getElementById("shipName_new").value != "") {
		s_ajax += "&shipName="+document.getElementById("shipName_new").value;
	}
	if (document.getElementById("slot") && document.getElementById("slot").value != "") {
		s_ajax += "&slot="+document.getElementById("slot").value;
	}
	if (document.getElementById("slot_new") && document.getElementById("slot_new").value != "") {
		s_ajax += "&slot="+document.getElementById("slot_new").value;
	}
	if (document.getElementById("module") && document.getElementById("module").value != "") {
		s_ajax += "&module="+document.getElementById("module").value;
	}
	var s_return = http_post_request("input_ajax.php",s_ajax);
	if (document.getElementById(container)) {
		document.getElementById(container).style.display = "block";
		document.getElementById(container).innerHTML = s_return;
		if (task == "edit") {
			document.getElementById("purpose").focus();
		}
	} else {
		return s_return;
	}
}
