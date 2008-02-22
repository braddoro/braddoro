<cftry>
<cfparam name="_html" type="string" default="">
<cfparam name="form.task" type="string" default="">

<cfset obj_application = createObject("component","application_logic").init(dsn=session.siteDsn)>
<cfsavecontent variable="_html">
<cfoutput>#obj_application.ajaxTask(argumentCollection=form,userID=val(session.userID))#</cfoutput>
</cfsavecontent>

<cfcatch type="any">
	<cfset obj_error = createObject("component","braddoro.error.error_logic").init(dsn=session.siteDsn)>
	<cfoutput>#obj_error.fail(userID=val(session.userID),message=cfcatch.message,detail=cfcatch.detail,type=cfcatch.type,tagContext=cfcatch.tagContext,remoteIP=cgi.REMOTE_ADDR)#</cfoutput>
</cfcatch>
</cftry>
<cfoutput>#_html#</cfoutput>