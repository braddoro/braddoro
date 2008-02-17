<cfcomponent output="false">

<!--- <cfproperty name="module_dsn" displayname="module_dsn" type="string" default=""> --->

<!--- Begin Function  --->
<cffunction name="init" displayname="init" access="package" output="false">
<!--- 	<cfargument required="true" type="string" name="dsn">
	<cfset module_dsn = arguments.dsn> --->
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="messageMain">
	<cfargument name="userID" type="numeric" required="true">
	<cfargument name="messageQuery" type="query" required="true">
	<cfargument name="userQuery" type="query" required="true">
	
	<cfsavecontent variable="s_messageMain">
		<cfoutput>
			#this.messageInput(userID=arguments.userID,userQuery=arguments.userQuery)#
			<br>
			<div id="div_messages">#this.messageOutput(messageQuery=arguments.messageQuery)#</div>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_messageMain>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="messageInput">
	<cfargument name="userID" type="numeric" required="true">
	<cfargument name="userQuery" type="query" required="true">
	
	<cfset obj_utility_display = createObject("component","utility_display")>
	<cfsavecontent variable="s_messageInput">
		<cfoutput>
		<fieldset>
		<legend>write message</legend>
			#obj_utility_display.queryDropdown(selectName="message_userID",dataQuery=arguments.userQuery)#<br>
			<textarea id="messageText" name="messageText" class="navButtons" rows="10" cols="80"></textarea><br>
			<input type="button" id="saveMessage" name="saveMessage" value="save" class="navButtons" onclick="js_buildRequest(this.id,'div_main',0);">
		</fieldset>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_messageInput>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="messageOutput">
	<cfargument name="messageQuery" type="query" required="true">
	
	<cfsavecontent variable="s_messageOutput">
		<cfoutput>
		<fieldset>
		<legend>messages</legend>
		<cfif arguments.messageQuery.recordCount GT 0>
		<cfloop query="arguments.messageQuery">
			<strong>from #from# to #to# on #dateFormat(sentDate,"long")#</strong><br>
			#message#<br>
			<cfif currentRow LT recordCount><hr size="1"></cfif>
		</cfloop>
		</fieldset>
		<cfelse>
			no messages
		</cfif>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_messageOutput>
</cffunction>
<!--- End Function --->

</cfcomponent>