<cfcomponent displayname="content_display.cfc" output="false">

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="showPosts">
	<cfargument name="postQuery" type="query" required="true">
	<cfargument name="userID" type="numeric" required="true">
	
	<cfset obj_content_sql = createObject("component","content_sql").init(dsn="braddoro")>
	<cfsavecontent variable="s_showPosts">
	<cfoutput>
		posts: #arguments.postQuery.recordCount#
		<cfloop query="arguments.postQuery">
			<cfset variables.post_userID = arguments.postQuery.userID>
			<fieldset>
			<legend title="<cfif description neq ''>#description#</cfif>"><strong>#dateformat(addedDate,"long")# #timeformat(addedDate,"hh:mm TT")# :: #title#</strong><br>posted by #siteName# to #topic#</legend>
			#post#
			<br>
			<cfif variables.post_userID EQ arguments.userID or arguments.userID eq 12>
				<a id="editPost_#postID#" name="editPost_#postID#" href="javascript:js_buildRequest('editPost','div_main',#postID#);">edit post</a>
			</cfif>
			<cfif arguments.userID GT 1>
				<a id="addReply_#postID#" name="addReply_#postID#" href="javascript:js_buildRequest('addReply','div_main',#postID#);">add reply</a>
			</cfif>
			
			<!--- BEGIN: move this --->
			<cfset q_getReplies = obj_content_sql.getReplies(postID=postID)>
			<cfif q_getReplies.recordCount GT 0>
			<br>
			<fieldset class="indented">
			<legend><strong>replies: #q_getReplies.recordCount#</strong></legend>
			<cfloop query="q_getReplies">
			<cfset variables.reply_userID = q_getReplies.userID>
			<strong>#dateformat(addedDate,"long")# #timeformat(addedDate,"hh:mm tt")#&nbsp;:: by #siteName#</strong><br>
			#reply#
			<br>
			<cfif variables.reply_userID EQ arguments.userID>
			<a id="editReply_#replyID#" name="editReply_#replyID#" href="javascript:js_buildRequest('editReply','div_main',#replyID#);">edit reply</a>
			</cfif>
			<cfif currentRow LT recordCount><hr></cfif>
			</cfloop>
			</fieldset>
			</cfif>
			<!--- END: move this --->
			
			</fieldset>
			<br>
		</cfloop>
	</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_showPosts>
</cffunction>
<!--- End Function  --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="showSearch">
<cfargument type="query" name="topicList" required="true">

	<cfset obj_utility_display = createObject("component","utility_display")>
	<cfsavecontent variable="s_showSearch">
		<cfoutput>
			<fieldset>
			<legend>search</legend>
			#obj_utility_display.queryDropdown(selectName="topicFilter",dataQuery=topicList)#&nbsp;<INPUT type="text" name="filter" id="filter" value="" size="20" maxlength="50">&nbsp;
			<input type="button" id="saveMe" name="saveMe" alt="search" value="search" title="search" class="navButtons" style="" onclick="js_buildRequest('getSearch', 'div_main',0);">
			</fieldset>
		</cfoutput>
	</cfsavecontent>
	<cfreturn s_showSearch>
</cffunction>
<!--- End Function --->

</cfcomponent>