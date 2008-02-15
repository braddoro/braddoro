<cfcomponent output="false">

<cfproperty name="module_dsn" displayname="module_dsn" type="string" default="">

<cffunction name="init" displayname="init" access="package" output="false">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>

<!--- Begin Function  --->
<cffunction access="package" output="false" returntype="String" name="fail">
	<cfargument name="message" type="string" default="">
	<cfargument name="detail" type="string" default="">
	<cfargument name="type" type="string" default="">
	<cfargument name="tagContext" type="Array" default="">
	<cfargument name="showError" type="string" default="false">
	<cfargument name="remoteIP" type="string" default="false">
	

	<cfsavecontent variable="s_fail">
	<cfoutput>
	<fieldset>
	<legend><strong>you fail!</strong></legend>
	<img src="http://lh5.google.com/braddoro/R60a3SciJXI/AAAAAAAAAHI/bfIezPTzpP0/s400/you_fail_016.jpg" /><br>
	<hr>
	#remoteIP#
	<cfif arguments.showError>
		#arguments.message#<br>
		#arguments.type#<br>
		#arguments.detail#<br>
		<cfdump var="#arguments.tagContext#">
	<cfelse>
	You have arrived here because something unexpected happened on the web site.
	</cfif>
	</fieldset>
	</cfoutput>
	</cfsavecontent>

	<cfreturn s_fail>
</cffunction>
<!--- End Function --->

</cfcomponent>