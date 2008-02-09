<cfcomponent displayname="error_display" output="false">

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="fail">
	<cfargument name="message" type="string" default="">
	<cfargument name="detail" type="string" default="">

	<cfsavecontent variable="s_fail">
		<cfoutput>
			<img src="http://lh5.google.com/braddoro/R60a3SciJXI/AAAAAAAAAHI/bfIezPTzpP0/s400/you_fail_016.jpg" /><br>
			<hr>
			#arguments.message#<br>
			#arguments.detail#<br> 
		</cfoutput>
	</cfsavecontent>

	<cfreturn s_fail>
</cffunction>
<!--- End Function --->

</cfcomponent>