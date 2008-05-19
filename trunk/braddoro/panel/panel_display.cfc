<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction name="init" access="public" output="false">
	<cfargument required="true" type="string" name="dsn">
	<cfargument required="true" type="numeric" name="userID">
		
	<cfset module_dsn = arguments.dsn>
	<cfset module_userID = arguments.userID>
	
	<cfoutput>#this.writeScripts()#</cfoutput>
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction name="writeScripts" access="package" output="true">

	<cfoutput>
	<style media="all" type="text/css">
	.body {
		font-family: "MS Sans Serif", Geneva, sans-serif, Arial;
		background-color: #E7E7E7;
	}
	.panelContainer {
		border: 1px solid #999999;
		width: 250px;
	}
	.panelHeader {
		border-bottom: 1px solid #999999;
		background-color: navy;
		color: #FFFFFF;
		padding: 2px;
		font-weight: bold;
	}
	.panelBody {
		display: block;
		background-color: white;
		padding: 2px;
		height: 250px;
		overflow:auto;
	}
	.panelFooter {
		border-top: 1px solid #999999;
		background-color: #DCDCDC;
		padding: 1px;"
	}
	.searchInput {
		border-bottom: 1px solid #999999;
		background-color: white;
		padding: 1px;
		height: 75px;
	}
	.searchOutput {
		border-bottom: 1px solid #999999;
		background-color: white;
		padding: 1px;
		height: 175px;
		overflow: auto;
	}
	</style>
	<script language="javascript" type="text/javascript">
	function js_collapseMe(changeMe) {
		if (document.getElementById(changeMe).style.display == "block") {
			document.getElementById(changeMe).style.display = "none";
		} else {
			document.getElementById(changeMe).style.display = "block";
		}
	}
	</script>	
</cfoutput>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction name="panelMain" access="public" output="false">
	<cfargument name="uniqueName" type="string" required="true">

	<cfargument name="headerBarText" type="string" required="true">
	
	<cfargument name="useSearch" type="string" required="true">
	<cfargument name="searchBarText" type="string" default="">
	
	<cfargument name="relatedBarText" type="string" required="true">
	<cfargument name="relatedHTML" type="string" default="">
	
	<cfargument name="useHistory" type="string" required="true">
	<cfargument name="historyBarText" type="string" default="">
	<cfargument name="historyQuery" type="query" required="false">

	<cfargument name="useFooter" type="string" required="true">

	<cfif arguments.relatedQuery.recordCount GT 0>
		<cfset showRelated = "block">
	<cfelse>
		<cfset showRelated = "none">
	</cfif>	
	<cfsavecontent variable="s_panelMain">
		<cfoutput>
			<div id="div_RDP_container_#arguments.uniqueName#" class="panelContainer" style="display:block;">
				<div id="div_RDP_header_#arguments.uniqueName#" class="panelHeader" onclick="js_collapseMe('div_RDP_body_#arguments.uniqueName#');">
				    #arguments.headerBarText#<cfif arguments.relatedQuery.recordCount GT 0>&nbsp;(#arguments.relatedQuery.recordCount#)</cfif>
				</div>
				<div id="div_RDP_body_#arguments.uniqueName#" style="display:block">
					<cfif arguments.useSearch EQ "Yes">
						#this.searchPart(uniqueName=arguments.uniqueName,searchBarText=arguments.searchBarText)#
					</cfif>
					#this.relatedPart(uniqueName=arguments.uniqueName,display=showRelated,relatedHTML=arguments.relatedHTML,relatedBarText=arguments.relatedBarText)#
					<cfif arguments.useHistory EQ "Yes">
						#this.historyPart(uniqueName=arguments.uniqueName,display="none",historyQuery=arguments.historyQuery,historyBarText=arguments.historyBarText)#
					</cfif>
					<cfif arguments.useFooter EQ "Yes">
						#this.footerPart(uniqueName=arguments.uniqueName)#
					</cfif>
				</div>
			</div>
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_panelMain>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction name="searchPart" access="package" output="false">
	<cfargument name="uniqueName" type="string" required="true">
	<cfargument name="searchBarText" type="string" required="true">
	
	<cfsavecontent variable="s_searchPart">
		<cfoutput>
			<div id="div_searchHead_#arguments.uniqueName#" class="panelFooter" onclick="js_collapseMe('div_searchBody_#arguments.uniqueName#');">#arguments.searchBarText#</div>
			<div id="div_searchBody_#arguments.uniqueName#" class="panelBody" style="display:none;">
				<div id="div_searchInput_#arguments.uniqueName#" class="searchInput">
				<input type="text" size="25" value="search">
				<select>
					<option value="0">select an option</option>
					<option value="1">option 1</option>
					<option value="1">option 2</option>
				</select>
				<button value="go">go</button>
				</div>
				<div id="div_searchOutput_#arguments.uniqueName#" class="searchOutput">
				</div>
			</div>		
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_searchPart>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction name="relatedPart" access="package" output="false">
	<cfargument name="uniqueName" type="string" required="true">
	<cfargument name="relatedBarText" type="string" required="true">
	<cfargument name="relatedHTML" type="string" default="">
	<cfargument name="display" type="string" required="true">
	
	
	<cfsavecontent variable="s_relatedPart">
		<cfoutput>
			<div id="div_relatedHead_#arguments.uniqueName#" class="panelFooter" onclick="js_collapseMe('div_relatedBody_#arguments.uniqueName#');">#arguments.relatedBarText#</div>
			<div id="div_relatedBody_#arguments.uniqueName#" class="panelBody" style="display:#arguments.display#;">
				<!--- <cfloop query="arguments.relatedQuery"></cfloop> --->
				#relatedHTML#
			</div>
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_relatedPart>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction name="historyPart" access="package" output="false">
	<cfargument name="uniqueName" type="string" required="true">
	<cfargument name="display" type="string" required="true">
	<cfargument name="historyQuery" type="query" required="true">
	<cfargument name="historyBarText" type="string" required="true">

	<cfsavecontent variable="s_historyPart">
		<cfoutput>
			<div id="div_historyHead_#arguments.uniqueName#" class="panelFooter" onclick="js_collapseMe('div_historyBody_#arguments.uniqueName#');">#arguments.historyBarText#</div>		
			<div id="div_historyBody_#arguments.uniqueName#" class="panelBody" style="display:#arguments.display#;">
				<cfloop query="arguments.historyQuery">
				
				</cfloop>
			</div>
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_historyPart>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction name="footerPart" access="package" output="false">
	<cfargument name="uniqueName" type="string" required="true">

	<cfsavecontent variable="s_footerPart">
		<cfoutput>
			<div id="div_footer_#arguments.uniqueName#" class="panelHeader">&nbsp;&raquo;<a href="http://www.lipsum.com/" class="panelHeader">Add</a></div>
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_footerPart>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction name="buildRelatedHTML" access="package" output="false">
	<cfargument name="uniqueName" type="string" required="true">

	<cfsavecontent variable="s_buildRelatedHTML">
		<cfoutput>
			
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_buildRelatedHTML>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction name="buildCustomHTML" access="package" output="false">
	<cfargument name="uniqueName" type="string" required="true">

	<cfsavecontent variable="s_buildCustomHTML">
		<cfoutput>
			
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_buildCustomHTML>
</cffunction>
<!--- End Function --->

</cfcomponent>
