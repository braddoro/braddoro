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
<script type="text/javascript" src="/braddoro/date/date.js"></script>
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
			#this.showDates()#
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_ajaxTask>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="showDates">

	<cfset obj_date = createObject("component","date_sql").init(dsn=module_dsn)>
	<cfset q_getDate = obj_date.getDate()>
	<cfset obj_date = createObject("component","date_display")>
	<cfsavecontent variable="s_showDates">
		<cfoutput>#obj_date.dateDisplay(dateQuery=q_getDate)#</cfoutput>
	</cfsavecontent>
	<cfreturn s_showDates>
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="void" name="saveDates">

	<cfset obj_date = createObject("component","date_sql").init(dsn=module_dsn)>
	<cfset x = obj_date.insertDate(argumentCollection=arguments)>

</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="void" name="deleteDates">
	<cfargument name="dateID" type="numeric" required="true">

	<cfset obj_date = createObject("component","date_sql").init(dsn=module_dsn)>
	<cfset x = obj_date.deleteDate(dateID=arguments.dateID)>

</cffunction>
<!--- End Function --->  

</cfcomponent>