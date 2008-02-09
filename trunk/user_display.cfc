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

</cfcomponent>