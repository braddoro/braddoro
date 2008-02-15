<cfcomponent output="false">

<cfproperty name="module_dsn" displayname="module_dsn" type="string" default="">

<cffunction name="init" displayname="init" access="public" output="false">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>


<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="randomQuote">

	<cfset obj_quote_sql = createObject("component","quote_sql").init(dsn=module_dsn)>
	<cfset q_getQuote = obj_quote_sql.randomQuote()>
	<cfset obj_quote_display = createObject("component","quote_display")>
	<cfsavecontent variable="s_randomQuote">
	<cfoutput>#obj_quote_display.randomQuote(quoteQuery=q_getQuote)#</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_randomQuote>
</cffunction>
<!--- End Function --->

<cffunction access="public" output="false" name="showQuoteList">
	<cfargument required="true" type="string" name="outputDiv">
	
	<cfset obj_quote_sql = createObject("component","quote_sql").init(dsn=module_dsn)>
	<cfset q_getQuoteData = obj_quote_sql.getQuoteData()>

	<cfset obj_quote_display = createObject("component","quote_display").init()>
	<cfsavecontent variable="s_showQuoteList">
	<cfoutput>#obj_quote_display.quoteList(
		quoteQuery=q_getQuoteData,
		displayWord="quote list",
		action="viewQuote",
		outputDiv=arguments.outputDiv
		)#</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_showQuoteList>
</cffunction>

<cffunction access="public" output="false" name="viewQuote">
	<cfargument default="0" type="numeric" name="quoteID">
	<cfargument required="true" type="string" name="outputDiv">

	<cfset obj_quote_sql = createObject("component","quote_sql").init(dsn=module_dsn)>
	<cfif arguments.quoteID EQ 0>
		<cfset lcl_getNone="Yes">
	<cfelse>
		<cfset lcl_getNone="No">
	</cfif>
	<cfset q_getQuoteData = obj_quote_sql.getQuoteData(quoteID=arguments.quoteID,getNone=lcl_getNone)>
	<cfset obj_quote_display = createObject("component","quote_display").init()>
	<cfsavecontent variable="s_showQuoteList">
	<cfoutput>#obj_quote_display.quoteInput(
		quoteID=arguments.quoteID,
		quoteQuery=q_getQuoteData,
		displayWord="edit quote",
		action="saveQuote",
		outputDiv=arguments.outputDiv
		)#</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_showQuoteList>
</cffunction>

<cffunction access="public" output="false" name="saveQuote">
	<cfargument required="true" type="string" name="outputDiv">
	<cfargument default="0" type="numeric" name="quoteID">

	<cfset obj_quote_sql = createObject("component","quote_sql").init(dsn=module_dsn)>
	<cfif arguments.quoteID GT 0>
		<cfset x = obj_quote_sql.updateQuote(
			quoteID=arguments.quoteID,
			quoteBy=arguments.quoteBy,
			quoteWhen=arguments.quoteWhen,
			active=arguments.active,
			quote=arguments.quote
			)>
		<cfset newQuoteID = arguments.quoteID>
	<cfelse>
		<cfset newQuoteID = obj_quote_sql.insertQuote(
			quoteBy=arguments.quoteBy,
			quoteWhen=arguments.quoteWhen,
			active=arguments.active,
			quote=arguments.quote
			).quoteID>
	</cfif>
	<cfset obj_quote_display = createObject("component","quote_display").init()>
	<cfsavecontent variable="s_showQuoteList">
	<cfoutput>#obj_quote_display.quoteAction(
		quoteID=val(newQuoteID),
		displayWord="what do you want to do",
		outputDiv=arguments.outputDiv
		)#</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_showQuoteList>
</cffunction>

</cfcomponent>