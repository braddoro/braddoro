<cftry>
<cflock timeout="20" type="exclusive" scope="Session">
	<cfif isdefined("cookie.userGUID")>
		<cfset session.userGUID = cookie.userGUID>
	<cfelse>
		<cfset session.userGUID = "DCDE6DFA-19B9-BA51-EE3FDC1D1A72E094">
	</cfif>
	<cfif not isdefined("session.userID")>
		<cfset session.userID = 1>
	</cfif>
	<cfif not isdefined("session.siteDsn")>
		<cfset session.siteDsn = "braddoro">
	</cfif>
	<cfif not isdefined("session.postsToShow")>
		<cfset session.postsToShow = 20>
	</cfif>
	
</cflock>

<cfparam name="_html" type="string" default="">
<cfparam name="form.task" type="string" default="">

<cfset obj_user = createObject("component","quote_logic").init(dsn=session.siteDsn)>
<cfsavecontent variable="_html">
<cfoutput>#obj_user.ajaxTask(argumentCollection=form)#</cfoutput>
</cfsavecontent>

<cfcatch type="any">
	<cfset obj_error = createObject("component","error.error_logic").init(dsn=session.siteDsn,userID=session.userID)>
	<cfoutput>#obj_error.fail(userID=val(session.userID),message=cfcatch.message,detail=cfcatch.detail,type=cfcatch.type,tagContext=cfcatch.tagContext,remoteIP=cgi.REMOTE_ADDR)#</cfoutput>
</cfcatch>
</cftry>
<cfoutput>#_html#</cfoutput>