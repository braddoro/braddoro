<cfcomponent output="false">

	<cffunction name="selectUserData" access="public" output="false" returntype="query">
		<cfargument name="userID" type="string" required="true">
		<cfargument name="dsn" type="string" required="true">
	
		<cfset q_selectUserData = createObject("component","user_m").selectUserData(userID=arguments.userID,dsn=arguments.dsn)>
	
		<cfreturn q_selectUserData>
	</cffunction>

	<cffunction name="saveUserData" access="public" output="false" returntype="numeric">
		<cfargument name="dsn" type="string" required="true">
		<cfargument name="userID" type="numeric" required="true">
		<cfargument name="loginName" type="string" default="">
		<cfargument name="password" type="string" default="">
		<cfargument name="prefix" type="string" default="">
		<cfargument name="firstName" type="string" default="">
		<cfargument name="middleName" type="string" default="">
		<cfargument name="lastName" type="string" default="">
		<cfargument name="suffix" type="string" default="">
		<cfargument name="userName" type="string" default="">
		<cfargument name="isActive" type="string" default="">
	
		<cfif arguments.userID GT 0>
			<cfset i_userID = createObject("component","user_m").updateUserData(argumentCollection=arguments)>
		<cfelse>
			<cfset i_userID = createObject("component","user_m").insertUserData(argumentCollection=arguments)>
		</cfif>

		<cfreturn i_userID>
	</cffunction>

</cfcomponent>