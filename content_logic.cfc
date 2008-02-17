<cfcomponent output="false">

<cfproperty name="module_dsn" displayname="module_dsn" type="string" default="">

<!--- Begin Function  --->
<cffunction name="init" displayname="init" access="package" output="false">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="displayPosts">
	<cfargument name="numberToGet" type="numeric" required="true">
	<cfargument name="userID" type="numeric" required="true">
	<cfargument name="showCount" type="string" default="No">

	<cfset obj_content_sql = createObject("component","content_sql").init(dsn=module_dsn)>
	<cfset q_getPosts = obj_content_sql.getPosts(numberToGet=arguments.numberToGet)>
	<cfset obj_content_display = createObject("component","content_display")>	
	<cfsavecontent variable="s_displayPosts">
	<cfoutput>#obj_content_display.showPosts(postQuery=q_getPosts,userID=arguments.userID,showCount=arguments.showCount)#</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_displayPosts>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="showSearch">

	<cfset obj_content_sql = createObject("component","content_sql").init(dsn=module_dsn)>
	<cfset q_topics = obj_content_sql.getTopics()>
	<cfset obj_content_display = createObject("component","content_display")>
	<cfsavecontent variable="s_showSearch">
	<cfoutput>#obj_content_display.showSearch(topicList=q_topics)#</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_showSearch>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="getSearch">
	<cfargument name="topicID" type="numeric" default="0">
	<cfargument name="filterString" type="string" default="">
	<cfargument name="userID" type="numeric" required="true">

	<cfset obj_content_sql = createObject("component","content_sql").init(dsn=module_dsn)>
	<cfset q_getPosts = obj_content_sql.getPosts(topicID=arguments.topicID,filterString=arguments.filterString)>
	<cfset q_topics = obj_content_sql.getTopics()>
	<cfset obj_content_display = createObject("component","content_display")>
	<cfsavecontent variable="s_getSearch">
	<cfoutput>
	#obj_content_display.showSearch(topicList=q_topics,search_topicID=arguments.topicID,searchString=arguments.filterString)#
	#obj_content_display.showPosts(postQuery=q_getPosts,userID=arguments.userID)#
	</cfoutput>
	</cfsavecontent>
	<cfreturn s_getSearch>	
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="postInput">
	<cfargument name="postID" type="numeric" default="0">
	<cfargument name="getNone" type="boolean" default="false">
	<cfargument name="userID" type="numeric" required="true">

	<cfset obj_content_sql = createObject("component","content_sql").init(dsn=module_dsn)>
	<cfset q_getPosts = obj_content_sql.getPosts(getNone=arguments.getnone,postID=arguments.postID)>
	<cfset q_topics = obj_content_sql.getTopics()>
	<!--- Loop over the recordset and put the values into an array and pass the array downhill. --->
	<cfset obj_content_display = createObject("component","content_display")>
	<cfsavecontent variable="s_postInput">
	<cfoutput>#obj_content_display.showPostInput(topicList=q_topics,postData=q_getPosts,userID=arguments.userID)#</cfoutput>
	</cfsavecontent>

	<cfreturn s_postInput>
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="void" name="postUpdate">
	<cfargument name="getNone" type="boolean" default="false">
	<cfargument name="postID" type="Numeric" default="0">
	<cfargument name="userID" type="Numeric" default="0">
	<cfargument name="topicID" type="Numeric" default="0">
	<cfargument name="title" type="string" default="">
	<cfargument name="post" type="string" default="">

	<cfset obj_content_sql = createObject("component","content_sql").init(dsn=module_dsn)>
	<cfif arguments.postID GT 0>
		<cfset q_insertPost = obj_content_sql.updatePost(argumentCollection=arguments)>
	<cfelse>
		<cfset q_insertPost = obj_content_sql.insertPost(argumentCollection=arguments)>
	</cfif>
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="replyInput">
	<cfargument name="postID" type="numeric" default="0"> 
	<cfargument name="replyID" type="numeric" default="0">

	<cfset obj_content_sql = createObject("component","content_sql").init(dsn=module_dsn)>
	<cfset lcl_reply = obj_content_sql.getReplyInfo(replyID=arguments.replyID).reply>
	<cfif arguments.postID EQ 0>
		<cfset lcl_postID = obj_content_sql.getReplyInfo(replyID=arguments.replyID).postID>
	<cfelse>
		<cfset lcl_postID = arguments.postID>
	</cfif>
	<cfset obj_content_display = createObject("component","content_display")>
	<cfsavecontent variable="s_replyInput">
		<cfoutput>#obj_content_display.showReplyInput(replyID=arguments.replyID,postID=lcl_postID,reply=lcl_reply)#</cfoutput>
	</cfsavecontent>
	<cfreturn s_replyInput>
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="void" name="saveReply">
	<cfargument name="postID" type="numeric" default="0"> 
	<cfargument name="replyID" type="numeric" default="0">
	<cfargument name="reply" type="string" default="">
	<cfargument name="userID" type="numeric" required="true">

	<cfset obj_content_sql = createObject("component","content_sql").init(dsn=module_dsn)>
	<cfif arguments.postID GT 0>
		<cfset x = obj_content_sql.insertReply(userID=arguments.userID,postID=arguments.postID,reply=arguments.reply)>
	<cfelse>
		<cfset x = obj_content_sql.updateReply(replyID=arguments.replyID,reply=arguments.reply)>
	</cfif>

</cffunction>
<!--- End Function --->  

</cfcomponent>