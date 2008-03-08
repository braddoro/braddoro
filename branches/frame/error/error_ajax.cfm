<cftry>
<cfparam name="_html" type="string" default="">
<cfparam name="form.task" type="string" default="">

<cfset obj_error = createObject("component","error_logic").init(dsn=session.siteDsn)>
<cfsavecontent variable="_html">
<cfoutput>#obj_error.ajaxTask(argumentCollection=form)#</cfoutput>
</cfsavecontent>

<cfcatch type="any">
	<cfif isdefined("session.userID")>
		<cfset lcl_userID = val(session.userID)>
	<cfelse>
		<cfset lcl_userID = 0>
	</cfif>
	<cfset obj_error = createObject("component","braddoro.error.error_logic").init(dsn=session.siteDsn)>
	<cfoutput>#obj_error.fail(userID=lcl_userID,message=cfcatch.message,detail=cfcatch.detail,type=cfcatch.type,tagContext=cfcatch.tagContext,remoteIP=cgi.REMOTE_ADDR)#</cfoutput>
</cfcatch>
</cftry>
<cfoutput>#_html#</cfoutput>