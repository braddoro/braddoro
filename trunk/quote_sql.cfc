<cfcomponent output="false">

<cfproperty name="module_dsn" displayname="module_dsn" type="string" default="">

<cffunction name="init" displayname="init" access="public" output="false">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="randomQuote">
	
	<cfquery name="q_randomQuote" datasource="#module_dsn#">
		select quote, quoteby, quoteWhen from braddoro.cfg_quotes where active = 'Y' order by rand() limit 1
	</cfquery>
	<cfreturn q_randomQuote>
</cffunction>
<!--- End Function --->



<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="getQuote">
	
	<cfquery name="q_getQuote" datasource="#module_dsn#">
		select quote, quoteby, quoteWhen from braddoro.cfg_quotes where active = 'Y' order by rand() limit 1
	</cfquery>
	<cfreturn q_getQuote>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="getQuoteData">
	<cfargument name="quoteID" type="numeric" default="0">
	<cfargument name="active" type="string" default="">
	<cfargument name="getNone" type="string" default="No">
	
	<cfquery name="q_getQuoteData" datasource="#module_dsn#">
		select quoteID, quote, quoteby, quoteWhen, active 
		from braddoro.cfg_quotes
		where
	<cfif arguments.getNone Eq "Yes">
		0=1
	<cfelse>
		0=0
	</cfif> 
	<cfif arguments.quoteID GT 0>
		and quoteID = #arguments.quoteID#
	</cfif>
	<cfif arguments.active NEQ "">
		and active = '#arguments.active#'
	</cfif>
		order by quoteID desc
	</cfquery>
	
	<cfreturn q_getQuoteData>
</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="void" name="updateQuote">
	<cfargument name="quoteID" type="numeric" required="true">
	
	<cfquery name="q_updateQuote" datasource="#module_dsn#">
		update braddoro.cfg_quotes set
		active = '#arguments.active#',
		quoteWhen = '#arguments.quoteWhen#',
		quoteby = '#arguments.quoteby#',
		quote = '#arguments.quote#'
		where quoteID = #arguments.quoteID#
	</cfquery>

</cffunction>
<!--- End Function --->

<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="insertQuote">
	
	<cfquery name="q_insertQuote0" datasource="#module_dsn#">
		insert into braddoro.cfg_quotes (active,quoteWhen,quoteby,quote) select '#arguments.active#', '#arguments.quoteWhen#', '#arguments.quoteby#', '#arguments.quote#';
	</cfquery>

	<cfquery name="q_insertQuote" datasource="#module_dsn#">
		select quoteID from braddoro.cfg_quotes order by quoteID desc limit 1
	</cfquery>
<!--- 
		SELECT @newID := mysql_insert_id() ;
		SELECT @newID AS quoteID 		

		SELECT @newID := mysql_insert_id() ;
		SELECT @newID AS quoteID 		

SELECT @newID := LAST_INSERT_ID();
insert into braddoro.cfg_quotes (active,quoteWhen,quoteby,quote) values('#arguments.active#', '#arguments.quoteWhen#', '#arguments.quoteby#', '#arguments.quote#');
SELECT @newID := LAST_INSERT_ID();
SELECT @newID AS newID

INSERT INTO braddoro.cfg_quotes(active,quoteWhen,quoteby,quote)
VALUES ('a', 'foo', 'baz', 'aa');
SELECT @newID := LAST_INSERT_ID( ) ;
SELECT @newID AS newID 		
 --->
	<cfreturn q_insertQuote>
</cffunction>
<!--- End Function --->

</cfcomponent>