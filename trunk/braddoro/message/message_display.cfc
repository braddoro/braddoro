<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction name="init" displayname="init" access="package" output="false">
	
	<cfset variables.s_messageOutput_threaded = "">
	
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
			<div id="div_inputMessage">
			#this.messageInput(userID=arguments.userID,userQuery=arguments.userQuery)#
			</div>
			<br>
			<!--- <div id="div_messages">#this.messageOutput(userID=arguments.userID,messageQuery=arguments.messageQuery,dsn=arguments.dsn)#</div> --->
			<div id="div_messages">#this.messageOutput_threaded(userID=arguments.userID,dsn=arguments.dsn,threadID=0)#</div>
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
			<input type="hidden" id="message_threadID" value="0">
			<textarea id="messageText" name="messageText" class="navButtons" rows="10" cols="80"></textarea><br>
			<input type="button" id="saveMessage" name="saveMessage" value="save" class="navButtons" onclick="js_requestMessage(this.id,'div_main',0);">
		</fieldset>
		<div id="messageLink" align="center"><img src="../images/chain_nicu_buculei_00.png" border="0" title="refresh message list" onclick="js_requestMessage('refresh','div_main',0);"></div>
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
		    	<cfset s_float = "left">
			<cfelse>
				<cfset s_float = "right">
			</cfif>
	    	<fieldset>
		    <legend style="float:#s_float#;"><strong>from #from# to #to# on #dateFormat(sentDate,"long")# at #timeFormat(sentDate,"hh:mm TT")#</strong></legend>
			#replace(message,chr(10),"<br>","All")#<br>
			<div align="right">
            <cfif readDate NEQ "">
                read on #dateformat(readDate,"mm/dd/yyyy")# at #timeformat(readDate,"hh:mm TT")#
            <cfelse>
                <cfif arguments.userID EQ to_userID>
                    <a id="markMessage_#messageID#" name="markMessage_#messageID#" href="javascript:js_requestMessage('markMessage','div_main',#messageID#);">mark as read</a> 
                </cfif>
            </cfif>
            <cfif arguments.userID EQ from_userID or arguments.userID EQ to_userID>
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

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="messageOutput_threaded">
    <cfargument name="userID" type="numeric" required="true">
	<cfargument name="dsn" type="string" required="true">
	<cfargument name="threadID" type="numeric" required="true">

	<cfset obj_message_sql = CreateObject("component","message_sql").init(dsn=arguments.dsn)>
	<cfset q_getMessages = obj_message_sql.getMessages_threaded(userID=arguments.userID,threadID=arguments.threadID)>	

	<cfsavecontent variable="s_messageOutput_threaded">
		<cfoutput>
		<cfif q_getMessages.recordCount GT 0>
			<cfif arguments.threadID GT 0></cfif>
			<cfloop query="q_getMessages">
		    	<!--- <cfif from_userID EQ arguments.userID>
			    	<cfset s_float = "left">
				<cfelse>
					<cfset s_float = "right">
				</cfif> --->
				<cfif arguments.threadID EQ 0>
					<br>
			    	<fieldset>
				    <legend id="legend_messageGroup_#messageID#"
				    onmouseover="js_changeBG(this.id,'##EEF3E2');" 
					onmouseout="js_changeBG(this.id,'##E7E7E7');" 
					onclick="js_collapseThis('div_messageGroup_#messageID#');" 
					style="cursor:default;"><strong>sent by #from# to #to# on #dateFormat(sentDate,"long")# at #timeFormat(sentDate,"hh:mm TT")#</strong></legend>
					<div id="div_messageGroup_#messageID#" style="display:block;">
					<img src="../images/comment.gif" border="0" title="reply to this message" onclick="js_requestMessage('replyTo','div_inputMessage',#messageID#);">&nbsp;
				  <cfelse>
				  	<div id="div_messageGroup_#messageID#" style="margin-left:20px;">
					<cfif readDate EQ "" and from_userID NEQ arguments.userID>
						<img src="../images/rh_checkbox.gif" border="0" title="mark message as read" onclick="js_requestMessage('markMessage','div_main',#messageID#);">&nbsp;
					</cfif>				  	
					&nbsp;<img src="../images/comment.gif" border="0" title="reply to this message" onclick="js_requestMessage('replyTo','div_inputMessage',#messageID#);">&nbsp;<strong>#from#</strong> said to <strong>#to#</strong> on #dateFormat(sentDate,"long")# at #timeFormat(sentDate,"hh:mm TT")#
			    </cfif>
		        <cfif from_userID EQ arguments.userID>
		            &nbsp;<img src="../images/del.gif" border="0" title="delete this message" onclick="js_requestMessage('deleteMessage','div_main',#messageID#);">
	            </cfif>
				<br>
			    <cfif readDate NEQ "">read on #dateformat(readDate,"mm/dd/yyyy")# at #timeformat(readDate,"hh:mm TT")#<br></cfif>
	            <br>
				#replace(message,chr(10),"<br>","All")#<br><br>
	            <div>
					#messageOutput_threaded(userID=arguments.userID,dsn=arguments.dsn,threadID=messageID)#
				</div>
				<cfif arguments.threadID EQ 0>
					</div>
	    			</fieldset>
	    		<cfelse>
	    			</div>
	    		</cfif>
			</cfloop>
		<cfelse>
			<!--- no messages --->
		</cfif>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_messageOutput_threaded>
</cffunction>
<!--- End Function --->

</cfcomponent>