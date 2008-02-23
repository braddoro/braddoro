<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction name="init" displayname="init" access="package" output="false">
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="dateDisplay">
	<cfargument name="dateQuery" type="query" required="true">
	
	<cfsavecontent variable="s_dateDisplay">
		<cfoutput><cfif arguments.dateQuery.recordCount GT 0>
		<fieldset>
		<legend>dates</legend>
		<cfloop query="arguments.dateQuery">
			#weekDay# - #dateformat(dateData,"mm/dd/yyyy")# : #dateDescription#<br>
		</cfloop>
		</fieldset>
		</cfif></cfoutput>
	</cfsavecontent>

	<cfreturn s_dateDisplay>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="dateInput">
	<cfargument name="userID" type="numeric" required="true">
	<cfargument name="userQuery" type="query" required="true">
	
	<cfset obj_utility_display = createObject("component","braddoro.utility.utility_display")>
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

</cfcomponent>