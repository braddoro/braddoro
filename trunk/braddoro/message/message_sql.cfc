<cfcomponent output="false">

<!--- Begin Function --->
<cffunction name="init" displayname="init" access="package" output="false">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="getMessage">
	<cfargument name="messageID" type="numeric" default="0">
	
	<cfquery name="q_getMessage" datasource="#module_dsn#">
		SELECT M.messageID, M.to_userID, M.from_userID, M.sentDate, M.readDate, M.message FROM braddoro.dyn_messages M where messageID = #arguments.messageID#
	</cfquery>
	
	<cfreturn q_getMessage>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="getMessages_threaded">
	<cfargument name="userID" type="numeric" required="true">
	<cfargument name="threadID" type="numeric" default="0">
	
	<cfquery name="q_getMessages_threaded" datasource="#module_dsn#">
		SELECT M.messageID, M.to_userID, M.from_userID, U0.siteName AS 'from', U1.siteName AS 'to', M.sentDate, M.readDate, M.message
		FROM braddoro.dyn_messages M
		INNER JOIN braddoro.dyn_users U0 ON U0.userID = M.from_userID
		INNER JOIN braddoro.dyn_users U1 ON U1.userID = M.to_userID
		AND (M.to_userID = #arguments.userID# or M.from_userID = #arguments.userID#)
		AND threadID = #arguments.threadID#
		ORDER BY M.sentDate
		<cfif arguments.threadID EQ 0> DESC</cfif>
	</cfquery>
	
	<cfreturn q_getMessages_threaded>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="insertMessage">
	<cfargument name="from_userID" type="numeric" required="true">
	<cfargument name="to_userID" type="numeric" required="true">
	<cfargument name="threadID" type="numeric" required="true">
	<cfargument name="message" type="string" required="true">
	
	<cfquery name="q_insertMessage" datasource="#module_dsn#">
		insert into braddoro.dyn_messages (from_userID, to_userID, threadID, message)
		select #arguments.from_userID#, #arguments.to_userID#, #arguments.threadID#, '#arguments.message#' 
	</cfquery>
	
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="deleteMessage">
	<cfargument name="messageID" type="numeric" required="true">
	
	<cfquery name="q_deleteMessage" datasource="#module_dsn#">
		delete from braddoro.dyn_messages where messageID = #arguments.messageID#
	</cfquery>
	
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="getMessageCount">
	<cfargument name="userID" type="numeric" required="true">
	
	<cfquery name="q_getMessageCount" datasource="#module_dsn#">
		select count(*) as 'messageCount' from braddoro.dyn_messages where to_userID = #arguments.userID# and readDate is null
	</cfquery>
	
	<cfreturn q_getMessageCount>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="updateMessage">
	<cfargument name="messageID" type="numeric" required="true">
	
	<cfquery name="q_updateMessage" datasource="#module_dsn#">
    	update braddoro.dyn_messages set readDate = now() where messageID = #arguments.messageID#
	</cfquery>
	
</cffunction>
<!--- End Function --->

</cfcomponent>