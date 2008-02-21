function js_requestUser(Task, container, itemID) {
	var sPostString = "";
	sPostString += "Task=" + Task + "&";
	sPostString += "itemID=" + itemID + "&";
	if (Task == "authenticateUser") {
		sPostString += "userName=" + document.getElementById("username").value + "&";
		sPostString += "password=" + hex_md5(document.getElementById("password").value) + "&";
	}
	if (Task == "saveUserInfo") {
		sPostString += "userID=" + document.getElementById("userID").value + "&";
		sPostString += "username=" + document.getElementById("username").value + "&";
		sPostString += "siteName=" + document.getElementById("siteName").value + "&";
		sPostString += "realName=" + document.getElementById("realName").value + "&";
		if (document.getElementById("password")) {
			sPostString += "password=" + hex_md5(''+document.getElementById("password").value) + "&";
		}
		sPostString += "webSite=" + document.getElementById("webSite").value + "&";
		sPostString += "emailAddress=" + document.getElementById("emailAddress").value + "&";
		sPostString += "dateOfBirth=" + document.getElementById("dateOfBirth").value + "&";
		sPostString += "zipCode=" + document.getElementById("zipCode").value + "&";
	}
	sPostString = sPostString.replace("%","%25");
	document.getElementById(container).innerHTML = http_post_request("/braddoro/user/user_ajax.cfm",sPostString);
}