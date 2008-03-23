<cfcomponent output="false">

<!--- Begin Function --->
<cffunction name="init" displayname="init" access="package" output="false">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="getMessages">
	<cfargument name="userID" type="numeric" required="true">
	
	<cfquery name="q_getMessages" datasource="#module_dsn#">
		SELECT M.messageID, M.to_userID, M.from_userID, U0.siteName AS 'from', U1.siteName AS 'to', M.sentDate, M.readDate, M.message
		FROM braddoro.dyn_messages M
		INNER JOIN braddoro.dyn_users U0 ON U0.userID = M.from_userID
		INNER JOIN braddoro.dyn_users U1 ON U1.userID = M.to_userID
		AND (M.to_userID = #arguments.userID# OR M.from_userID = #arguments.userID#)
		ORDER BY M.sentDate DESC 
	</cfquery>
	
	<cfreturn q_getMessages>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="insertMessage">
	<cfargument name="from_userID" type="numeric" required="true">
	<cfargument name="to_userID" type="numeric" required="true">
	<cfargument name="message" type="string" required="true">
	
	<cfquery name="q_insertMessage" datasource="#module_dsn#">
		insert into braddoro.dyn_messages (from_userID, to_userID, message)
		select #arguments.from_userID#, #arguments.to_userID#, '#arguments.message#' 
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
		select count(*) as 'messageCount' from braddoro.dyn_messages where to_userID = #arguments.userID#
	</cfquery>
	
	<cfreturn q_getMessageCount>
</cffunction>
<!--- End Function --->

</cfcomponent>