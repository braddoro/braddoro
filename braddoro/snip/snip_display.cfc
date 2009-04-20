<cfcomponent output="false">

<!--- Begin Function <cfdump var="#arguments.dataQuery#"> --->
<cffunction name="input" access="package" output="false" returntype="string">
<cfargument name="dataQuery" type="query" required="true">

<cfsavecontent variable="s_input">
	<cfoutput>
		<table class="tablenormal">
			<TR>
				<TD><INPUT type="text" name="category" id="category" value="#arguments.dataQuery.category#" size="75" maxlength="150"></TD>
			</TR>
			<TR>
				<TD><INPUT type="text" name="title" id="title" value="#arguments.dataQuery.title#" size="75" maxlength="150"></TD>
			</TR>
			<TR>
				<TD><textarea id="snippet" id="snippet" cols="80" rows="30">#arguments.dataQuery.snippet#</textarea></TD>
			</TR>
			<TR>
				<TD>
					<input type="button" id="save" name="save" alt="save" value="save" title="save" class="" style="" onclick="js_ajax('save','#val(arguments.dataQuery.snippetID)#','div_output');">
				</TD>
			</TR>
		</table>
	</cfoutput>
</cfsavecontent>

<cfreturn s_input>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction name="output" access="package" output="false" returntype="string">
<cfargument name="dataQuery" type="query" required="true">

<cfsavecontent variable="s_output">
	<cfoutput>
		<table class="" border="1">
			<cfloop query="arguments.dataQuery">
			<tr>
			<td style="cursor:pointer;" onclick="js_ajax('edit','#val(arguments.dataQuery.snippetID)#','div_input');"><b>#val(arguments.dataQuery.snippetID)#</b> #arguments.dataQuery.category#</td>
			<td>#arguments.dataQuery.title#</td>			
			</tr>
			<tr>
			<td colspan="2">#replace(arguments.dataQuery.snippet,chr(10),"<br>","All")#</td>
			</tr>
		</cfloop>
		</table>
	</cfoutput>
</cfsavecontent>

<cfreturn s_output>
</cffunction>
<!--- End Function --->

</cfcomponent>