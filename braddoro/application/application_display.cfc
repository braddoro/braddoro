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

	<cfsavecontent variable="s_showBanner">
		<cfoutput>#siteTitle#<cfif arguments.siteName NEQ ""><span class="mediumtext"> - #arguments.siteName#</span></cfif></cfoutput>
	</cfsavecontent>
	
	<cfreturn s_showBanner>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="showNavMenu">
	<cfargument name="userID" type="numeric" default="1">
	
	<cfsavecontent variable="s_showNavMenu">
		<cfoutput>
		<cfif arguments.userID EQ 12>
		<input type="button" id="quoteStuff" name="quoteStuff" value="quotes" class="navButtons" style="" onclick="js_requestQuote(this.id,'div_main',0);">
		<input type="button" id="showErrors" name="showErrors" value="errors" class="navButtons" style="" onclick="js_requestError(this.id,'div_main',0);">
		</cfif>
		<cfif arguments.userID LT 2 or arguments.userID EQ 12>
		<input type="button" id="logIn" name="logIn" value="log in" class="navButtons" style="" onclick="js_requestUser(this.id,'div_main',0);">
		</cfif>
		<input type="button" id="showPost" name="showPost" value="show posts" class="navButtons" style="" onclick="js_requestPost(this.id,'div_main',0);">
		<input type="button" id="searchPost" name="searchPost" value="search posts" class="navButtons" style="" onclick="js_requestPost(this.id,'div_main',0);">	
		<cfif arguments.userID GT 1>
		<input type="button" id="composePost" name="composePost" value="compose post" class="navButtons" style="" onclick="js_requestPost(this.id,'div_main',0);">
		<input type="button" id="showMessages" name="showMessages" value="messages" class="navButtons" style="" onclick="js_requestMessage(this.id,'div_main',0);">
		<input type="button" id="showUserInfo" name="showUserInfo" value="user info" class="navButtons" style="" onclick="js_requestUser(this.id,'div_main',0);">
		</cfif>
		</cfoutput>
	</cfsavecontent>
	<cfreturn s_showNavMenu>
	
	</cffunction>
<!--- End Function --->

</cfcomponent>