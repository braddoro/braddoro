<cftry>
<cfset obj_quote = createObject("component","braddoro.quote.quote_logic").init(dsn=session.siteDsn)>
<div id="div_main" class="divright">
<cfoutput>
#obj_quote.javascriptTask()#
#obj_quote.showQuoteList()#
</cfoutput>
</div>
<cfcatch type="any">
	<cfif isdefined("session.userID")>
		<cfset lcl_userID = val(session.userID)>
	<cfelse>
		<cfset lcl_userID = 0>
	</cfif>
	<cfset obj_error = createObject("component","error.error_logic").init(dsn=session.siteDsn,userID=val(session.userID))>
	<cfoutput>#obj_error.fail(userID=lcl_userID,message=cfcatch.message,detail=cfcatch.detail,type=cfcatch.type,tagContext=cfcatch.tagContext,remoteIP=cgi.REMOTE_ADDR)#</cfoutput>
</cfcatch>
</cftry>