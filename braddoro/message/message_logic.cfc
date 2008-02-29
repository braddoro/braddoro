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
	
	<cfsavecontent variable="s_ajaxTask">
		<cfoutput>
			<cfif arguments.task EQ "saveMessage"><cfset x = this.saveMessage(to_userID=val(arguments.message_userID),messageText=arguments.messageText)></cfif>
			<cfif arguments.task EQ "deleteMessage"><cfset x = this.deleteMessage(messageID=val(arguments.itemID))></cfif>
			#this.showMessages()#
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_ajaxTask>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="showMessages">

	<cfset obj_user = createObject("component","braddoro.user.user_logic").init(dsn=module_dsn)>
	<cfset q_getUsers = obj_user.getUserList()>
	<cfset obj_message_sql = createObject("component","message_sql").init(dsn=module_dsn)>
	<cfset q_getMessages = obj_message_sql.getMessages(userID=module_userID)>
	<cfset obj_message_display = createObject("component","message_display")>
	<cfsavecontent variable="s_showMessages">
		<cfoutput>#obj_message_display.messageMain(userID=module_userID,messageQuery=q_getMessages,userQuery=q_getUsers)#</cfoutput>
	</cfsavecontent>
	<cfreturn s_showMessages>
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="void" name="saveMessage">
	<cfargument name="to_userID" type="numeric" required="true">
	<cfargument name="messageText" type="string" required="true">

	<cfset obj_message_sql = createObject("component","message_sql").init(dsn=module_dsn)>
	<cfset x = obj_message_sql.insertMessage(from_userID=module_userID,to_userID=arguments.to_userID,message=arguments.messageText)>

</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="void" name="deleteMessage">
	<cfargument name="messageID" type="numeric" required="true">

	<cfset obj_message_sql = createObject("component","message_sql").init(dsn=module_dsn)>
	<cfset x = obj_message_sql.deleteMessage(messageID=arguments.messageID)>

</cffunction>
<!--- End Function --->  

</cfcomponent>