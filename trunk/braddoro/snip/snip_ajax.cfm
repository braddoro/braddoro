<cftry>
<cfparam name="_html" type="string" default="">
<cfparam name="form.task" type="string" default="">
<cfparam name="s_error" type="string" default="">
<cfset _html = createObject("component","snip_logic").task(argumentCollection=form)>
<cfcatch type="any">
	<cfset s_error = cfcatch.message & " " & cfcatch.detail>
</cfcatch>
</cftry>
<cfoutput>#s_error##_html#</cfoutput>