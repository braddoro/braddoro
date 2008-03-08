<cftry>
<cfset obj_message = createObject("component","braddoro.message.message_logic").init(dsn=session.siteDsn,userID=val(session.userID))>
<div id="div_main" class="divright">
<cfoutput>
#obj_message.javascriptTask()#
#obj_message.showMessages()#
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