<cfcomponent output="false">
	
	<cffunction name="showDate" access="public" output="false" returntype="String">
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
	
	<cffunction name="showTime" access="public" output="false" returntype="String">

		<cfargument name="fieldName" type="string" required="true">
		<cfargument name="currentDate" type="string" default="">
		<cfargument name="minuteRange" type="numeric" default="5">
		<cfargument name="use24" type="boolean" default="No">
		<cfargument name="serverOffset" type="numeric" default="1">
				
		<cfset s_currentHour = "">
		<cfset s_currentMinute = "">
		<cfif arguments.currentDate NEQ "">
			<cfif arguments.use24>
				<cfset s_currentHour = hour(arguments.currentDate)+arguments.serverOffset>
				<cfset s_ampm = "">
			<cfelse>
				<cfset s_currentHour = (hour(arguments.currentDate)-12)+arguments.serverOffset>
				<cfif hour(arguments.currentDate) LT 12>
					<cfset s_ampm = "am">
				<cfelse>
					<cfset s_ampm = "pm">
				</cfif>
				
			</cfif>
			<cfset i_mod = val(minute(arguments.currentDate)) MOD val(arguments.minuteRange)>
			<cfset s_currentMinute = val(minute(arguments.currentDate))-i_mod>
		</cfif>
		<cfset s_showTime = createObject("component","dateInput_v").showTime(
				fieldName=arguments.fieldName,
				currentHour=s_currentHour,
				currentMinute=s_currentMinute,
				minuteRange=arguments.minuteRange,
				use24=arguments.use24,
				ampm=s_ampm
				)>
		
		<cfreturn s_showTime>
	</cffunction>
</cfcomponent>