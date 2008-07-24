<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction name="init" displayname="init" access="package" output="false">

	<cfreturn this>
</cffunction>
<!--- End Function  --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="string" name="showBanner">
<cfargument type="string" name="siteName" default="">
<cfargument type="string" name="siteTitle" default="">
<cfargument type="string" name="showLogo" default="false">

	<cfsavecontent variable="s_showBanner">
		<cfoutput>
			<!--- this is custom crab code. --->
			<cfif arguments.showLogo><img style="display:block;margin-left:auto;margin-right:auto;margin-bottom:0px;" title="Just for the Crab" src="../images/buff.png" border="0"><br></cfif>
			#siteTitle#<cfif arguments.siteName NEQ ""><span class="mediumtext"> - #arguments.siteName#</span></cfif></cfoutput>
	</cfsavecontent>
	
	<cfreturn s_showBanner>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="showNavMenu">
	<cfargument name="userID" type="numeric" default="1">
	<cfargument name="messageCount" type="numeric" default="0">
		
	<cfsavecontent variable="s_showNavMenu">
		<cfoutput>
		<input type="button" id="logIn" name="logIn" value="log in" class="navButtons" style="" onclick="js_requestUser(this.id,'div_main',0);">
		<cfif arguments.userID EQ 12>
		<input type="button" id="quoteStuff" name="quoteStuff" value="quotes" class="navButtons" style="" onclick="js_requestQuote(this.id,'div_main',0);">
		<input type="button" id="showDateList" name="showDateList" value="dates" class="navButtons" style="" onclick="js_requestDate(this.id,'div_main',0);">
		<input type="button" id="showErrors" name="showErrors" value="errors" class="navButtons" style="" onclick="js_requestError(this.id,'div_main',0);">
		</cfif>
		<cfif arguments.userID LT 2 or arguments.userID EQ 12></cfif>
		<input type="button" id="showPost" name="showPost" value="show posts" class="navButtons" style="" onclick="js_requestPost(this.id,'div_main',0);">
		<input type="button" id="searchPost" name="searchPost" value="search posts" class="navButtons" style="" onclick="js_requestPost(this.id,'div_main',0);">	
		<cfif arguments.userID GT 1>
		<input type="button" id="composePost" name="composePost" value="compose post" class="navButtons" style="" onclick="js_requestPost(this.id,'div_main',0);">
		<cfif arguments.messageCount GT 0>
			<cfset lcl_messageText = "messages (#arguments.messageCount#)">
		<cfelse>	
			<cfset lcl_messageText = "messages">
		</cfif>
		<input type="button" id="showMessages" name="showMessages" value="#lcl_messageText#" class="navButtons" style="" onclick="js_requestMessage(this.id,'div_main',0);">
		<input type="button" id="showUserInfo" name="showUserInfo" value="user info" class="navButtons" style="" onclick="js_requestUser(this.id,'div_main',0);">
		</cfif>
		</cfoutput>
	</cfsavecontent>
	<cfreturn s_showNavMenu>
	
	</cffunction>
<!--- End Function --->

</cfcomponent>