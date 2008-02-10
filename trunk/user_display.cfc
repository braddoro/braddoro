<cfcomponent displayname="user_display.cfc" output="false">

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="showLogin">

	<cfsavecontent variable="s_showLogin">
		<cfoutput>
		<fieldset>
		<legend>log in</legend>
		<input type="text" id="username" name="username" value="" class="navButtons" style="">
		<input type="password" id="password" name="password" value="" class="navButtons" style="">
		<input type="button" id="authenticateUser" name="authenticateUser" alt="log in" value="log in" title="log in" class="navButtons" onclick="js_buildRequest('authenticateUser','div_main',0);js_buildRequest('showBanner','div_banner',0);;js_buildRequest('showPost','div_main',0);">
		</fieldset>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_showLogin>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="showUserInput">
	<cfargument name="userQuery" type="query" required="true">

	<cfsavecontent variable="s_showLogin">
		<cfoutput query="arguments.userQuery">
		<fieldset>
		<legend>user info</legend>
		<input type="hidden" id="userID" name="userID" value="#userID#">
		Login Name<input type="text" size="20" title="This is the name used to log into this site." id="username" name="username" value="#username#" class="navButtons" style="display:block;"> 
		Display Name<input type="text" size="20" title="This is the name which is displayed on the site." id="siteName" name="siteName" value="#siteName#" class="navButtons" style="display:block;">
		Real Name<input type="text" size="20" title="This is your real name; in full or in part, or some facsimile there of." id="realName" name="realName" value="#realName#" class="navButtons" style="display:block;">
		Web Site<input type="text" size="40" title="Your web site.  Might or might not be used on the site." id="webSite" name="webSite" value="#webSite#" class="navButtons" style="display:block;">
		Email Address<input type="text" size="40" title="This is not displayed on the site and will be used for password recovery." id="emailAddress" name="emailAddress" value="#emailAddress#" class="navButtons" style="display:block;">
		Date of Birth<input type="text" size="12" title="Your date of bith." id="dateOfBirth" name="dateOfBirth" value="#dateformat(dateOfBirth,"mm/dd/yyyy")#" class="navButtons" style="display:block;">
		Zip Code<input type="text" size="5" title="This is not displayed on the site and will be used for password recovery." id="zipCode" name="zipCode" value="#zipCode#" class="navButtons" style="display:block;">
		<br>
		<input type="button" id="saveUserInfo" name="saveUserInfo" value="save" class="navButtons" onclick="js_buildRequest(this.id,'div_main',0);">
		</fieldset>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_showLogin>
</cffunction>
<!--- End Function --->

</cfcomponent>