<cftry>
<cfapplication name="braddoro.com" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(0,1,0,0)#" applicationtimeout="#CreateTimeSpan(0,1,0,0)#">
<cferror type="exception" template="fail.cfm"> 
<!--- <cfapplication scriptProtect="all"> --->
<cflock timeout="20" type="exclusive" scope="session">
	<cfset session.siteDSN="braddoro">
	<cfset session.siteTitle="braddoro.com">
	<cfset session.siteURL="http://braddoro.com">
	<cfset session.postsToShow=20>
	<cfif not isdefined("session.userID")>
		<cfset session.userID = 0>
	</cfif>
	<cfif not isdefined("session.userGUID")>
		<cfset session.userGUID = 0>
	</cfif>
</cflock>
<cfif isdefined("cookie.userGUID")>
	<cfset session.userGUID = cookie.userGUID>
<cfelse>
	<cfset session.userGUID = "none">
</cfif>
<cfset obj_user = createObject("component","braddoro.user.user_logic").init(dsn=session.siteDSN)>
<cfset q_authenticateUser = obj_user.authenticateUser(userGUID=session.userGUID)>
<cfset session.userID = q_authenticateUser.userID>
<cfset session.siteName = q_authenticateUser.siteName>
<cfset session.userGUID = q_authenticateUser.userGUID>
<cfcookie expires="never" name="userGUID" value="#q_authenticateUser.userGUID#">
<cfcatch type="any">
	<cfif isdefined("session.userID")>
		<cfset obj_error = createObject("component","braddoro.error.error_logic").init(dsn=session.siteDsn)>
		<cfoutput><!--- #obj_error.fail(userID=val(session.userID),message=cfcatch.message,detail=cfcatch.detail,type=cfcatch.type,tagContext=cfcatch.tagContext,remoteIP=cgi.REMOTE_ADDR)#---></cfoutput>
	</cfif>
	<cfabort>
</cfcatch>
</cftry>