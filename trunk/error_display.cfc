<cfcomponent displayname="error_display" output="false">

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="fail">
	<cfargument name="message" type="string" default="">
	<cfargument name="detail" type="string" default="">
	<cfargument name="tagContext" type="Array" default="">
	<cfargument name="showError" type="string" default="false">
	<cfargument name="remoteIP" type="string" default="false">
	

	<cfsavecontent variable="s_fail">
	<cfoutput>
	<fieldset>
	<legend><strong>fail!</strong></legend>
	<img src="http://lh5.google.com/braddoro/R60a3SciJXI/AAAAAAAAAHI/bfIezPTzpP0/s400/you_fail_016.jpg" /><br>
	<hr>
	#remoteIP#
	<cfif arguments.showError>
		#arguments.message#<br>
		#arguments.detail#<br>
		<cfdump var="#arguments.tagContext#">
	</cfif>
	</fieldset>
	</cfoutput>
	</cfsavecontent>

	<cfreturn s_fail>
</cffunction>
<!--- End Function --->

</cfcomponent>