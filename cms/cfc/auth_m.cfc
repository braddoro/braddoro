<cfcomponent output="false">

	<cffunction name="authenticate" access="package" output="false" returntype="numeric">
		<cfargument name="loginName" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		<cfargument name="dsn" type="string" required="true">
	
		<cfquery datasource="#arguments.dsn#" name="q_authenticate">
			select U.userID 
			from cms.dyn_user U
			inner join cms.dyn_user_password P
			on U.userID = P.userID
			where U.loginName = '#arguments.loginName#' and P.password = '#arguments.password#' and U.isActive = 1
		</cfquery>
	
		<cfreturn val(q_authenticate.userID)>
	</cffunction>
	
	<cffunction name="goodLogin" access="package" output="false" returntype="void">
		<cfargument name="userID" type="numeric" required="true">
		<cfargument name="remoteIP" type="string" required="true">
		<cfargument name="dsn" type="string" required="true">
	
		<cfquery datasource="#arguments.dsn#" name="q_authenticate">
			insert into cms.log_user_login
			  (userID, loginDateTime, remoteIP)
			values
			  (#arguments.userID#, CURRENT_TIMESTAMP(), '#arguments.remoteIP#')
		</cfquery>
	
	</cffunction>
	
	<cffunction name="failedLogin" access="package" output="false" returntype="void">
		<cfargument name="loginName" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		<cfargument name="remoteIP" type="string" required="true">
		<cfargument name="dsn" type="string" required="true">
	
		<cfquery datasource="#arguments.dsn#" name="q_authenticate">
			insert into cms.log_failed_login 
				(loginName, password, attemptDateTime, remoteIP)
			values
			  ('#arguments.loginName#', '#arguments.password#', CURRENT_TIMESTAMP(), '#arguments.remoteIP#')
		</cfquery>
	
	</cffunction>

	<cffunction name="attemptLimit" access="package" output="false" returntype="numeric">
		<cfargument name="remoteIP" type="string" required="true">
		<cfargument name="dsn" type="string" required="true">
		<cfargument name="attemptInterval" type="numeric" required="true">
	
		<cfquery datasource="#arguments.dsn#" name="q_attemptLimit">
			select count(*) as 'attempts' 
			from cms.log_failed_login
			where remoteIP = '#arguments.remoteIP#'
			and attemptDateTime > date_add(now(),INTERVAL -#arguments.attemptInterval# minute)
		</cfquery>
		
		<cfreturn val(q_attemptLimit.attempts)>	
	</cffunction>

	<cffunction name="getUser" access="package" output="false" returntype="query">
		<cfargument name="userID" type="numeric" required="true">
		<cfargument name="publicID" type="string" required="true">
		<cfargument name="dsn" type="string" required="true">
	
		<cfquery datasource="#arguments.dsn#" name="q_getPublicID">
			select userID, publicID 
			from cms.dyn_user 
			where userID = 0
		<cfif arguments.userID GT 0>
			or userID = #arguments.userID#
		</cfif>
		<cfif arguments.publicID NEQ "">
			or publicID = '#arguments.publicID#'
		</cfif>
		</cfquery>
	
		<cfreturn q_getPublicID>
	</cffunction>

	<cffunction name="updatePassword" access="package" output="false" returntype="void">
		<cfargument name="userID" type="numeric" required="true">
		<cfargument name="dsn" type="string" required="true">
		<cfargument name="password" type="string" required="true">
	
		<cfquery datasource="#arguments.dsn#" name="q_getPublicID">
			update cms.dyn_user_password set
			password = '#arguments.password#',
			changeDateTime = CURRENT_TIMESTAMP() 
			where userID = #arguments.userID#
		</cfquery>
	
	</cffunction>

</cfcomponent>