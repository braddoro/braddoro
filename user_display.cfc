<cfcomponent displayname="user_display.cfc" output="false">

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="showLogin">

	<cfsavecontent variable="s_showLogin">
		<cfoutput>
		<fieldset>
		<legend>log in</legend>
		<input type="text" id="username" name="username" value="" class="navButtons" style="">
		<input type="password" id="password" name="password" value="" class="navButtons" style="">
		<input type="button" id="authenticateUser" name="authenticateUser" alt="log in" value="log in" title="log in" class="navButtons" onclick="js_buildRequest('authenticateUser','div_main',0);js_buildRequest('showBanner','div_banner',0);">
		</fieldset>
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_showLogin>
</cffunction>
<!--- End Function --->

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="fail">
	<cfargument name="message" type="string" default="">
	<cfargument name="detail" type="string" default="">
	<cfargument name="ExtendedInfo" type="string" default="">

	<cfsavecontent variable="s_fail">
		<cfoutput>
			<img src="http://lh4.google.com/braddoro/R60O1CciJWI/AAAAAAAAAGo/DRYn1oHVukY/s400/fail.jpg" /><br>
			YOU FAIL IT
			<hr>
			#arguments.message#<br>
			#arguments.detail#<br>
			#arguments.ExtendedInfo#<br> 
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_fail>
</cffunction>
<!--- End Function --->

</cfcomponent>