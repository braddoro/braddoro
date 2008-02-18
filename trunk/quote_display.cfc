<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction name="init" displayname="init" access="package" output="false">
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="randomQuote">
<cfargument name="quoteQuery" type="query" required="true">

	<cfsavecontent variable="s_randomQuote">
	<cfoutput query="arguments.quoteQuery"><span class="mediumtext">#quote#<cfif quoteBy NEQ ""> - #quoteBy#</cfif><cfif quoteWhen NEQ ""> (#quoteWhen#)</cfif></span></cfoutput>
	</cfsavecontent>
	
	<cfreturn s_randomQuote>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="quoteList">
	<cfargument name="quoteQuery" type="query" required="true">
	<cfargument name="displayWord" type="string" required="true">
	<cfargument name="action" type="string" required="true">
	<cfargument name="outputDiv" type="string" required="true">
	
	<cfsavecontent variable="s_quoteList">
		<cfoutput>
		<br>
		<input type="button" id="add_viewQuote" name="viewQuote" value="add quote" class="navButtons" onclick="js_buildRequest('viewQuote','#arguments.outputDiv#',0);"><br>
		<br>
		<fieldset>
		<legend>#arguments.displayWord#</legend>
			<br>
			<table id="quoteList" width="100%" border="1" style="border-collapse:collapse;">
				<tr>
					<th>Quote ID</th>
					<th>By</th>
					<th>Reference</th>
					<th>Active</th>
					<th>Quote</th>
				</tr>
			<cfloop query="arguments.quoteQuery">
				<tr id="quoteID_#quoteID#" onclick="js_buildRequest('#arguments.action#','#arguments.outputDiv#',#quoteID#);" onmouseover="js_changeBG(this.id,'##AB9448');" onmouseout="js_changeBG(this.id,'##E7E7E7');" style="cursor:default;" title="click to view">
					<td>#numberformat(quoteID,"0000")#</td>
					<td>#quoteBy#</td>
					<td>#quoteWhen#</td>
					<td>#active#</td>
					<td>#quote#</td>
				</tr>
			</cfloop>
			</table>
		</fieldset>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_quoteList>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="quoteInput">
	<cfargument name="quoteID" type="numeric" required="true">
	<cfargument name="quoteQuery" type="query" required="true">
	<cfargument name="displayWord" type="string" required="true">
	<cfargument name="action" type="string" required="true">
	<cfargument name="outputDiv" type="string" required="true">
	
	<cfsavecontent variable="s_quoteInput">
		<cfoutput>
		<fieldset>
		<legend>#arguments.displayWord#</legend>
			<br>
			<input type="text" id="quoteBy" name="quoteBy" class="navButtons" size="40" value="#arguments.quoteQuery.quoteBy#">
			<input type="text" id="quoteWhen" name="quoteWhen" class="navButtons" size="40" value="#arguments.quoteQuery.quoteWhen#">
			<input type="text" id="quoteActive" name="quoteActive" class="navButtons" size="1" value="#arguments.quoteQuery.active#">
			<textarea id="quoteText" name="quoteText" class="navButtons" rows="10" cols="80">#arguments.quoteQuery.quote#</textarea><br>
			<input type="button" id="#arguments.action#" name="#arguments.action#" value="save" class="navButtons" onclick="js_buildRequest(this.id,'#arguments.outputDiv#',#arguments.quoteID#);">
		</fieldset>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_quoteInput>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="quoteAction">
	<cfargument name="quoteID" type="numeric" required="true">
	<cfargument name="displayWord" type="string" required="true">
	<cfargument name="outputDiv" type="string" required="true">
	
	<cfsavecontent variable="s_quoteAction">
		<cfoutput>
		<fieldset>
		<legend>#arguments.displayWord#</legend>
			<br>
			<input type="button" id="edit_viewQuote" name="viewQuote" value="view quote" class="navButtons" onclick="js_buildRequest('viewQuote','#arguments.outputDiv#',#arguments.quoteID#);"><br>			
			<input type="button" id="add_viewQuote" name="viewQuote" value="add quote" class="navButtons" onclick="js_buildRequest('viewQuote','#arguments.outputDiv#',0);"><br>
			<input type="button" id="quoteStuff2" name="quoteStuff2" value="quote list" class="navButtons" onclick="js_buildRequest('quoteStuff','#arguments.outputDiv#',0);"><br>
		</fieldset>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_quoteAction>
</cffunction>
<!--- End Function --->

</cfcomponent>