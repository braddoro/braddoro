<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction name="init" displayname="init" access="package" output="false">
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="messageMain">
	<cfargument name="userID" type="numeric" required="true">
	<cfargument name="messageQuery" type="query" required="true">
	<cfargument name="userQuery" type="query" required="true">
	<cfargument name="dsn" type="string" required="true">
	
	<cfsavecontent variable="s_messageMain">
		<cfoutput>
			#this.messageInput(userID=arguments.userID,userQuery=arguments.userQuery)#
			<br>
			<div id="div_messages">#this.messageOutput(userID=arguments.userID,messageQuery=arguments.messageQuery,dsn=arguments.dsn)#</div>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_messageMain>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="messageInput">
	<cfargument name="userID" type="numeric" required="true">
	<cfargument name="userQuery" type="query" required="true">
	
	<cfset obj_utility_display = CreateObject("component","braddoro.utility.utility_display")>
	<cfsavecontent variable="s_messageInput">
		<cfoutput>
		<fieldset>
		<legend>write message</legend>
			#obj_utility_display.queryDropdown(selectName="message_userID",dataQuery=arguments.userQuery)#<br>
			<textarea id="messageText" name="messageText" class="navButtons" rows="10" cols="80"></textarea><br>
			<input type="button" id="saveMessage" name="saveMessage" value="save" class="navButtons" onclick="js_requestMessage(this.id,'div_main',0);">
		</fieldset>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_messageInput>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="messageOutput">
    <cfargument name="userID" type="numeric" required="true">
	<cfargument name="messageQuery" type="query" required="true">
	<cfargument name="dsn" type="string" required="true">

	<cfset obj_message_sql = CreateObject("component","message_sql").init(dsn=arguments.dsn)>	
	<cfsavecontent variable="s_messageOutput">
		<cfoutput>
		<cfif arguments.messageQuery.recordCount GT 0>
		<cfloop query="arguments.messageQuery">
	    	<cfif from_userID EQ arguments.userID>
		    	<cfset lcl_float = "left">
			<cfelse>
				<cfset lcl_float = "right">
			</cfif>
	    	<fieldset>
		    <legend style="float:#lcl_float#;"><strong>from #from# to #to# on #dateFormat(sentDate,"long")# at #timeFormat(sentDate,"hh:mm TT")#</strong></legend>
			#replace(message,chr(10),"<br>","All")#<br>
			<div align="right">
            <cfif readDate NEQ "">
                read on #dateformat(readDate,"mm/dd/yyyy")# at #timeformat(readDate,"hh:mm TT")#
            <cfelse>
                <cfif arguments.userID EQ to_userID>
                    <a id="markMessage_#messageID#" name="markMessage_#messageID#" href="javascript:js_requestMessage('markMessage','div_main',#messageID#);">mark as read</a> 
                </cfif>
            </cfif>
            <cfif arguments.userID EQ from_userID>
                <a id="message_#messageID#" name="message_#messageID#" href="javascript:js_requestMessage('deleteMessage','div_main',#messageID#);">delete message</a>
            </cfif>
            </div>
    		</fieldset>
		</cfloop>
		<cfelse>
			no messages
		</cfif>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_messageOutput>
</cffunction>
<!--- End Function --->

</cfcomponent>