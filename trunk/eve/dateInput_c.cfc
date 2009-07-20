<cfcomponent output="false">
	<cffunction name="showDate" access="package" output="false" returntype="String">
		<cfargument name="fieldName" type="string" required="true">
		<cfargument name="currentDate" type="date" default="">
		
		<cfset s_currentMonth = "">
		<cfset s_currentDay = "">
		<cfset s_currentYear = "">
		<cfif arguments.currentDate NEQ "">
			<cfset s_currentMonth = month(arguments.currentDate)>
			<cfset s_currentDay = day(arguments.currentDate)>
			<cfset s_currentYear = year(arguments.currentDate)>
		</cfif>
		<cfset s_showDate = createObject("component","dateInput_v").showDate(
				fieldName=arguments.fieldName,
				currentMonth=s_currentMonth,
				currentDay=s_currentDay,
				currentYear=s_currentYear
				)>
		
		<cfreturn s_showDate>
	</cffunction>
	<cffunction name="showTime" access="package" output="false" returntype="String">
		<cfargument name="fieldName" type="string" required="true">
		<cfargument name="currentDate" type="date" default="">
		<cfargument name="minuteRange" type="numeric" default="5">
				
		<cfset s_currentHour = "">
		<cfset s_currentMinute = "">
		<cfif arguments.currentDate NEQ "">
			<cfset s_currentHour = hour(arguments.currentDate)>
			<cfset i_mod = val(minute(arguments.currentDate)) MOD val(arguments.minuteRange)>
			<cfset s_currentMinute = val(minute(arguments.currentDate))-i_mod>
		</cfif>
		<cfset s_showTime = createObject("component","dateInput_v").showTime(
				fieldName=arguments.fieldName,
				currentHour=s_currentHour,
				currentMinute=s_currentMinute,
				minuteRange=arguments.minuteRange
				)>
		
		<cfreturn s_showTime>
	</cffunction>
</cfcomponent>