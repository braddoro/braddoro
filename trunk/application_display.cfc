<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction name="init" displayname="init" access="package" output="false">

	<cfreturn this>
</cffunction>
<!--- End Function  --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="showJavascript">
	<cfargument name="showDebug" type="boolean" default="false">

	<cfsavecontent variable="s_showJavascript">
	<cfoutput>
<script language="javascript" type="text/javascript">
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
	<cfif arguments.showDebug EQ true>alert(sPostString);</cfif>
	document.getElementById(container).innerHTML = http_post_request("/braddoro/braddoro_ajax.cfm",sPostString);
}
</script>
<script type="text/javascript" src="/braddoro/md5.js"></script>
<script type="text/javascript" src="/braddoro/ajax.js"></script>
<script type="text/javascript" src="/braddoro/utility.js"></script>
	</cfoutput>
	</cfsavecontent>
	<cfreturn s_showJavascript>
	
</cffunction>	
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="showBanner">
<cfargument type="string" name="siteName" default="">
<cfargument type="string" name="siteTitle" default="">

	<cfsavecontent variable="s_showBanner">
		<cfoutput>#siteTitle#<cfif arguments.siteName NEQ ""><span class="mediumtext"> - #arguments.siteName#</span></cfif></cfoutput>
	</cfsavecontent>
	
	<cfreturn s_showBanner>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="showNavMenu">
	<cfargument name="userID" type="numeric" default="1">
	
	<cfsavecontent variable="s_showNavMenu">
		<cfoutput>
		<cfif arguments.userID EQ 12>
		<input type="button" id="quoteStuff" name="quoteStuff" value="quote stuff" class="navButtons" style="" onclick="js_requestQuote(this.id,'div_main',0);">
		</cfif>
		<cfif arguments.userID LT 2>
		<input type="button" id="logIn" name="logIn" value="log in" class="navButtons" style="" onclick="js_buildRequest(this.id,'div_main',0);">
		</cfif>
		<input type="button" id="showPost" name="showPost" value="show posts" class="navButtons" style="" onclick="js_buildRequest(this.id,'div_main',0);">
		<input type="button" id="searchPost" name="searchPost" value="search posts" class="navButtons" style="" onclick="js_buildRequest(this.id,'div_main',0);">	
		<cfif arguments.userID GT 1>
		<input type="button" id="composePost" name="composePost" value="compose post" class="navButtons" style="" onclick="js_buildRequest(this.id,'div_main',0);">
		<input type="button" id="showMessages" name="showMessages" value="messages" class="navButtons" style="" onclick="js_buildRequest(this.id,'div_main',0);">
		<input type="button" id="showUserInfo" name="showUserInfo" value="user info" class="navButtons" style="" onclick="js_buildRequest(this.id,'div_main',0);">
		</cfif>
		</cfoutput>
	</cfsavecontent>
	<cfreturn s_showNavMenu>
	
	</cffunction>
<!--- End Function --->

</cfcomponent>