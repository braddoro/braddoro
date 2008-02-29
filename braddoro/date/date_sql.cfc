<cfcomponent output="false">

<!--- Begin Function --->
<cffunction name="init" displayname="init" access="package" output="false">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="getDate">
	
	<cfquery name="q_getDate" datasource="#module_dsn#">
		SELECT dayName(D.dateData) as 'weekDay', D.dateID, D.userID, D.dateData, D.dateDescription, D.recurring, D.active, D.private
		FROM braddoro.dyn_dates D
		where D.active = 'Y'
		and ((dayOfYear(D.dateData) >= dayOfYear(CURDATE()) and dayOfYear(D.dateData) <= dayOfYear(date_add(CURDATE(), INTERVAL 7 DAY)) and D.recurring = 'Y') or (D.dateData >= CURDATE() and D.dateData <= date_add(CURDATE(), INTERVAL 15 DAY) and D.recurring = 'N'))
		ORDER BY dayOfYear(D.dateData)
	</cfquery>
	
	<cfreturn q_getDate>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="insertDate">
	<cfargument name="userID" type="numeric" required="true">
	<cfargument name="dateData" type="date" required="true">
	<cfargument name="dateDescription" type="string" default="">
	<cfargument name="recurring" type="string" default="Y">
	<cfargument name="active" type="string" default="Y">
	<cfargument name="private" type="string" default="N">
	
	<cfquery name="q_insertDate" datasource="#module_dsn#">
		insert into braddoro.dyn_dates (userID, dateData, dateDescription, recurring, active, private)
		select #arguments.userID#, '#arguments.dateData#', '#arguments.dateDescription#', '#arguments.recurring#', '#arguments.active#', '#arguments.private#' 
	</cfquery>
	
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="deleteDate">
	<cfargument name="dateID" type="numeric" required="true">
	
	<cfquery name="q_deleteDate" datasource="#module_dsn#">
		delete from braddoro.dyn_dates where dateID = #arguments.dateID#
	</cfquery>
	
</cffunction>
<!--- End Function --->

</cfcomponent>