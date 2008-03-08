<cftry>
<cfset obj_user = createObject("component","braddoro.user.user_logic").init(dsn=session.siteDsn)>
<div id="div_main" class="divright">
<cfoutput>
#obj_user.javascriptTask()#
#obj_user.showUser()#
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