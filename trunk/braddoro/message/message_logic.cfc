<cfcomponent output="false">
	
<!--- Begin Function  --->
<cffunction access="public" name="init" output="false">
	<cfargument required="true" type="string" name="dsn">
	<cfargument required="true" type="numeric" name="userID">
		
	<cfset module_dsn = arguments.dsn>
	<cfset module_userID = arguments.userID>
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="public" output="false" returntype="string" name="javascriptTask">
	
	<cfsavecontent variable="s_javascript">
		<cfoutput>
<script type="text/javascript" src="/braddoro/message/message.js"></script>
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_javascript>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="string" name="ajaxTask">
	<cfargument required="true" type="string" name="task">
	
	<cfset obj_message_sql = createObject("component","message_sql").init(dsn=module_dsn)>
	<cfsavecontent variable="s_ajaxTask">
		<cfoutput>
			<cfif arguments.task EQ "saveMessage"><cfset this.saveMessage(to_userID=val(arguments.message_userID),threadID=arguments.threadID,messageText=arguments.messageText)></cfif>
			<cfif arguments.task EQ "deleteMessage"><cfset this.deleteMessage(messageID=val(arguments.itemID))></cfif>
			<cfif arguments.task EQ "markMessage"><cfset this.updateMessage(messageID=val(arguments.itemID))></cfif>
			<cfif arguments.task NEQ "replyTo">
				#this.showMessages()#
			</cfif>
		</cfoutput>
	</cfsavecontent>
	<cfif arguments.task EQ "replyTo"><cfset s_ajaxTask = obj_message_sql.getMessage(messageID=val(arguments.itemID)).from_userID></cfif>
		
	<cfreturn s_ajaxTask>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="showMessages">

	<cfset obj_user = createObject("component","braddoro.user.user_logic").init(dsn=module_dsn)>
	<cfset q_getUsers = obj_user.getUserList()>
	<cfset obj_message_sql = createObject("component","message_sql").init(dsn=module_dsn)>
	<cfset q_getMessages = obj_message_sql.getMessage(userID=0)>
	<cfset obj_message_display = CreateObject("component","message_display")>
	<cfsavecontent variable="s_showMessages">
		<cfoutput>#obj_message_display.messageMain(userID=module_userID,messageQuery=q_getMessages,userQuery=q_getUsers,dsn=module_dsn)#</cfoutput>
	</cfsavecontent>
	<cfreturn s_showMessages>
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="void" name="saveMessage">
	<cfargument name="to_userID" type="numeric" required="true">
	<cfargument name="threadID" type="numeric" required="true">
	<cfargument name="messageText" type="string" required="true">

	<cfset obj_message_sql = createObject("component","message_sql").init(dsn=module_dsn)>
	<cfset x = obj_message_sql.insertMessage(from_userID=module_userID,to_userID=arguments.to_userID,threadID=arguments.threadID,message=arguments.messageText)>

</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="void" name="deleteMessage">
	<cfargument name="messageID" type="numeric" required="true">

	<cfset obj_message_sql = createObject("component","message_sql").init(dsn=module_dsn)>
	<cfset x = obj_message_sql.deleteMessage(messageID=arguments.messageID)>

</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="void" name="updateMessage">
	<cfargument name="messageID" type="numeric" required="true">

	<cfset obj_message_sql = createObject("component","message_sql").init(dsn=module_dsn)>
	<cfset x = obj_message_sql.updateMessage(messageID=arguments.messageID)>

</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="numeric" name="getMessageCount">
	<cfargument name="userID" type="numeric" required="true">

	<cfset obj_message_sql = createObject("component","message_sql").init(dsn=module_dsn,userID=arguments.userID)>
	<cfset i_messageCount = obj_message_sql.getMessageCount(userID=arguments.userID).messageCount>

	<cfreturn i_messageCount>
</cffunction>
<!--- End Function --->  

</cfcomponent>