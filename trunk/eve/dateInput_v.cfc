<cfcomponent output="false">
	<cffunction name="showDate" access="package" output="false" returntype="String">
		<cfargument name="fieldName" type="string" required="true">
		<cfargument name="currentDay" type="string" required="true">
		<cfargument name="currentMonth" type="string" required="true">
		<cfargument name="currentYear" type="string" required="true">

		<cfsavecontent variable="s_main"><cfoutput>
			<select id="#arguments.fieldName#_month" name="#arguments.fieldName#_month">
				<option value=""></option><cfloop from="1" to="12" index="i_index"><option value="#i_index#"<cfif arguments.currentMonth NEQ "" and arguments.currentMonth EQ i_index> SELECTED</cfif>>#numberFormat(i_index,"00")#</option></cfloop>
			</select>
			<select id="#arguments.fieldName#_day" name="#arguments.fieldName#_day">
				<option value=""></option><cfloop from="1" to="31" index="i_index"><option value="#i_index#"<cfif arguments.currentDay NEQ "" and arguments.currentDay EQ i_index> SELECTED</cfif>>#numberFormat(i_index,"00")#</option></cfloop>
			</select>
			<select id="#arguments.fieldName#_year" name="#arguments.fieldName#_year">
				<option value=""></option>
				<cfloop from="#year(now())-3#" to="#year(now())+1#" index="i_index">
					<option value="#i_index#"<cfif arguments.currentYear NEQ "" and arguments.currentYear EQ i_index> SELECTED</cfif>>#numberFormat(i_index,"00")#</option>
				</cfloop>
			</select>
		</cfoutput></cfsavecontent>
						
		<cfreturn s_main>
	</cffunction>
	<cffunction name="showTime" access="package" output="false" returntype="String">
		<cfargument name="fieldName" type="string" required="true">
		<cfargument name="currentHour" type="string" required="true">
		<cfargument name="currentMinute" type="string" required="true">

		<cfsavecontent variable="s_main"><cfoutput>
			<select id="#arguments.fieldName#_hour" name="#arguments.fieldName#_hour">
				<option value=""></option><cfloop from="0" to="23" index="i_index"><option value="#i_index#"<cfif arguments.currentHour NEQ "" and arguments.currentHour EQ i_index> SELECTED</cfif>>#numberFormat(i_index,"00")#</option></cfloop>
			</select>
			<select id="#arguments.fieldName#_minute" name="#arguments.fieldName#_minute">
				<option value=""></option><cfloop from="0" to="55" index="i_index" step="5"><option value="#i_index#"<cfif arguments.currentMinute NEQ "" and arguments.currentMinute EQ i_index> SELECTED</cfif>>#numberFormat(i_index,"00")#</option></cfloop>
			</select>
		</cfoutput></cfsavecontent>
						
		<cfreturn s_main>
	</cffunction>
</cfcomponent>