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
<cffunction access="package" output="false" returntype="String" name="showDateList">
	<cfargument name="dateQuery" type="query" required="true">
	<cfargument name="displayWord" type="string" required="true">
	<cfargument name="action" type="string" required="true">
	<cfargument name="outputDiv" type="string" required="true">
	<cfargument name="firstRow" type="numeric" default="0">
	
	<cfsavecontent variable="s_showDateList">
		<cfoutput>
		<br>
		<input type="button" id="add_viewDate" name="add_viewDate" value="add date" class="navButtons" onclick="js_requestDate('viewDate','#arguments.outputDiv#',0);"><br>
		<br>
		<fieldset>
		<legend>#arguments.displayWord#</legend>
			<br>
			<table id="quoteList" width="100%" border="1" style="border-collapse:collapse;">
				<tr>
					<th>Date ID</th>
					<th>Date</th>
					<th>recurring</th>
					<th>Active</th>
					<th>Private</th>
					<th>date Description</th>
				</tr>
			<cfloop query="arguments.dateQuery">
				<tr id="dateID_#dateID#" onclick="js_requestDate('#arguments.action#','#arguments.outputDiv#',#dateID#);" onmouseover="js_changeBG(this.id,'##AB9448');" onmouseout="js_changeBG(this.id,'##E7E7E7');" style="cursor:default;" title="click to view">
					<td>#numberformat(dateID,"0000")#</td>
					<td>#dateFormat(dateData,"mm/dd/yyyy")#</td>
					<td>#recurring#</td>
					<td>#active#</td>
					<td>#private#</td>
					<td>#dateDescription#</td>
				</tr>
			</cfloop>
			</table>
		</fieldset>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_showDateList>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="dateInput">
	<cfargument name="dateQuery" type="query" required="true">
	<cfargument name="outputDiv" type="string" required="true">
	<cfargument name="displayWord" type="string" required="true">
	
	<cfsavecontent variable="s_dateInput">
		<cfoutput>
		<fieldset>
		<legend>#arguments.displayWord#</legend>
			<input type="text" id="userID" name="userID" class="navButtons" style="display:block;" title="userID" value="#arguments.dateQuery.userID#" onblur="">
			<input type="text" id="dateData" name="dateData" class="navButtons" style="display:block;" title="enter a valid date" value="#dateformat(arguments.dateQuery.dateData,'mm/dd/yyyy')#" onblur="">
			<textarea id="dateDescription" name="dateDescription" class="navButtons" style="display:block;" rows="10" cols="80">#arguments.dateQuery.dateDescription#</textarea>
			<input type="text" id="recurring" name="recurring" class="navButtons" style="display:block;" title="Is this a recurring date?" value="#arguments.dateQuery.recurring#" onblur="">
			<input type="text" id="active" name="active" class="navButtons" style="display:block;" title="Is this date active?" value="#arguments.dateQuery.active#" onblur="">
			<input type="text" id="private" name="private" class="navButtons" style="display:block;" title="Is this a private date?" value="#arguments.dateQuery.private#" onblur="">
			<input type="button" id="saveDate" name="saveDate" value="save" class="navButtons" style="display:block;" onclick="js_requestDate('saveDate','#arguments.outputDiv#',#val(arguments.dateQuery.dateID)#);">
		</fieldset>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_dateInput>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="dateAction">
	<cfargument name="dateID" type="numeric" required="true">
	<cfargument name="displayWord" type="string" required="true">
	<cfargument name="outputDiv" type="string" required="true">
	
	<cfsavecontent variable="s_dateAction">
		<cfoutput>
		<fieldset>
		<legend>#arguments.displayWord#</legend>
			<br>
			<input type="button" id="edit_viewDate" name="edit_viewDate" value="view date" class="navButtons" onclick="js_requestDate('viewDate','#arguments.outputDiv#',#arguments.dateID#);"><br>
			<input type="button" id="add_viewDate" name="add_viewDate" value="add date" class="navButtons" onclick="js_requestDate('viewDate','#arguments.outputDiv#',0);"><br>
			<input type="button" id="show_viewDate" name="show_viewDate" value="date list" class="navButtons" onclick="js_requestDate('showDateList','#arguments.outputDiv#',0);"><br>
		</fieldset>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_dateAction>
</cffunction>
<!--- End Function --->

</cfcomponent>