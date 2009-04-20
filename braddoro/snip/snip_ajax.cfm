<cftry>
<cfparam name="_html" type="string" default="">
<cfparam name="form.task" type="string" default="">

<cfset _html = createObject("component","snip_logic").task(argumentCollection=form)>

<cfcatch type="any">
	<cfset s_error = cfcatch.message & " " & cfcatch.detail>
	<cfoutput>#s_error#</cfoutput>	
	<cfabort>
</cfcatch>
</cftry>
<cfoutput>#_html#</cfoutput>