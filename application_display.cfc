<cfcomponent displayname="application_display" output="false">

<cffunction access="public" output="false" returntype="string" name="showJavascript">
	<cfargument name="showDebug" type="boolean" default="false">

	<cfsavecontent variable="s_showJavascript">
	<cfoutput>
<script language="javascript" type="text/javascript">
function ChangeTextSize(element,changeBy) {
	document.getElementById(element).rows = parseInt(document.getElementById(element).rows)+parseInt(changeBy);
}

function ChangeTextSizeW(element,changeBy) {
	document.getElementById(element).cols = parseInt(document.getElementById(element).cols)+parseInt(changeBy);
}
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
function js_buildRequest(Task, container, itemID) {
	var sPostString = "";
	sPostString += "Task=" + Task + "&";
	sPostString += "itemID=" + itemID + "&";
	if (Task == "addPost" || Task == "updatePost") {
		sPostString += "TopicID=" + document.getElementById("topicID").value + "&";
		sPostString += "Subject=" + document.getElementById("subject").value + "&";
		sPostString += "Post=" + document.getElementById("post").value.replace(/\r\n/g,"<br>") + "&";
	}
	if (Task == "getSearch") {
		sPostString += "TopicID=" + document.getElementById("topicFilter").value + "&";
		sPostString += "Filter=" + document.getElementById("filter").value + "&";
	}
	if (Task == "authenticateUser") {
		sPostString += "userName=" + document.getElementById("username").value + "&";
		sPostString += "password=" + hex_md5(document.getElementById("password").value) + "&";
	}
	if (Task == "saveReply") {
		sPostString += "replyText=" + document.getElementById("replytext_"+itemID).value.replace(/\r\n/g,"<br>") + "&";
	}
	if (Task == "updateReply") {
		sPostString += "replyText=" + document.getElementById("replytext_"+itemID).value.replace(/\r\n/g,"<br>") + "&";
		sPostString += "replyID=" + document.getElementById("postReplyID_"+itemID).value + "&";
	}
	if (Task == "saveMessage") {
		sPostString += "messageText=" + document.getElementById("messageText").value.replace(/\r\n/g,"<br>") + "&";
		sPostString += "message_userID=" + document.getElementById("message_userID").value + "&";
	}
	sPostString = sPostString.replace("%","%25");
	<cfif arguments.showDebug EQ true>alert(sPostString);</cfif>
	document.getElementById(container).innerHTML = http_post_request("/braddoro/braddoro_ajax.cfm",sPostString);
}
</script>
<script type="text/javascript" src="/braddoro/md5.js"></script>
	</cfoutput>
	</cfsavecontent>
	<cfreturn s_showJavascript>
	
</cffunction>	

</cfcomponent>