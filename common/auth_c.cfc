<cfcomponent output="false">

	<cffunction name="authenticate" access="public" output="false" returntype="numeric">
		<cfargument name="loginName" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		<cfargument name="remoteIP" type="string" required="true">
		<cfargument name="dsn" type="string" required="true">
		<cfargument name="allowedAttempts" type="numeric" required="true">
		<cfargument name="attemptInterval" type="numeric" required="true">
	
		<cfset i_userID = 0>
		<cfif this.attemptLimit(allowedAttempts=arguments.allowedAttempts,attemptInterval=arguments.attemptInterval,remoteIP=arguments.remoteIP,dsn=arguments.dsn)>
			<cfset objThis_m = createObject("component","auth_m")>
			<cfset i_userID = objThis_m.authenticate(loginName=arguments.loginName,password=arguments.password,dsn=arguments.dsn)>
			<cfif i_userID>
				<cfset objThis_m.goodLogin(userID=i_userID,remoteIP=arguments.remoteIP,dsn=arguments.dsn)>
			<cfelse>
				<cfset objThis_m.failedLogin(loginName=arguments.loginName,password=arguments.password,remoteIP=arguments.remoteIP,dsn=arguments.dsn)>
			</cfif>
		<cfelse>
			<cfset createObject("component","auth_m").failedLogin(loginName=arguments.loginName,password=arguments.password,remoteIP=arguments.remoteIP,dsn=arguments.dsn)>
			<cfset i_userID = -1>
		</cfif>
	
		<cfreturn i_userID>
	</cffunction>
	
	<cffunction name="attemptLimit" access="package" output="false" returntype="boolean">
		<cfargument name="remoteIP" type="string" required="true">
		<cfargument name="dsn" type="string" required="true">
		<cfargument name="allowedAttempts" type="numeric" required="true">
		<cfargument name="attemptInterval" type="numeric" required="true">
	
		<cfset i_attempts = createObject("component","auth_m").attemptLimit(remoteIP=arguments.remoteIP,dsn=arguments.dsn,attemptInterval=arguments.attemptInterval)>
		<cfset b_allow = true>
		<cfif i_attempts GT arguments.allowedAttempts>
			<cfset b_allow = false>
		</cfif>

		<cfreturn b_allow>
	</cffunction>

	<cffunction name="getUser" access="public" output="false" returntype="query">
		<cfargument name="userID" type="numeric" default="0">
		<cfargument name="publicID" type="string" default="0">
		<cfargument name="dsn" type="string" required="true">
	
		<cfset q_getUser = createObject("component","auth_m").getUser(userID=arguments.userID,publicID=arguments.publicID,dsn=arguments.dsn)>
	
		<cfreturn q_getUser>
	</cffunction>

	<cffunction name="updatePassword" access="public" output="false" returntype="boolean">
		<cfargument name="userID" type="numeric" default="0">
		<cfargument name="password" type="string" default="0">
		<cfargument name="dsn" type="string" required="true">
	
		<cfset createObject("component","auth_m").updatePassword(userID=arguments.userID,password=arguments.password,dsn=arguments.dsn)>
	
		<cfreturn 1>
	</cffunction>

</cfcomponent>