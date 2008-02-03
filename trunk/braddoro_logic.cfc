<cfcomponent extends="braddoro_sql">

<!---  Begin Function --->
<cffunction access="public" output="false" name="logic_Init">
  <cfargument required="true" type="string" name="dsn">

  	<cfset variables.module_dsn = arguments.dsn>
	<cfset variables.siteBanner = "braddoro.com">
	<cfset variables.postsToShow = 20>
	
	<cfset g_crlf = chr(13)&chr(10)>

  <cfreturn this>
</cffunction>
<!---  End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="logic_javaScript">
	<cfargument name="showDebug" type="boolean" default="false">

	<cfsavecontent variable="ret_logic_javaScript">
	<cfoutput>
<script language="JavaScript" type="text/javascript">

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
		sPostString += "password=" + document.getElementById("password").value + "&";
	}
	if (Task == "saveReply") {
		sPostString += "replyText=" + document.getElementById("replytext_"+itemID).value.replace(/\r\n/g,"<br>") + "&";
	}
	if (Task == "updateReply") {
		sPostString += "replyText=" + document.getElementById("replytext_"+itemID).value.replace(/\r\n/g,"<br>") + "&";
		sPostString += "replyID=" + document.getElementById("postReplyID_"+itemID).value + "&";
	}
	sPostString = sPostString.replace("%","%25");
	<cfif arguments.showDebug EQ true>alert(sPostString);</cfif>
	document.getElementById(container).innerHTML = http_post_request("braddoro_ajax.cfm",sPostString);
}
</script>
	</cfoutput>
	</cfsavecontent>
	<cfreturn ret_logic_javaScript>
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="logic_getConstant"><cfargument name="ConstantName" type="string" required="true"><cfset local_return = evaluate(arguments.ConstantName)><cfreturn local_return></cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="void" name="logic_setConstant">
	<cfargument name="constantName" type="string" required="true">
	<cfargument name="constantvalue" type="string" required="true">
	<cfset "variables.#arguments.constantName#" = '#arguments.constantValue#'>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="query" name="logic_checkUser">
<cfargument name="userGUID" type="string" required="true">
	<!--- <cfset userGUID = CreateUUID()> --->	
	<cfset q_sql_checkUser = this.sql_checkUser(userGUID=arguments.userGUID)>
	
	<cfreturn q_sql_checkUser>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="query" name="logic_authenticateUser">
<cfargument name="username" type="string" required="true">
<cfargument name="password" type="string" required="true">

	<cfset q_logic_authenticateUser = this.sql_checkUser(userName=arguments.userName,password=hash(arguments.password))>
	<cfloop query="q_logic_authenticateUser">
		<cfset session.userID = userID>
		<cfset session.siteName = siteName>
		<cfset cookie.userGUID = userGUID>
	</cfloop>
	<cfset variables.userID = q_logic_authenticateUser.userID>
	<cfset x = this.display_showBanner(siteName=q_logic_authenticateUser.siteName)>
	<cfreturn q_logic_authenticateUser>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="logic_getQuote">

	<cfset q_logic_getQuote = this.sql_getQuote()>
	<cfsavecontent variable="ret_logic_getQuote">
	<cfoutput query="q_logic_getQuote">
		#quote#<cfif quoteBy NEQ ""> - #quoteBy#</cfif><cfif quoteWhen NEQ ""> (#quoteWhen#)</cfif>
	</cfoutput>
	</cfsavecontent>

	<cfreturn ret_logic_getQuote>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="logic_displayPosts">
<cfargument name="numberToGet" type="numeric" required="true">
<cfset q_logic_displayPosts = this.sql_getPosts(numberToGet=arguments.numberToGet)>
<cfsavecontent variable="ret_logic_displayPosts">
<cfoutput>#this.display_posts(postQuery=q_logic_displayPosts)#</cfoutput>
</cfsavecontent>
<cfreturn ret_logic_displayPosts>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="logic_getSearch">
	<cfargument name="topicID" type="numeric" default="0">
	<cfargument name="filterString" type="string" default="">

	<cfset q_logic_getSearch = this.sql_getPosts(topicID=arguments.topicID,filterString=arguments.filterString)>
	<cfsavecontent variable="ret_logic_getSearch">
	<cfoutput>
		<cfoutput>#this.display_posts(postQuery=q_logic_getSearch)#</cfoutput>
	</cfoutput>
	</cfsavecontent>
	<cfreturn ret_logic_getSearch>	
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="logic_navMenu">
	<cfargument name="userID" type="numeric" default="1"> 
	
	<cfsavecontent variable="ret_logic_navMenu">
	<cfoutput>
		#this.display_navMenu(userID=arguments.userID)#
	</cfoutput>
	</cfsavecontent>

	<cfreturn ret_logic_navMenu>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="logic_leftMenu">

	<cfsavecontent variable="ret_logic_displayleftMenu">
	<cfoutput>
		#this.display_tasks()#
		#this.display_messages()#
	</cfoutput>
	</cfsavecontent>

	<cfreturn ret_logic_displayleftMenu>
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="logic_addPost">
	<cfargument name="postID" type="numeric" default="0">
	<cfargument name="getNone" type="boolean" default="false">
	
	<cfset q_sql_GetPosts = this.sql_GetPosts(getNone=arguments.getnone,postID=arguments.postID)>
	<cfset q_topics = this.sql_getTopics()>
	<cfsavecontent variable="ret_logic_displayAddPost">
	<cfoutput>#this.display_addPost(topicList=q_topics,postData=q_sql_GetPosts)#</cfoutput>
	</cfsavecontent>

	<cfreturn ret_logic_displayAddPost>
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="logic_showSearch">

	<cfset q_topics = this.sql_getTopics()>
	<cfsavecontent variable="ret_logic_showSearch">
		<cfoutput>#this.display_showSearch(topicList=q_topics)#</cfoutput>
	</cfsavecontent>
	<cfreturn ret_logic_showSearch>
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="logic_logIn">

	<cfsavecontent variable="ret_logic_logIn">
		<cfoutput>#this.display_logIn()#</cfoutput>
	</cfsavecontent>
	<cfreturn ret_logic_logIn>
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="logic_displayReply">
<cfargument name="postID" type="numeric" default="0"> 
<cfargument name="replyID" type="numeric" default="0">

	<cfset lcl_reply = this.sql_getReplyInfo(replyID=arguments.replyID).reply>
	<cfif arguments.postID EQ 0>
		<cfset lcl_postID = this.sql_getReplyInfo(replyID=arguments.replyID).postID>
	<cfelse>
		<cfset lcl_postID = arguments.postID>
	</cfif>
	<cfsavecontent variable="ret_logic_displayReply">
		<cfoutput>#this.display_reply(replyID=arguments.replyID,postID=lcl_postID,reply=lcl_reply)#</cfoutput>
	</cfsavecontent>
	<cfreturn ret_logic_displayReply>
</cffunction>
<!--- End Function --->  

</cfcomponent>