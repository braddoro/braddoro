<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction name="writeScripts" access="package" output="false">

	<cfsavecontent variable="s_writeScripts">
	<cfoutput>
	<style media="all" type="text/css">
	.body {
		font-family: "MS Sans Serif", Geneva, sans-serif, Arial;
		background-color: ##E7E7E7;
	}
	.panelContainer {
		border: 1px solid ##999999;
		width: 200px;
		margin-bottom: 8px;
	}
	.panelBar {
		border-bottom: 1px solid ##999999;
		background-color: ##647878;
		color: ##FFFFFF;
		padding: 2px;
		font-weight: bold;
		font-size: .90em;
	}
	.panelBody {
		display: block;
		background-color: white;
		padding: 2px;
		height: 200px;
		overflow:auto;
		font-size: .85em;
	}
	.panelFooter {
		border-top: 1px solid ##999999;
		background-color: ##DCDCDC;
		padding: 1px;
		font-size: .85em;
	}
	.searchInput {
		border-bottom: 1px solid ##999999;
		background-color: white;
		padding: 1px;
		height: auto;
		font-size: .85em;
	}
	.searchOutput {
		border-bottom: 1px solid ##999999;
		background-color: white;
		padding: 1px;
		height: auto;
		overflow: auto;
		font-size: .85em;
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
</cfsavecontent>

	<cfreturn s_writeScripts>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction name="panelMain" access="public" output="false">
	<cfargument name="containerVisibility" type="string" default="">
	<cfargument name="useSearch" type="string" default="No">
	<cfargument name="useRelated" type="string" default="Yes">
	<cfargument name="useFooter" type="string" default="No">
	<cfargument name="useHistory" type="string" default="No">
	
	<cfargument name="searchBarText" type="string" default="">
	<cfargument name="relatedBarText" type="string" default="">
	<cfargument name="footerBarText" type="string" default="">
	<cfargument name="historyBarText" type="string" default="">

	<cfargument name="searchHTML" type="string" default="">
	<cfargument name="relatedHTML" type="string" default="">
	<cfargument name="footerHTML" type="string" default="">
	<cfargument name="historyHTML" type="string" default="">
	
	<cfargument name="headerBarText" type="string" default="">
	<cfargument name="uniqueName" type="string" default="">
	<cfargument name="panelVisibility" type="string" default="block">
	<cfargument name="panelHeight" type="numeric" default="0">
	<cfargument name="panelWidth" type="numeric" default="0">
	<cfargument name="useFieldSet" type="string" default="Yes">
	
	<cfsavecontent variable="s_panelMain">
		<cfoutput>
		<cfif arguments.useFieldSet EQ "Yes">
			<fieldset id="div_RDP_container_#arguments.uniqueName#" style="<cfif arguments.containerVisibility NEQ "">display:#arguments.containerVisibility#;</cfif><cfif arguments.panelheight GT 0>width=#arguments.panelwidth#;</cfif>">
				<legend id="div_RDP_header_#arguments.uniqueName#" onclick="js_collapseMe('div_RDP_body_#arguments.uniqueName#');">#arguments.headerBarText#&nbsp;</legend>
		<cfelse>
			<div id="div_RDP_container_#arguments.uniqueName#" class="panelContainer" style="<cfif arguments.containerVisibility NEQ "">display:#arguments.containerVisibility#;</cfif><cfif arguments.panelheight GT 0>width=#arguments.panelwidth#;</cfif>">
				<div id="div_RDP_header_#arguments.uniqueName#" class="panelBar" onclick="js_collapseMe('div_RDP_body_#arguments.uniqueName#');">#arguments.headerBarText#</div>
		</cfif>
		<div id="div_RDP_body_#arguments.uniqueName#" style="display:#arguments.panelVisibility#;<cfif arguments.panelheight GT 0>height=#arguments.panelheight#;</cfif>overflow:auto;">
			<cfif arguments.useSearch EQ "Yes">
				#this.searchPart(uniqueName=arguments.uniqueName,barText=arguments.searchBarText,HTML=arguments.searchHTML)#
			</cfif>
			<cfif arguments.useRelated EQ "Yes">
				#this.relatedPart(uniqueName=arguments.uniqueName,barText=arguments.relatedBarText,HTML=arguments.relatedHTML)#
			</cfif>
			<cfif arguments.useHistory EQ "Yes">
				#this.historyPart(uniqueName=arguments.uniqueName,barText=arguments.historyBarText,HTML=arguments.historyHTML)#
			</cfif>
		</div>
		<cfif arguments.useFooter EQ "Yes">
			#this.footerPart(uniqueName=arguments.uniqueName,barText=arguments.footerBarText,HTML=arguments.footerHTML)#
		</cfif>
		<cfif arguments.useFieldSet EQ "Yes">
			</fieldset>
		<cfelse>
			</div>
		</cfif>
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_panelMain>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction name="searchPart" access="package" output="false">
	<cfargument name="uniqueName" type="string" required="true">
	<cfargument name="barText" type="string" required="true">
	<cfargument name="HTML" type="string" required="true">
	
	<cfsavecontent variable="s_searchPart">
		<cfoutput>
			<div id="div_searchHead_#arguments.uniqueName#" class="panelFooter" onclick="js_collapseMe('div_searchBody_#arguments.uniqueName#');">#arguments.barText#</div>
			<div id="div_searchBody_#arguments.uniqueName#" class="panelBody" style="display:block;">
				<div id="div_searchInput_#arguments.uniqueName#" class="searchInput">#arguments.HTML#</div>
				<div id="div_searchOutput_#arguments.uniqueName#" class="searchOutput">output here</div>
			</div>		
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_searchPart>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction name="relatedPart" access="package" output="false">
	<cfargument name="uniqueName" type="string" required="true">
	<cfargument name="barText" type="string" required="true">
	<cfargument name="HTML" type="string" default="">
	
	<cfsavecontent variable="s_relatedPart">
		<cfoutput>
			<cfif arguments.barText NEQ "">
			<div id="div_relatedHead_#arguments.uniqueName#" class="panelFooter" onclick="js_collapseMe('div_relatedBody_#arguments.uniqueName#');">#arguments.barText#</div>
			</cfif>
			<div id="div_relatedBody_#arguments.uniqueName#" class="panelBody" style="display:block;">
				#arguments.HTML#
			</div>
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_relatedPart>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction name="historyPart" access="package" output="false">
	<cfargument name="uniqueName" type="string" required="true">
	<cfargument name="panelState" type="string" default="none">
	<cfargument name="HTML" type="string" required="true">
	<cfargument name="barText" type="string" required="true">

	<cfsavecontent variable="s_historyPart">
		<cfoutput>
			<div id="div_historyHead_#arguments.uniqueName#" class="panelFooter" onclick="js_collapseMe('div_historyBody_#arguments.uniqueName#');">#arguments.BarText#</div>		
			<div id="div_historyBody_#arguments.uniqueName#" class="panelBody" style="display:#arguments.panelState#;">#arguments.HTML#</div>
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_historyPart>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction name="footerPart" access="package" output="false">
	<cfargument name="uniqueName" type="string" required="true">
	<cfargument name="barText" type="string" required="true">
	<cfargument name="HTML" type="string" default="">

	<cfsavecontent variable="s_footerPart">
		<cfoutput>
			<div id="div_footer_#arguments.uniqueName#" class="panelBar">&nbsp;&raquo;&nbsp;#arguments.HTML#</div>
		</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_footerPart>
</cffunction>
<!--- End Function --->

</cfcomponent>