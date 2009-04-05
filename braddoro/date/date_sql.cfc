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
		and ((dayOfYear(D.dateData) >= dayOfYear(CURDATE()) 
		and dayOfYear(D.dateData) <= dayOfYear(date_add(CURDATE(), INTERVAL 7 DAY)) and D.recurring = 'Y') or (D.dateData >= CURDATE() and D.dateData <= date_add(CURDATE(), INTERVAL 15 DAY) and D.recurring = 'N'))
		ORDER BY dayOfYear(D.dateData)
	</cfquery>
	
	<cfreturn q_getDate>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="getDateData">
	<cfargument name="dateID" type="numeric" default="0">
	<cfargument name="getNone" type="string" default="No">
	
	<cfquery name="q_getDateData" datasource="#module_dsn#">
		SELECT D.dateID, D.userID, D.dateData, D.dateDescription, D.recurring, D.active, D.private
		FROM braddoro.dyn_dates D
		where
	<cfif arguments.getNone EQ "Yes">
		0=1
	<cfelse>
		0=0
	</cfif> 
	<cfif arguments.dateID GT 0>
		and dateID = #arguments.dateID#
	</cfif>
		ORDER BY D.dateID desc
	</cfquery>
	
	<cfreturn q_getDateData>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="insertDate">
	<cfargument name="userID" type="numeric" required="true">
	<cfargument name="dateData" type="date" required="true">
	<cfargument name="dateDescription" type="string" default="">
	<cfargument name="recurring" type="string" default="Y">
	<cfargument name="active" type="string" default="Y">
	<cfargument name="private" type="string" default="N">
	
	<cfsavecontent variable="_sql">
	<cfoutput>
		insert into braddoro.dyn_dates (userID, dateData, dateDescription, recurring, active, private)
		select #arguments.userID#, '#dateFormat(arguments.dateData,"yyyy-mm-dd")#', '#arguments.dateDescription#', '#arguments.recurring#', '#arguments.active#', '#arguments.private#' 
	</cfoutput>
	</cfsavecontent>	
	<cfquery name="q_updateDate" datasource="#module_dsn#">#preserveSingleQuotes(_sql)#</cfquery>
	<cfquery name="q_insertDate" datasource="#module_dsn#">
		select dateID from braddoro.dyn_dates order by dateID desc limit 1
	</cfquery>

	<!--- debug code --->
	<cfif 1 EQ 0>
	<cfset obj_error = createObject("component","braddoro.error.error_logic").init(dsn=session.siteDsn)>
	<cfset myArray = arrayNew(1)>
	<cfoutput>#obj_error.fail(userID=12,message="sql query",detail=_sql,type="date debugging",tagContext=myArray,remoteIP=cgi.REMOTE_ADDR)#</cfoutput>
	</cfif>
	
	<cfreturn q_insertDate>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="updateDate">
	<cfargument name="dateID" type="numeric" default="0">
	<cfargument name="userID" type="numeric" required="true">
	<cfargument name="dateData" type="date" required="true">
	<cfargument name="dateDescription" type="string" default="">
	<cfargument name="recurring" type="string" default="Y">
	<cfargument name="active" type="string" default="Y">
	<cfargument name="private" type="string" default="N">

	<cfsavecontent variable="_sql">
	<cfoutput>
		update braddoro.dyn_dates set
		userID = #arguments.userID#, 
		dateData = '#dateFormat(arguments.dateData,"yyyy-mm-dd")#', 
		dateDescription = '#arguments.dateDescription#', 
		recurring = '#arguments.recurring#', 
		active = '#arguments.active#', 
		private = '#arguments.private#'
		where dateID = #arguments.dateID#
	</cfoutput>
	</cfsavecontent>	
	<cfquery name="q_updateDate" datasource="#module_dsn#">#preserveSingleQuotes(_sql)#</cfquery>

	<!--- debug code --->
	<cfif 1 EQ 0>
	<cfset obj_error = createObject("component","braddoro.error.error_logic").init(dsn=session.siteDsn)>
	<cfset myArray = arrayNew(1)>
	<cfoutput>#obj_error.fail(userID=12,message="sql query",detail=_sql,type="date debugging",tagContext=myArray,remoteIP=cgi.REMOTE_ADDR)#</cfoutput>
	</cfif>
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