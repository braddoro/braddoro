<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction name="init" displayname="init" access="package" output="false">
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<!--- this function needs work --->
<cffunction access="package" output="false" returntype="String" name="showPosts">
	<cfargument name="postQuery" type="query" required="true">
	<cfargument name="userID" type="numeric" required="true">
	<cfargument name="showCount" type="string" default="No">
	
	<cfset obj_post_sql = createObject("component","post_sql").init(dsn="braddoro")>
	<cfsavecontent variable="s_showPosts">
	<cfoutput>
		<cfif arguments.showCount EQ "Yes">posts: #arguments.postQuery.recordCount#</cfif>
		<cfloop query="arguments.postQuery">
			<cfset variables.post_userID = arguments.postQuery.userID>
			<fieldset>
			<legend 
					id="legend_post#postID#" 
					onmouseover="js_changeBG(this.id,'##AB9448');" 
					onmouseout="js_changeBG(this.id,'##E7E7E7');" 
					onclick="js_collapseThis('div_post#postID#');" 
					style="cursor:default;" title="<cfif description neq ''>#description#</cfif>">
					<strong>#dateformat(addedDate,"long")# #timeformat(addedDate,"hh:mm TT")# :: #title#</strong><br>posted by #siteName# to #topic#
			</legend>
			<div id="div_post#postID#" style="display:block;">
			#post#
			<br>
			<cfif variables.post_userID EQ arguments.userID or arguments.userID eq 12>
				<a id="editPost_#postID#" name="editPost_#postID#" href="javascript:js_buildRequest('editPost','div_main',#postID#);">edit post</a>
			</cfif>
			<cfif arguments.userID GT 1>
				<a id="addReply_#postID#" name="addReply_#postID#" href="javascript:js_buildRequest('addReply','div_main',#postID#);">add reply</a>
			</cfif>
			
			<!--- BEGIN: move this --->
			<cfset q_getReplies = obj_post_sql.getReplies(postID=postID)>
			<cfif q_getReplies.recordCount GT 0>
			<br>
			<fieldset class="indented">
			<legend><strong>replies: #q_getReplies.recordCount#</strong></legend>
			<cfloop query="q_getReplies">
			<cfset variables.reply_userID = q_getReplies.userID>
			<strong>#dateformat(addedDate,"long")# #timeformat(addedDate,"hh:mm tt")# by #siteName#</strong><br>
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
			</div>
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
	<cfargument name="search_topicID" type="numeric" default="0">
	<cfargument name="searchString" type="string" default="">

	<cfset obj_utility_display = createObject("component","utility_display")>
	<cfsavecontent variable="s_showSearch">
		<cfoutput>
			<fieldset>
			<legend>search</legend>
			#obj_utility_display.queryDropdown(selectName="topicFilter",dataQuery=topicList,currentID=arguments.search_topicID)#&nbsp;<INPUT type="text" name="filter" id="filter" value="#arguments.searchString#" size="20" maxlength="50">&nbsp;
			<input type="button" id="saveMe" name="saveMe" alt="search" value="search" title="search" class="navButtons" style="" onclick="js_buildRequest('getSearch', 'div_main',0);">
			</fieldset>
		</cfoutput>
	</cfsavecontent>
	<cfreturn s_showSearch>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<!--- this function needs work --->
<cffunction access="package" output="false" returntype="string" name="showPostInput">
<cfargument name="topicList" type="query" required="true">
<cfargument name="postData" type="query" required="true">
<cfargument name="userID" type="numeric" default="0">

<!--- move this --->
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
<!--- 
<cfif isdefined("arguments.postData.columnList")>
	<cfloop list="#arguments.postData.columnList#" index="c">
		<cfset "lcl_#c#"=arguments.postData[c][1]>
	</cfloop>
</cfif> 
--->
<!--- move this --->

<cfset obj_utility_display = createObject("component","utility_display")>
<cfsavecontent variable="s_showPostInput">
	<cfoutput>
		<fieldset>
		<legend>#lcl_displayWord#</legend>
			<table class="tablenormal">
				<TR>
					<TD>
						#obj_utility_display.queryDropdown(selectName="topicID",dataQuery=arguments.topicList,currentID=lcl_topicID)#
					</TD>
				</TR>
				<TR>
					<TD><INPUT type="text" name="subject" id="subject" value="#lcl_title#" size="80" maxlength="200"></TD>
				</TR>
				<TR>
					<TD><textarea id="post" id="post" cols="80" rows="15">#lcl_post#</textarea></TD>
				</TR>
				<TR>
					<TD>
					<cfif arguments.userID GT 1>
						<input type="button" id="saveMe" name="saveMe" alt="save" value="save" title="#lcl_displayWord#" class="navButtons" style="" onclick="js_buildRequest('#lcl_task#','div_main',#lcl_postID#);">
					</cfif>
					</TD>
				</TR>
			</table>
		</fieldset>
		<br>
	</cfoutput>
</cfsavecontent>

<cfreturn s_showPostInput>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="showReplyInput">
	<cfargument name="postID" type="numeric" default="0">
	<cfargument name="replyID" type="numeric" default="0">
	<cfargument name="reply" type="string" default="">
	
	<cfif arguments.replyID EQ 0>
		<cfset lcl_task="saveReply">
	<cfelse>
		<cfset lcl_task="updateReply">
	</cfif>
	<cfsavecontent variable="s_showReplyInput">
		<cfoutput>
		<input type="hidden" id="postReplyID_#arguments.PostID#" value="#arguments.replyID#">
		<textarea id="replytext_#arguments.PostID#" name="replytext_#arguments.PostID#" cols="80" rows="20">#arguments.reply#</textarea>
		<br>
		<input type="button" id="saveReply_#arguments.PostID#" name="saveReply_#arguments.PostID#" alt="save reply" value="save reply" title="save reply" class="navButtons" style="" onclick="js_buildRequest('#lcl_task#','div_main',#arguments.postID#);">
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_showReplyInput>
</cffunction>
<!--- End Function --->

</cfcomponent>