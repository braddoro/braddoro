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
	
<!--- <cfif arguments.task EQ "saveMessage"><cfset x = this.saveMessage(to_userID=val(arguments.message_userID),messageText=arguments.messageText)></cfif>  --->
<!--- <cfif arguments.task EQ "deleteMessage"><cfset x = this.deleteMessage(messageID=val(arguments.itemID))></cfif> --->
<!--- #this.showDates()# --->
	<cfsavecontent variable="s_ajaxTask">
		<cfoutput>
			<cfif arguments.task EQ "showDateList">#this.showDateList(argumentCollection=arguments)#</cfif>
			<cfif arguments.task EQ "viewDate">#this.inputDates(argumentCollection=arguments)#</cfif>
			<cfif arguments.task EQ "saveDate">#this.saveDates(argumentCollection=arguments)#</cfif>
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_ajaxTask>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="showDateList">
	<cfargument name="outputDiv" type="string" required="true">

	<cfset obj_date_sql = createObject("component","date_sql").init(dsn=module_dsn)>
	<cfset q_getDate = obj_date_sql.getDateData()>
	<cfset obj_date_display = createObject("component","date_display")>
	<cfsavecontent variable="s_showDateList">
	<cfoutput>#obj_date_display.showDateList(dateQuery=q_getDate,displayWord="date list",action="viewDate",outputDiv=arguments.outputDiv)#</cfoutput>
	</cfsavecontent>
	<cfreturn s_showDateList>
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="inputDates">
	<cfargument name="dateID" type="numeric" required="true">
	<cfargument name="outputDiv" type="string" required="true">

	<cfif arguments.dateID EQ 0>
		<cfset lcl_getNone="Yes">
		<cfset lcl_displayWord="add date">
	<cfelse>
		<cfset lcl_getNone="No">
		<cfset lcl_displayWord="edit date">
	</cfif>
	<cfset obj_date = createObject("component","date_sql").init(dsn=module_dsn)>
	<cfset q_getDateData = obj_date.getDateData(dateID=arguments.dateID,getNone=lcl_getNone)>
	<cfset obj_date = createObject("component","date_display")>
	<cfsavecontent variable="s_inputDates">
		<cfoutput>#obj_date.dateInput(dateQuery=q_getDateData,displayWord=lcl_displayWord,outputDiv=arguments.outputDiv)#</cfoutput>
	</cfsavecontent>
	<cfreturn s_inputDates>
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="showDates">

	<cfset obj_date = createObject("component","date_sql").init(dsn=module_dsn)>
	<cfset q_getDate = obj_date.getDate()>
	<cfset s_showDates = createObject("component","date_display").dateDisplay(dateQuery=q_getDate)>

	<cfreturn s_showDates>
</cffunction>
<!--- End Function --->  

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="saveDates">
	<cfargument required="true" type="string" name="outputDiv">
	<cfargument name="dateID" type="numeric" default="0">

	<cfset obj_date = createObject("component","date_sql").init(dsn=module_dsn)>
	<cfif arguments.dateID GT 0>
		<cfset x = obj_date.updateDate(
			dateID=arguments.dateID,
			userID=arguments.userID,
			dateData=arguments.dateData,
			dateDescription=arguments.dateDescription,
			recurring=arguments.recurring,
			active=arguments.active,
			private=arguments.private
			)>
		<cfset newDateID = arguments.dateID>
	<cfelse>
		<cfset newDateID = obj_date.insertDate(
			userID=arguments.userID,
			dateData=arguments.dateData,
			dateDescription=arguments.dateDescription,
			recurring=arguments.recurring,
			active=arguments.active,
			private=arguments.private
			).dateID>
	</cfif>
	<cfset obj_date_display = createObject("component","date_display").init()>
	<cfsavecontent variable="s_saveDates">
	<cfoutput>#obj_date_display.dateAction(
		dateID=val(newDateID),
		displayWord="what do you want to do",
		outputDiv=arguments.outputDiv
		)#</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_saveDates>

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