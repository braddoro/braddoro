<cfcomponent>

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="sql_checkUser">
	<cfargument name="userGUID" type="string" default="">
	<cfargument name="userName" type="string" default="">
	<cfargument name="password" type="string" default="">
	<cfargument name="userID" type="numeric" default="0">
	<cfargument name="remoteIP" type="string" default="">
	
	<cfquery name="q_sql_checkUser" datasource="#module_dsn#">
	    select * from braddoro.dyn_Users where 
		active = 'Y'
	<cfif arguments.userID GT 0>
		and userID = #arguments.userID#
	</cfif>
	<cfif arguments.userGUID NEQ "">
		and userGUID = '#arguments.userGUID#'
	</cfif>
	<cfif arguments.userName NEQ "">
		and userName = '#arguments.userName#'
		and password = '#arguments.password#'
	</cfif>
	 </cfquery>
	 
	<cfquery name="q_insert" datasource="#module_dsn#">
		update braddoro.dyn_Users set lastVisit = now() where userID = #val(q_sql_checkUser.userID)# 
	</cfquery>
	<cfif userName NEQ "" and val(q_sql_checkUser.userID) LT 2>
	<cfquery name="q_insert2" datasource="#module_dsn#">
		insert into braddoro.log_loginHistory (remoteIP, userName) select '#arguments.remoteIP#', '#arguments.userName#' 
	</cfquery>
	</cfif>
	
	<cfreturn q_sql_checkUser>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="sql_insertUser">

  <cfquery name="q_sql_insertUser" datasource="#module_dsn#">
    insert into braddoro.dyn_Users 
	(userGUID, userName, realName, siteName, password, emailAddress, webSite)
	select '#createUUID#', '#arguments.realName#', '#arguments.siteName#', '#arguments.password#', '#arguments.emailAddress#', '#arguments.webSite#'
	select last_insert_id() as 'newID'
  </cfquery>

	<cfreturn ret_q_sql_insertUser>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="sql_getPosts">
	<cfargument name="numberToGet" type="Numeric" default="0">
	<cfargument name="topicID" type="numeric" default="0">
	<cfargument name="filterString" type="string" default="">
	<cfargument name="postID" type="numeric" default="0">
	<cfargument name="getNone" type="boolean" default="false">
	
	<cfquery name="q_sql_GetPosts" datasource="#module_dsn#">
		select  
		P.postID,
		T.topicID,
		T.topic,
		T.description,
		P.userID, 
		U.siteName,
		P.title, 
		P.post, 
		P.addedDate
		from braddoro.dyn_posts P
		inner join braddoro.dyn_users U
		on U.userID = P.userID
		inner join braddoro.cfg_topics T
		on T.topicID = P.topicID
		where P.active = 'Y'
	<cfif arguments.getNone>
		and 0=1
	</cfif>		
	<cfif arguments.postID GT 0>
		and P.postID = #arguments.postID#
	</cfif>
	<cfif arguments.topicID GT 0>
		and T.topicID = #arguments.topicID#
	</cfif>
	<cfif arguments.filterString GT "">
		and P.post like '%#arguments.filterString#%'
	</cfif>
		order by P.addedDate desc
	<cfif arguments.numberToGet GT 0>
		limit #arguments.numberToGet#
	</cfif>
	</cfquery>
<!--- 
		select UserName, UserID, TimesVisited, PostID, TopicID, Topic, Title, Post,
		PO.AddedDate as 'PostDate',
		max(isnull(RE.AddedDate,getdate()+#arguments.DaysBack#)) as 'ReplyDate',
		count(RE.PostID_fk) as 'Replies'
		from dyn_Posts PO
		left join dyn_Replies RE on PO.PostID = RE.PostID_fk and RE.Active = 'Y'
		inner join cfg_Topics on TopicID = PO.TopicID_fk
		inner join dyn_Users US on US.UserID = PO.UserID_fk
		where PO.AddedDate <= getdate() and PO.AddedDate > getdate()-#arguments.DaysBack# and PO.Active = 'Y'
		group by
		UserName, UserID, TimesVisited, PostID, TopicID, Topic, Title, Post, PO.AddedDate
		order by PO.AddedDate desc

 --->
  <cfreturn q_sql_GetPosts>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="sql_getReplies">
	<cfargument type="numeric" name="postID" required="true">
	
	<cfquery name="q_sql_getReplies" datasource="#module_dsn#">
		SELECT 
		R.replyID, 
		R.reply, 
		R.userID,
		R.addedDate, 
		U.siteName
		FROM braddoro.dyn_replies R
		inner join braddoro.dyn_users U
		on U.userID = R.userID
		and R.active = 'Y' 
		and R.postID = #arguments.postID#
		order by R.addedDate
	</cfquery>
  <cfreturn q_sql_getReplies>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="sql_getTopics">
	<cfquery name="q_sql_getTopics" datasource="#module_dsn#">
		select topicID, topic from braddoro.cfg_topics where active = 'Y' order by topic 	
	</cfquery>

  <cfreturn q_sql_getTopics>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="sql_insertPost">
	<cfargument type="Numeric" name="userID" required="true">
	<cfargument type="Numeric" name="topicID" required="true">
	<cfargument type="string" name="title" required="true">
	<cfargument type="string" name="post" required="true">
	
	<cfquery name="q_sql_insertPost" datasource="#module_dsn#">
		insert into braddoro.dyn_posts (userID, topicID, title, post)
		select #arguments.userID#, #arguments.topicID#, '#arguments.title#', '#arguments.post#'
	</cfquery>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="sql_updatePost">
	<cfargument type="Numeric" name="postID" required="true">
	<cfargument type="Numeric" name="userID" required="true">
	<cfargument type="Numeric" name="topicID" required="true">
	<cfargument type="string" name="title" default="">
	<cfargument type="string" name="post" default="">
	
	<cfquery name="q_sql_insertPost" datasource="#module_dsn#">
		update braddoro.dyn_posts set 
		userID = #arguments.userID#, 
		topicID = #arguments.topicID#, 
		title = '#arguments.title#', 
		post = '#arguments.post#'
		where postID = #arguments.postID#
	</cfquery>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="sql_getQuote">
	
	<cfquery name="q_sql_getQuote" datasource="#module_dsn#">
		select quote, quoteby, quoteWhen from braddoro.cfg_quotes where active = 'Y' order by rand() limit 1
	</cfquery>
	<cfreturn q_sql_getQuote>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="sql_insertReply">
<cfargument name="postID" type="Numeric" required="true">
<cfargument name="reply" type="string" required="true">
	
	<cfquery name="q_sql_insertReply" datasource="#module_dsn#">
		insert into braddoro.dyn_replies (postID, userID, reply)
		select #arguments.postID#, #variables.userID#, '#arguments.reply#'
	</cfquery>

</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="sql_updateReply">
<cfargument name="replyID" type="Numeric" required="true">
<cfargument name="reply" type="string" required="true">
	
	<cfquery name="q_sql_insertReply" datasource="#module_dsn#">
		update braddoro.dyn_replies set reply = '#arguments.reply#' where replyID = #arguments.replyID# 
	</cfquery>

</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="sql_getReplyInfo">
<cfargument name="replyID" type="Numeric" required="true">
	
	<cfquery name="q_sql_insertReply" datasource="#module_dsn#">
		select * from braddoro.dyn_replies where replyID = #arguments.replyID# 
	</cfquery>
	<cfreturn q_sql_insertReply>
</cffunction>
<!--- End Function --->

</cfcomponent>