<cfset objSnip = createObject("component","snip_logic")>
<html>
<head>
<title>Snip Library</title>
<script language="javascript">
function http_post_request(url, sPostString) {
	var results = "";
	var ajax_http_request = false;
	var AjaxTime = new Date();
	sPostString += "AjaxTime=" + AjaxTime.getTime();
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
function js_ajax(Task,snippetID,container) {
	var s_ajax = "Task=" + Task;
	s_ajax += "&snippetID=" + snippetID;
	if (Task == "save") {
		s_ajax += "&category=" + encodeURIComponent(document.getElementById("category").value);
		s_ajax += "&title=" + encodeURIComponent(document.getElementById("title").value);
		s_ajax += "&snippet=" + encodeURIComponent(document.getElementById("snippet").value);
	}
	alert(s_ajax);
	var tmpX = http_post_request("snip_ajax.cfm",s_ajax);
	alert(tmpX);
	document.getElementById(container).innerHTML = tmpX; 
}
</script> 
</head>
<body>
Snip Library
<hr>
<cfoutput>
<div id="div_input" name="div_input">
#objSnip.input(snippetID=-1)#
</div>
<hr>
<div id="div_output" name="div_output">
#objSnip.output(snippetID=0)#
</div>
</cfoutput>
</body>
</head>
</html>
<!--- <script type="text/javascript" src="../utility/ajax.js"><script type="text/javascript" src="snip.js"> --->