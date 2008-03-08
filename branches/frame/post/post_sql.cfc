<cfcomponent output="false">

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="any" name="init">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="getPosts">
	<cfargument name="postID" type="numeric" default="0">
	<cfargument name="numberToGet" type="Numeric" default="0">
	<cfargument name="topicID" type="numeric" default="0">
	<cfargument name="filterString" type="string" default="">
	<cfargument name="getNone" type="boolean" default="false">

	<cfsavecontent variable="_sql">
	<cfoutput>
		select  
		P.postID,
		T.topicID,
		T.topic,
		T.description,
		P.userID, 
		U.siteName,
		P.title, 
		P.post, 
		P.addedDate,
		count(distinct R.postID) as 'replies'
		from braddoro.dyn_posts P
		inner join braddoro.dyn_users U
		on U.userID = P.userID
		inner join braddoro.cfg_topics T
		on T.topicID = P.topicID
		left join braddoro.dyn_replies R
		on P.postID = R.postID
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
	<cfif arguments.filterString NEQ "">
		and P.post like '%#arguments.filterString#%'
	</cfif>
		group by
		P.postID,
		T.topicID,
		T.topic,
		T.description,
		P.userID, 
		U.siteName,
		P.title, 
		P.post, 
		P.addedDate		
		order by P.addedDate desc
	<cfif arguments.numberToGet GT 0>
		limit #arguments.numberToGet#
	</cfif>
	</cfoutput>
	</cfsavecontent>
	<cfquery name="q_getPosts" datasource="#module_dsn#">#preserveSingleQuotes(_sql)#</cfquery>

	<!--- debug code --->	
	<!--- 
	<cfset obj_error = createObject("component","braddoro.error.error_logic").init(dsn=session.siteDsn)>
	<cfset myArray = arrayNew(1)>
	<cfoutput>#obj_error.fail(userID=val(session.userID),message="sql query",detail=_sql,type="debugging",tagContext=myArray,remoteIP=cgi.REMOTE_ADDR)#</cfoutput>
	 --->
	 
  <cfreturn q_getPosts>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="getReplies">
	<cfargument type="numeric" name="postID" required="true">
	
	<cfquery name="q_getReplies" datasource="#module_dsn#">
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
  <cfreturn q_getReplies>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="updatePost">
	<cfargument type="Numeric" name="postID" required="true">
	<cfargument type="Numeric" name="userID" required="true">
	<cfargument type="Numeric" name="topicID" required="true">
	<cfargument type="string" name="title" default="">
	<cfargument type="string" name="post" default="">
	
	<cfquery name="q_updatePost" datasource="#module_dsn#">
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
<cffunction access="package" output="false" returntype="void" name="insertPost">
	<cfargument type="numeric" name="userID" required="true">
	<cfargument type="numeric" name="topicID" required="true">
	<cfargument type="string" name="title" required="true">
	<cfargument type="string" name="post" required="true">
	
	<cfquery name="q_insertPost" datasource="#module_dsn#">
		insert into braddoro.dyn_posts (userID, topicID, title, post)
		select #arguments.userID#, #arguments.topicID#, '#arguments.title#', '#arguments.post#'
	</cfquery>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="getTopics">
	
	<cfquery name="q_getTopics" datasource="#module_dsn#">
		select topicID as 'value', topic as 'display' from braddoro.cfg_topics where active = 'Y' order by topic 	
	</cfquery>

  <cfreturn q_getTopics>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="getReplyInfo">
<cfargument name="replyID" type="Numeric" required="true">
	
	<cfquery name="q_getReplyInfo" datasource="#module_dsn#">
		select * from braddoro.dyn_replies where replyID = #arguments.replyID# 
	</cfquery>
	<cfreturn q_getReplyInfo>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="insertReply">
	<cfargument name="postID" type="Numeric" required="true">
	<cfargument name="reply" type="string" required="true">
	<cfargument name="userID" type="numeric" required="true">
	
	<cfquery name="q_insertReply" datasource="#module_dsn#">
		insert into braddoro.dyn_replies (postID, userID, reply)
		select #arguments.postID#, #arguments.userID#, '#arguments.reply#'
	</cfquery>

</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="updateReply">
<cfargument name="replyID" type="Numeric" required="true">
<cfargument name="reply" type="string" required="true">
	
	<cfquery name="q_updateReply" datasource="#module_dsn#">
		update braddoro.dyn_replies set reply = '#arguments.reply#' where replyID = #arguments.replyID# 
	</cfquery>

</cffunction>
<!--- End Function --->

</cfcomponent>