<cfcomponent output="false">
	
<!--- Begin Function  --->
<cffunction name="init" displayname="init" access="package" output="false">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="showMessages">
	<cfargument name="userID" type="numeric" required="true">

	<cfset obj_user_sql = createObject("component","user_sql").init(dsn=module_dsn)>
	<cfset q_getUsers = obj_user_sql.getUsers()>
	<cfset obj_message_sql = createObject("component","message_sql").init(dsn=module_dsn)>
	<cfset q_getMessages = obj_message_sql.getMessages(userID=arguments.userID)>
	<cfset obj_message_display = createObject("component","message_display")>
	<cfsavecontent variable="s_showMessages">
		<cfoutput>
			#obj_message_display.messageMain(userID=arguments.userID,messageQuery=q_getMessages,userQuery=q_getUsers)#
		</cfoutput>
	</cfsavecontent>
	<cfreturn s_showMessages>
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="void" name="saveMessage">
	<cfargument name="from_userID" type="numeric" required="true">
	<cfargument name="to_userID" type="numeric" required="true">
	<cfargument name="messageText" type="string" required="true">

	<cfset obj_message_sql = createObject("component","message_sql").init(dsn=module_dsn)>
	<cfset x = obj_message_sql.insertMessage(from_userID=arguments.from_userID,to_userID=arguments.to_userID,message=form.messageText)>

</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="void" name="deleteMessage">
	<cfargument name="messageID" type="numeric" required="true">

	<cfset obj_message_sql = createObject("component","message_sql").init(dsn=module_dsn)>
	<cfset x = obj_message_sql.deleteMessage(messageID=arguments.messageID)>

</cffunction>
<!--- End Function --->  

</cfcomponent>