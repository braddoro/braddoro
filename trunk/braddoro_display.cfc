<cfcomponent extends="braddoro_logic">

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="display_posts">
<cfargument type="query" name="postQuery" required="true">

<cfsavecontent variable="ret_display_posts">
<cfoutput>
<cfloop query="arguments.postQuery">
<cfset variables.post_userID = arguments.postQuery.userID>
<fieldset>
<legend title="<cfif description neq ''>#description#</cfif>"><strong>#dateformat(addedDate,"long")# #timeformat(addedDate,"hh:mm TT")# :: #title#</strong><br>posted by #siteName# to #topic#</legend>
#post#
<br>
<cfif variables.post_userID EQ session.userID>
<a id="editPost_#postID#" name="editPost_#postID#" href="javascript:js_buildRequest('editPost','div_main',#postID#);">[edit post]</a>
</cfif>
<cfif session.userID GT 1>
<a id="addReply_#postID#" name="addReply_#postID#" href="javascript:js_buildRequest('addReply','div_main',#postID#);">[add reply]</a>
</cfif>
<!--- <input type="button" id="editPost_#postID#" name="editPost_#postID#" alt="edit post" value="edit post" title="edit post" class="navButtons" style="" onclick="js_buildRequest('editPost','div_main',#postID#);">
<input type="button" id="addReply_#postID#" name="addReply_#postID#" alt="add reply" value="add reply" title="add reply" class="navButtons" style="" onclick="js_buildRequest('addReply','div_main',#postID#);"> --->
<cfset q_sql_getReplies = this.sql_getReplies(postID=postID)>
<cfif q_sql_getReplies.recordCount GT 0>
<br>
<fieldset class="indented">
<legend><strong>replies: #q_sql_getReplies.recordCount#</strong></legend>
<cfloop query="q_sql_getReplies">
<cfset variables.reply_userID = q_sql_getReplies.userID>
<strong>#dateformat(addedDate,"long")# #timeformat(addedDate,"hh:mm tt")#&nbsp;:: by #siteName#</strong><br>
#reply#
<br>
<cfif variables.reply_userID EQ session.userID>
<a id="editReply_#replyID#" name="editReply_#replyID#" href="javascript:js_buildRequest('editReply','div_main',#replyID#);">[edit reply]</a>
<!--- <input type="button" id="editReply_#replyID#" name="editReply_#replyID#" alt="edit reply" value="edit reply" title="edit reply" class="navButtons" style="" onclick="js_buildRequest('editReply','div_main',#replyID#);"> --->
</cfif>
<cfif currentRow LT recordCount><hr></cfif>
</cfloop>
</fieldset>
</cfif>
</fieldset>
<br>
</cfloop>
</cfoutput>
</cfsavecontent>
<cfreturn ret_display_posts>

</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="display_navMenu">

<cfsavecontent variable="ret_display_navMenu">
	<cfoutput>
	<cfif variables.userID LT 2>
	<input type="button" id="logIn" name="logIn" alt="log in" value="log in" title="log in" class="navButtons" style="" onclick="js_buildRequest(this.id,'div_main',0);">
	</cfif>
	<input type="button" id="showPost" name="showPost" alt="show posts" value="show posts" title="show posts" class="navButtons" style="" onclick="js_buildRequest(this.id,'div_main',0);">
	<input type="button" id="searchPost" name="searchPost" alt="search posts" value="search posts" title="search posts" class="navButtons" style="" onclick="js_buildRequest(this.id,'div_main',0);">	
	<cfif variables.userID GT 1>
	<input type="button" id="composePost" name="composePost" alt="show posts" value="compose post" title="compose post" class="navButtons" style="" onclick="js_buildRequest(this.id,'div_main',0);">
	<input type="button" id="showMessages" name="showMessages" alt="messages" value="messages" title="messages" class="navButtons" style="" onclick="js_buildRequest(this.id,'div_main',0);">
	</cfif>
	</cfoutput>
</cfsavecontent>
<cfreturn ret_display_navMenu>

</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="display_queryDropdown">
<cfargument name="selectName" type="string" default="topicID">
<cfargument name="dataQuery" type="query" required="true">
<cfargument name="currentID" type="numeric" default="0">

	<cfsavecontent variable="ret_display_queryDropdown">
		<cfoutput>
			<SELECT name="#arguments.selectName#" id="#arguments.selectName#">
			<option value="0"<cfif arguments.currentID EQ 0> SELECTED</cfif></option>
			<cfloop query="arguments.dataQuery">
				<option value="#value#"<cfif val(value) EQ val(arguments.currentID)> SELECTED</cfif>>#display#</option>
			</cfloop>
			</SELECT>
		</cfoutput>
	</cfsavecontent>

	<cfreturn ret_display_queryDropdown>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="display_addPost">
<cfargument type="query" name="topicList" required="true">
<cfargument type="query" name="postData" required="true">

<cfif arguments.postData.recordCount GT 0>
	<cfset lcl_postID = arguments.postData.postID>
	<cfset lcl_topicID = arguments.postData.topicID>
	<cfset lcl_title = arguments.postData.title>
	<cfset lcl_post = arguments.postData.post>
	<cfset lcl_displayWord = "update post">
	<cfset lcl_task = "updatePost">
<cfelse>
	<cfset lcl_postID = 0>
	<cfset lcl_topicID = 0>
	<cfset lcl_title = "">
	<cfset lcl_post = "">
	<cfset lcl_displayWord = "compose post">
	<cfset lcl_task = "addPost">
</cfif>
<cfsavecontent variable="ret_display_addPost">
	<cfoutput>
		<fieldset>
		<legend>#lcl_displayWord#</legend>
			<table class="tablenormal">
				<TR>
					<TD>#this.display_queryDropdown(
							selectName="topicID",
							dataQuery=arguments.topicList,
							currentID=lcl_topicID
							)#</TD>
				</TR>
				<TR>
					<TD><INPUT type="text" name="subject" id="subject" value="#lcl_title#" size="80" maxlength="200"></TD>
				</TR>
				<TR>
					<TD><textarea id="post" id="post" cols="80" rows="15">#lcl_post#</textarea></TD>
				</TR>
				<TR>
					<TD>
					<cfif variables.userID GT 1>
						<input type="button" id="saveMe" name="saveMe" alt="save" value="save" title="#lcl_displayWord#" class="navButtons" style="" onclick="js_buildRequest('#lcl_task#','div_main',#lcl_postID#);">
					</cfif>
					</TD>
				</TR>
			</table>
		</fieldset>
		<br>
	</cfoutput>
</cfsavecontent>

<cfreturn ret_display_addPost>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="display_showSearch">
<cfargument type="query" name="topicList" required="true">

	<cfsavecontent variable="ret_display_showSearch">
		<cfoutput>
			<fieldset>
			<legend>search</legend>
			#this.display_queryDropdown(
				selectName="topicFilter",
				dataQuery=topicList)#&nbsp;<INPUT type="text" name="filter" id="filter" value="" size="20" maxlength="50">&nbsp;
			<input type="button" id="saveMe" name="saveMe" alt="search" value="search" title="search" class="navButtons" style="" onclick="js_buildRequest('getSearch', 'div_main',0);">
			</fieldset>
		</cfoutput>
	</cfsavecontent>
	<cfreturn ret_display_showSearch>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="display_login">

<cfsavecontent variable="ret_display_navMenu">
	<cfoutput>
	<fieldset>
	<legend>log in</legend>
	<input type="text" id="username" name="username" value="" class="navButtons" style="">
	<input type="password" id="password" name="password" value="" class="navButtons" style="">
	<input type="button" id="authenticateUser" name="authenticateUser" alt="log in" value="log in" title="log in" class="navButtons" onclick="js_buildRequest('authenticateUser','div_main',0);js_buildRequest('showBanner','div_banner',0);">
	</fieldset>
	</cfoutput>
</cfsavecontent>
<cfreturn ret_display_navMenu>

</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="display_showBanner">
<cfargument type="string" name="siteName" default="">

	<cfsavecontent variable="ret_display_userLoggedStatus">
		<cfoutput>#this.logic_GetConstant("siteBanner")#<cfif arguments.siteName NEQ ""><span class="mediumtext"> - #arguments.siteName#</span></cfif></cfoutput>
	</cfsavecontent>
	<cfreturn ret_display_userLoggedStatus>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="display_reply">
	<cfargument name="postID" type="numeric" default="0">
	<cfargument name="replyID" type="numeric" default="0">
	<cfargument name="reply" type="string" default="">
	<cfif arguments.replyID EQ 0>
		<cfset lcl_task="saveReply">
	<cfelse>
		<cfset lcl_task="updateReply">
	</cfif>
	<cfsavecontent variable="ret_display_reply">
		<cfoutput>
		<input type="hidden" id="postReplyID_#arguments.PostID#" value="#arguments.replyID#">
		<textarea id="replytext_#arguments.PostID#" name="replytext_#arguments.PostID#" cols="80" rows="20">#arguments.reply#</textarea>
		<br>
		<input type="button" id="saveReply_#arguments.PostID#" name="saveReply_#arguments.PostID#" alt="save reply" value="save reply" title="save reply" class="navButtons" style="" onclick="js_buildRequest('#lcl_task#','div_main',#arguments.postID#);">
		</cfoutput>
	</cfsavecontent>
	<cfreturn ret_display_reply>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="display_messageMain">
<cfargument name="userID" type="numeric" required="true">
<cfargument name="messageQuery" type="query" required="true">
<cfargument name="userQuery" type="query" required="true">

<cfsavecontent variable="ret_display_messageMain">
	<cfoutput>
		#this.display_messageInput(userID=arguments.userID,userQuery=arguments.userQuery)#
		<br>
		<div id="div_messages">#this.display_messageOutput(messageQuery=arguments.messageQuery)#</div>
	</cfoutput>
</cfsavecontent>
<cfreturn ret_display_messageMain>

</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="display_messageInput">
<cfargument name="userID" type="numeric" required="true">
<cfargument name="userQuery" type="query" required="true">
<cfsavecontent variable="ret_display_messageInput">
	<cfoutput>
	<fieldset>
	<legend>write message</legend>
		#this.display_queryDropdown(selectName="message_userID",dataQuery=arguments.userQuery)#<br>
		<textarea id="messageText" name="messageText" class="navButtons" rows="10" cols="80"></textarea><br>
		<input type="button" id="saveMessage" name="saveMessage" value="save" class="navButtons" onclick="js_buildRequest(this.id,'div_messages',0);">
	</fieldset>
	</cfoutput>
</cfsavecontent>
<cfreturn ret_display_messageInput>

</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="display_messageOutput">
<cfargument name="messageQuery" type="query" required="true">

<!--- #messageID# #from_userID# #dateFormat(readDate,"long")# --->
<cfsavecontent variable="ret_display_messageOutput">
	<cfoutput>
	<fieldset>
	<legend>messages</legend>
	<cfif arguments.messageQuery.recordCount GT 0>
	<cfloop query="arguments.messageQuery">
		<strong>from: #siteName# on #dateFormat(sentDate,"long")#</strong><br>
		#message#<br>
		<cfif currentRow LT recordCount><hr size="1"></cfif>
	</cfloop>
	</fieldset>
	<cfelse>
		no messages
	</cfif>
	</cfoutput>
</cfsavecontent>
<cfreturn ret_display_messageOutput>

</cffunction>
<!--- End Function --->

</cfcomponent>