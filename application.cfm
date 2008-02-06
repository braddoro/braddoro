<cfapplication name="braddoro.com" sessionmanagement="Yes" sessiontimeout=#CreateTimeSpan(0,1,0,0)# applicationtimeout=#CreateTimeSpan(0,1,0,0)#>
<cflock timeout="20" type="exclusive" scope="Session">
	<cfif isdefined("cookie.userGUID")>
	<cfset session.userGUID = cookie.userGUID>
	<cfelse>
		<cfset session.userGUID = "DCDE6DFA-19B9-BA51-EE3FDC1D1A72E094">
	</cfif>
</cflock>
<cfset objBraddoro = createObject("component","braddoro_display").logic_Init(dsn="braddoro")>
<cfset session.userID = objBraddoro.logic_checkUser(session.userGUID).userID>
<cfset session.siteName = objBraddoro.logic_checkUser(session.userGUID).siteName>
<cfset x = objBraddoro.logic_setConstant(constantName="userID",constantValue="#session.userID#")>