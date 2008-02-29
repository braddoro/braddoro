<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction name="init" displayname="init" access="package" output="false">
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="fail">
	<cfargument name="message" type="string" default="">
	<cfargument name="detail" type="string" default="">
	<cfargument name="type" type="string" default="">
	<cfargument name="tagContext" type="Array" default="">
	<cfargument name="showError" type="string" default="false">
	<cfargument name="remoteIP" type="string" default="false">
	

	<cfsavecontent variable="s_fail">
	<cfoutput>
	<fieldset>
	<legend><strong>the moose has arrived</strong></legend>
	<img src="http://lh5.google.com/braddoro/R60a3SciJXI/AAAAAAAAAHI/bfIezPTzpP0/s400/you_fail_016.jpg" /><br>
	<hr>
	#dateFormat(now(),"mm/dd/yyyy")# #timeFormat(now(),"hh:mm TT")#<br>
	#remoteIP#<br>
	<cfif arguments.showError>
		#arguments.message#<br>
		#arguments.type#<br>
		#arguments.detail#<br>
		<cfdump var="#arguments.tagContext#">
	<cfelse>
	You have arrived here because something unexpected happened on the web site.
	</cfif>
	</fieldset>
	</cfoutput>
	</cfsavecontent>

	<cfreturn s_fail>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="showErrors">
	<cfargument name="errorQuery" type="query" required="true">
	

	<cfsavecontent variable="s_showErrors">
	<cfoutput>
	<br>
	<table id="quoteList" width="100%" border="1" style="border-collapse:collapse;">
		<tr>
			<th>userID</th>
			<th>when</th>
			<th>remoteIP</th>
			<th>type</th>
			<th>message</th>
			<th>detail</th>
		</tr>
	<cfloop query="arguments.errorQuery">
		<tr>
			<td>#numberformat(userID,"0000")#</td>
			<td>#dateFormat(addedDate,"mm/dd/yyyy")# #timeFormat(addedDate,"hh:mm TT")#</td>
			<td>#remoteIP#</td>
			<td>#type#</td>
			<td>#message#</td>
			<td>#detail#</td>
		</tr>
	</cfloop>
	</table>
	</cfoutput>
	</cfsavecontent>

<!--- 
onmouseover="js_changeBG(this.id,'##AB9448');" onmouseout="js_changeBG(this.id,'##E7E7E7');" style="cursor:default;" title="click to view"
onclick="js_buildRequest('#arguments.action#','#arguments.outputDiv#',#quoteID#);"
 id="quoteID_#quoteID#" 
 --->
	<cfreturn s_showErrors>
</cffunction>
<!--- End Function --->

</cfcomponent>