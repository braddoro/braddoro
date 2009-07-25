<cfcomponent output="false">
	
	<cffunction name="selectUserData" access="package" output="false" returntype="query">
		<cfargument name="userID" type="numeric" required="true">
		<cfargument name="dsn" type="string" required="true">

		<cfquery datasource="#arguments.dsn#" name="q_selectUserData">
			select * from cms.dyn_user where userID = #arguments.userID#;
		</cfquery>
		
		<cfreturn q_selectUserData>
	</cffunction>

	<cffunction name="updateUserData" access="package" output="false" returntype="numeric">
		<cfargument name="dsn" type="string" required="true">
		<cfargument name="userID" type="numeric" required="true">
		<cfargument name="loginName" type="string" default="">
		<cfargument name="prefix" type="string" default="">
		<cfargument name="firstName" type="string" default="">
		<cfargument name="middleName" type="string" default="">
		<cfargument name="lastName" type="string" default="">
		<cfargument name="suffix" type="string" default="">
		<cfargument name="userName" type="string" default="">
		<cfargument name="isActive" type="string" default="">

		<cfquery datasource="#arguments.dsn#" name="q_updateUserData">
			update cms.dyn_user set
			  loginName = '#arguments.loginName#',
			  prefix = '#arguments.prefix#',
			  firstName = '#arguments.firstName#',
			  middleName = '#arguments.middleName#',
			  lastName = '#arguments.lastName#',
			  suffix = '#arguments.suffix#',
			  userName = '#arguments.userName#',
			  isActive = #val(arguments.isActive)#
			where userID = #arguments.userID#;
		</cfquery>
		
		<cfreturn arguments.userID>
	</cffunction>

	<cffunction name="insertUserData" access="package" output="false" returntype="numeric">
		<cfargument name="dsn" type="string" required="true">
		<cfargument name="loginName" type="string" default="">
		<cfargument name="password" type="string" default="">
		<cfargument name="prefix" type="string" default="">
		<cfargument name="firstName" type="string" default="">
		<cfargument name="middleName" type="string" default="">
		<cfargument name="lastName" type="string" default="">
		<cfargument name="suffix" type="string" default="">
		<cfargument name="userName" type="string" default="">
		<cfargument name="isActive" type="string" default="">

		<cfquery datasource="#arguments.dsn#" name="q_insert">
			insert into cms.dyn_user (loginName, password, prefix, firstName, middleName, lastName, suffix, userName, isActive, publicID)
			values ('#arguments.loginName#', '#arguments.password#', '#arguments.prefix#', '#arguments.firstName#', '#arguments.middleName#', '#arguments.lastName#', '#arguments.suffix#', '#arguments.userName#', '#arguments.isActive#', UUID());
		</cfquery>
		<cfquery datasource="#arguments.dsn#" name="q_insertUserData">
			select last_insert_id() as 'newID';
		</cfquery>
		
		<cfreturn val(q_insertUserData.newID)>
	</cffunction>

</cfcomponent>