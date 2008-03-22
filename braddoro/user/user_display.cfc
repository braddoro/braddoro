<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction name="init" displayname="init" access="package" output="false">
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="showLogin">

	<cfsavecontent variable="s_showLogin">
		<cfoutput>
		<fieldset>
		<legend>log in</legend>
		<input type="text" id="username" name="username" value="" class="navButtons" style="">
		<input type="password" id="password" name="password" value="" class="navButtons" style="">
		<input type="button" id="authenticateUser" name="authenticateUser" alt="log in" value="log in" title="log in" class="navButtons" onclick="js_requestUser('authenticateUser','div_main',0);js_requestApplication('showBanner','div_banner',0);js_requestPost('showPost','div_main',0);">
		<!--- <hr>
		<a id="register" name="register" href="javascript:js_requestUser('register','div_main',0);">register</a>&nbsp;&nbsp;<a id="resetPassword" name="resetPassword" href="javascript:js_requestUser('resetPassword','div_main',0);">lost password</a> --->
		</fieldset>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_showLogin>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="showUserInput">
	<cfargument name="userQuery" type="query" required="true">
	<cfargument name="legend" type="string" default="user info">

	<cfif isdefined("arguments.userQuery.columnList")>
		<cfloop list="#arguments.userQuery.columnList#" index="c">
			<cfset "lcl_#c#"=arguments.userQuery[c][1]>
		</cfloop>
	</cfif>
	<cfsavecontent variable="s_showLogin">
		<cfoutput>
		<fieldset>
		<legend>#arguments.legend#</legend>
		<input type="hidden" id="userID" name="userID" value="#val(lcl_userID)#">
		Login Name<input type="text" size="20" title="This is the name used to log into this site." id="username" name="username" value="#lcl_username#" class="navButtons" style="display:block;"> 
		Display Name<input type="text" size="20" title="This is the name which is displayed on the site." id="siteName" name="siteName" value="#lcl_siteName#" class="navButtons" style="display:block;">
		Real Name<input type="text" size="20" title="This is your real name; in full or in part, or some facsimile there of." id="realName" name="realName" value="#lcl_realName#" class="navButtons" style="display:block;">
		Web Site<input type="text" size="40" title="Your web site.  Might or might not be used on the site." id="webSite" name="webSite" value="#lcl_webSite#" class="navButtons" style="display:block;">
		Email Address<input type="text" size="40" title="This is not displayed on the site and will be used for password recovery." id="emailAddress" name="emailAddress" value="#lcl_emailAddress#" class="navButtons" style="display:block;">
		Date of Birth<input type="text" size="12" title="Your date of birth." id="dateOfBirth" name="dateOfBirth" value="#dateformat(lcl_dateOfBirth,"mm/dd/yyyy")#" class="navButtons" style="display:block;">
		Zip Code<input type="text" size="5" title="This is not displayed on the site and will be used for password recovery." id="zipCode" name="zipCode" value="#lcl_zipCode#" class="navButtons" style="display:block;">
		<!--- Password<input type="text" size="5" title="" id="password" name="password" value="" class="navButtons" style="display:block;"> --->
		<br>
		<input type="button" id="saveUserInfo" name="saveUserInfo" value="save" class="navButtons" onclick="js_requestUser(this.id,'div_main',0);">
		</fieldset>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_showLogin>
</cffunction>
<!--- End Function --->

</cfcomponent>