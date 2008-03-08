<cftry>
<cfset obj_application = createObject("component","braddoro.application.application_logic").init(dsn=session.siteDsn)>
<cfset obj_quote = createObject("component","braddoro.quote.quote_logic").init(dsn=session.siteDsn)>
<cfset obj_date = createObject("component","braddoro.date.date_logic").init(dsn=session.siteDsn,userID=val(session.userID))>
<cfoutput>
#obj_application.javascriptTask()#
#obj_error.javascriptTask()#
#obj_date.javascriptTask()#
<div id="div_top" class="divtop">
<fieldset>
<div id="div_banner" class="banner"><cfoutput>#obj_application.banner(userID=val(session.userID),siteTitle=session.siteTitle)#</cfoutput></div>
<div id="quote" title="click for another quote" style="cursor:default;" onclick="js_requestQuote('randomQuote','quote',0);">#obj_quote.randomQuote()#</div>
<div id="menu">#obj_application.navMenu(userID=val(session.userID))#</div>
</fieldset>
</div>
<div id="div_date" class="divright">#obj_date.showDates()#</div>
<br>
</cfoutput>
<cfcatch type="any">
	<cfif isdefined("session.userID")>
		<cfset lcl_userID = val(session.userID)>
	<cfelse>
		<cfset lcl_userID = 0>
	</cfif>
	<cfset obj_error = createObject("component","error.error_logic").init(dsn=session.siteDsn,userID=val(session.userID))>
	<cfoutput>#obj_error.fail(userID=lcl_userID,message=cfcatch.message,detail=cfcatch.detail,type=cfcatch.type,tagContext=cfcatch.tagContext,remoteIP=cgi.REMOTE_ADDR)#</cfoutput>
</cfcatch>
</cftry>