<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction name="init" displayname="init" access="public" output="false">
	<cfargument required="true" type="string" name="dsn">
	<cfargument required="true" type="numeric" name="userID">
	<cfargument default="20" type="numeric" name="postsToShow">
	
	<cfset module_dsn = arguments.dsn>
	<cfset module_userID = arguments.userID>
	<cfset module_postsToShow = arguments.postsToShow>
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="public" output="false" returntype="string" name="javascriptTask">
	
	<cfsavecontent variable="s_javascript">
		<cfoutput>
<script type="text/javascript" src="/braddoro/post/post.js"></script>
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_javascript>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="string" name="ajaxTask">
	<cfargument required="true" type="string" name="task">
	
	<cfsavecontent variable="s_ajaxTask">
		<cfoutput>
			<cfif arguments.task EQ "searchPost">#this.showSearch()#</cfif>
			<cfif arguments.task EQ "getSearch">#this.getSearch(postID=val(arguments.postID),topicID=val(arguments.topicID),filterString=arguments.Filter,showCount="Yes")#</cfif>
			<cfif arguments.task EQ "showPost">#this.displayPosts()#</cfif>
			<cfif arguments.task EQ "composePost">#this.postInput(getNone=true)#</cfif>
			<cfif arguments.task EQ "addPost">#this.postUpdate(userID=module_userID,topicID=val(arguments.TopicID),title=arguments.Subject,post=arguments.post)#</cfif>
			<cfif arguments.task EQ "editPost">#this.postInput(postID=val(arguments.itemID))#</cfif>
			<cfif arguments.task EQ "updatePost">#this.postUpdate(postID=val(arguments.itemID),userID=module_userID,topicID=arguments.TopicID,title=arguments.Subject,post=arguments.Post)#</cfif>
			<cfif arguments.task EQ "addReply">#this.replyInput(postID=val(arguments.itemID))#</cfif>
			<cfif arguments.task EQ "editReply">#this.replyInput(replyID=val(arguments.itemID))#</cfif>
			<cfif arguments.task EQ "saveReply">#this.saveReply(reply=arguments.replyText,postID=val(arguments.itemID))#</cfif>
			<cfif arguments.task EQ "updateReply">#this.saveReply(reply=arguments.replyText,replyID=val(arguments.replyID))#</cfif>
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_ajaxTask>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="displayPosts">
	<cfargument name="showCount" type="string" default="No">

	<cfset obj_post_sql = createObject("component","post_sql").init(dsn=module_dsn)>
	<cfset q_getPosts = obj_post_sql.getPosts(numberToGet=module_postsToShow)>
	<cfset obj_post_display = createObject("component","post_display")>	
	<cfsavecontent variable="s_displayPosts">
	<cfoutput>#obj_post_display.showPosts(postQuery=q_getPosts,userID=module_userID,showCount=arguments.showCount)#</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_displayPosts>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="showSearch">

	<cfset obj_post_sql = createObject("component","post_sql").init(dsn=module_dsn)>
	<cfset q_topics = obj_post_sql.getTopics()>
	<cfset obj_post_display = createObject("component","post_display")>
	<cfsavecontent variable="s_showSearch">
	<cfoutput>#obj_post_display.showSearch(topicList=q_topics)#</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_showSearch>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="getSearch">
	<cfargument name="topicID" type="numeric" default="0">
	<cfargument name="filterString" type="string" default="">
	<cfargument name="postID" type="numeric" default="0">

	<cfset obj_post_sql = createObject("component","post_sql").init(dsn=module_dsn)>
	<cfset q_getPosts = obj_post_sql.getPosts(topicID=arguments.topicID,filterString=arguments.filterString,postID=arguments.postID)>
	<cfset q_topics = obj_post_sql.getTopics()>
	<cfset obj_post_display = createObject("component","post_display")>
	<cfsavecontent variable="s_getSearch">
	<cfoutput>
	#obj_post_display.showSearch(topicList=q_topics,search_topicID=arguments.topicID,searchString=arguments.filterString,postID=arguments.postID)#
	#obj_post_display.showPosts(postQuery=q_getPosts,userID=module_userID)#
	</cfoutput>
	</cfsavecontent>
	<cfreturn s_getSearch>	
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="postInput">
	<cfargument name="postID" type="numeric" default="0">
	<cfargument name="getNone" type="boolean" default="false">

	<cfset obj_post_sql = createObject("component","post_sql").init(dsn=module_dsn)>
	<cfset q_getPosts = obj_post_sql.getPosts(getNone=arguments.getnone,postID=arguments.postID)>
	<cfset q_topics = obj_post_sql.getTopics()>
	<!--- Loop over the recordset and put the values into an array and pass the array downhill. --->
	<cfset obj_post_display = createObject("component","post_display")>
	<cfsavecontent variable="s_postInput">
	<cfoutput>#obj_post_display.showPostInput(topicList=q_topics,postData=q_getPosts,userID=module_userID)#</cfoutput>
	</cfsavecontent>

	<cfreturn s_postInput>
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="postUpdate">
	<cfargument name="getNone" type="boolean" default="false">
	<cfargument name="postID" type="Numeric" default="0">
	<cfargument name="userID" type="Numeric" default="0">
	<cfargument name="topicID" type="Numeric" default="0">
	<cfargument name="title" type="string" default="">
	<cfargument name="post" type="string" default="">

	<cfset obj_post_sql = createObject("component","post_sql").init(dsn=module_dsn)>
	<cfif arguments.postID GT 0>
		<cfset q_insertPost = obj_post_sql.updatePost(argumentCollection=arguments)>
	<cfelse>
		<cfset q_insertPost = obj_post_sql.insertPost(argumentCollection=arguments)>
	</cfif>
	<cfsavecontent variable="s_postUpdate">
		<cfoutput>#this.displayPosts()#</cfoutput>
	</cfsavecontent>

	<cfreturn s_postUpdate>
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="replyInput">
	<cfargument name="postID" type="numeric" default="0"> 
	<cfargument name="replyID" type="numeric" default="0">

	<cfset obj_post_sql = createObject("component","post_sql").init(dsn=module_dsn)>
	<cfset lcl_reply = obj_post_sql.getReplyInfo(replyID=arguments.replyID).reply>
	<cfif arguments.postID EQ 0>
		<cfset lcl_postID = obj_post_sql.getReplyInfo(replyID=arguments.replyID).postID>
	<cfelse>
		<cfset lcl_postID = arguments.postID>
	</cfif>
	<cfset obj_post_display = createObject("component","post_display")>
	<cfsavecontent variable="s_replyInput">
		<cfoutput>#obj_post_display.showReplyInput(replyID=arguments.replyID,postID=lcl_postID,reply=lcl_reply)#</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_replyInput>
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="saveReply">
	<cfargument name="postID" type="numeric" default="0"> 
	<cfargument name="replyID" type="numeric" default="0">
	<cfargument name="reply" type="string" default="">

	<cfset obj_post_sql = createObject("component","post_sql").init(dsn=module_dsn)>
	<cfif arguments.postID GT 0>
		<cfset x = obj_post_sql.insertReply(userID=module_userID,postID=arguments.postID,reply=arguments.reply)>
	<cfelse>
		<cfset x = obj_post_sql.updateReply(replyID=arguments.replyID,reply=arguments.reply)>
	</cfif>
	<cfsavecontent variable="s_saveReply">
		<cfoutput>#this.displayPosts()#</cfoutput>
	</cfsavecontent>

	<cfreturn s_saveReply>
</cffunction>
<!--- End Function --->  

</cfcomponent>