<cftry>
<cflock timeout="20" type="exclusive" scope="Session">
	<cfif isdefined("cookie.userGUID")>
		<cfset session.userGUID = cookie.userGUID>
	<cfelse>
		<cfset session.userGUID = "DCDE6DFA-19B9-BA51-EE3FDC1D1A72E094">
	</cfif>
	<cfif not isdefined("session.userID")>
		<cfset session.userID = 1>
	</cfif>
	<cfif not isdefined("session.siteDsn")>
		<cfset session.siteDsn = "braddoro">
	</cfif>
	<cfif not isdefined("session.postsToShow")>
		<cfset session.postsToShow = 20>
	</cfif>
	
</cflock>

<cfparam name="_html" type="string" default="">
<cfparam name="form.task" type="string" default="">

<!---------------------------------------------------------------------------------
-- application tasks 
---------------------------------------------------------------------------------->
<!--- showBanner --->
<cfif form.task EQ "showBanner">
	<cfset obj_application = createObject("component","application_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
		<cfoutput>#obj_application.banner(userID=val(session.userID))#</cfoutput>
	</cfsavecontent>
</cfif>
<!---------------------------------------------------------------------------------
-- User tasks 
---------------------------------------------------------------------------------->
<!--- logIn --->
<cfif form.task EQ "logIn">
	<cfset obj_user_logic = createObject("component","user_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_user_logic.logIn()#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- authenticateUser --->
<cfif form.task EQ "authenticateUser">
	<cfset obj_user_logic = createObject("component","user_logic").init(dsn=session.siteDsn)>
	<cfset q_authenticateUser = obj_user_logic.authenticateUser(username=form.userName,password=form.password,remoteIP=cgi.REMOTE_ADDR)>
	<cfset session.userID = q_authenticateUser.userID>
	<cfset session.siteName = q_authenticateUser.siteName>
	<cfset cookie.userGUID = q_authenticateUser.userGUID>
	
	<cfset obj_post_logic = createObject("component","post_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_post_logic.displayPosts(numberToGet=val(session.postsToShow),userID=val(session.userID))#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- showUserInfo --->
<cfif form.task EQ "showUserInfo">
	<cfset obj_user_logic = createObject("component","user_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_user_logic.showUser(userID=session.userID)#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- saveUserInfo --->
<cfif form.task EQ "saveUserInfo">
	<cfset obj_user_logic = createObject("component","user_logic").init(dsn=session.siteDsn)>
	<cfset x = obj_user_logic.saveUserInfo(argumentCollection=form)>
	<cfset obj_user_logic = createObject("component","user_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_user_logic.showUser(userID=session.userID)#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- register --->
<cfif form.task EQ "register">
	<cfset obj_user_logic = createObject("component","user_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_user_logic.showUser(userID=0)#</cfoutput>
	</cfsavecontent>
</cfif>
<!---------------------------------------------------------------------------------
-- message tasks 
---------------------------------------------------------------------------------->
<!--- showMessages --->
<cfif form.task EQ "showMessages">
	<cfset obj_message_logic = createObject("component","message_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_message_logic.showMessages(userID=val(session.userID))#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- saveMessage --->
<cfif form.task EQ "saveMessage">
	<cfset obj_message_logic = createObject("component","message_logic").init(dsn=session.siteDsn)>
	<cfset x = obj_message_logic.saveMessage(from_userID=val(session.userID),to_userID=val(form.message_userID),messageText=form.messageText)>

	<cfset obj_message_logic = createObject("component","message_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_message_logic.showMessages(userID=val(session.userID))#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- showMessages --->
<cfif form.task EQ "deleteMessage">
	<cfset obj_message_logic = createObject("component","message_logic").init(dsn=session.siteDsn)>
	<cfset x = obj_message_logic.deleteMessage(messageID=val(form.itemID))>

	<cfset obj_message_logic = createObject("component","message_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_message_logic.showMessages(userID=val(session.userID))#</cfoutput>
	</cfsavecontent>

</cfif>
<cfcatch type="any">
	<cfset obj_error = createObject("component","error.error_logic").init(dsn=session.siteDsn,userID=session.userID)>
	<cfoutput>#obj_error.fail(userID=val(session.userID),message=cfcatch.message,detail=cfcatch.detail,type=cfcatch.type,tagContext=cfcatch.tagContext,remoteIP=cgi.REMOTE_ADDR)#</cfoutput>
</cfcatch>
</cftry>
<cfoutput>#_html#</cfoutput>