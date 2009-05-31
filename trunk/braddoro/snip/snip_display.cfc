<cfcomponent output="false">

	<!--- Begin Function --->
	<cffunction name="input" access="package" output="false" returntype="string">
		<cfargument name="dataQuery" type="query" required="true">
		<cfargument name="categoryQuery" type="query" required="true">
		
		<cfsavecontent variable="s_input">
			<cfoutput>
				<table style="font-size:.75em;">
					<tr>
						<td>Category: 
						<select id="category" name="category">
						<option value="">Select an Option</option>
						<cfloop query="arguments.categoryQuery">
							<cfset s_category = arguments.categoryQuery.category>
							<option value="#category#"<cfif s_category EQ arguments.dataQuery.category> SELECTED</cfif>>#category#</option>
						</cfloop>
						</select>&nbsp;<input type="checkbox" id="newinput_check" name="newinput_check" value="newinput_check" onclick="js_collapseThis('newinput');">&nbsp;<span id="newinput" name="newinput" style="display:none"><input type="text" name="new_category" id="new_category" value="" size="75" maxlength="500"></span>
						</td>
					</tr>
					<tr>
						<td>Title: <input type="text" name="snip_name" id="snip_name" value="#arguments.dataQuery.snip_name#" size="75" maxlength="500"></td>
					</tr>
					<tr>
						<td>Help: <input type="text" name="snip_help" id="snip_help" value="#arguments.dataQuery.snip_help#" size="75" maxlength="500"></td>
					</tr>
					<tr>
						<td><textarea id="snippetStart" id="snippetStart" cols="80" rows="15">#arguments.dataQuery.snippetStart#</textarea></td>
					</tr>
					<tr>
						<td><textarea id="snippetEnd" id="snippetEnd" cols="80" rows="15">#arguments.dataQuery.snippetEnd#</textarea></td>
					</tr>
					<tr>
						<td>
							#arguments.dataQuery.snippetID# <input type="button" id="save" name="save" alt="save" value="save" title="save" class="" style="" onclick="js_ajax('save','#val(arguments.dataQuery.snippetID)#','div_output');">
							<input type="button" id="cancel" name="cancel" alt="cancel" value="cancel" title="cancel" class="" style="" onclick="js_ajax('show',0,'div_output');">
						</td>
					</tr>
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
			<cfoutput query="arguments.dataQuery" group="Category">
				<div id="L0_#snippetID#" name="L0_#snippetID#" style="cursor:pointer;display:block;" onclick="js_collapseThis2('L1_#category#','img_cat_#category#');"><img id="img_cat_#category#" src="2.gif">&nbsp;<b>#category#</b></div>
				<div id="L1_#category#" name="L1_#category#" style="cursor:pointer;display:none;width:100%">
					<cfoutput>
						<div id="L2_#snippetID#" name="L2_#snippetID#" style="padding-left:20px;cursor:pointer;display:block;" onclick="js_collapseThis('L3_#snippetID#');"><img src="icon_read.gif">&nbsp;<b>#snip_name#</b></div>
						<div id="L3_#snippetID#" name="L3_#snippetID#" style="border:1px solid ##333333;cursor:pointer;display:none;width:90%">
							#replace(HTMLCodeFormat(snippetStart),chr(10),"<br>","All")#<br>#replace(HTMLCodeFormat(snippetEnd),chr(10),"<br>","All")#
							<span style="float:right;">
								<img src="misc_new_window.gif" title="Edit snippet." onclick="js_ajax('edit',#val(snippetID)#,'div_output');">
							</span>
						</div>
					</cfoutput>
				</div>
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn s_output>
	</cffunction>
	<!--- End Function --->

</cfcomponent>