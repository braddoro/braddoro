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
-- quote tasks 
---------------------------------------------------------------------------------->
<!--- quoteStuff --->
<cfif form.task EQ "quoteStuff">
	<cfset obj_quote_logic = createObject("component","quote_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_quote_logic.showQuoteList(outputDiv="div_main")#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- viewQuote --->
<cfif form.task EQ "viewQuote">
	<cfset obj_quote_logic = createObject("component","quote_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_quote_logic.viewQuote(quoteID=val(form.itemID),outputDiv="div_main")#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- saveQuote --->
<cfif form.task EQ "saveQuote">
	<cfset obj_quote_logic = createObject("component","quote_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_quote_logic.saveQuote(
		outputDiv="div_main",
		quoteID=val(form.itemID),
		quoteBy=form.quoteBy,
		quoteWhen=form.quoteWhen,
		active=form.quoteActive,
		quote=form.quoteText
		)#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- randomQuote --->
<cfif form.task EQ "randomQuote">
	<cfset obj_quote_logic = createObject("component","quote_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_quote_logic.randomQuote()#</cfoutput>
	</cfsavecontent>
</cfif>
<!---------------------------------------------------------------------------------
-- application tasks 
---------------------------------------------------------------------------------->
<!--- getJS --->
<cfif form.task EQ "getJS">
	<cfset obj_application_logic = createObject("component","application_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_application_logic.showJavascript()#</cfoutput>
	</cfsavecontent>
</cfif>
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
-- search tasks 
---------------------------------------------------------------------------------->
<!--- searchPost --->
<cfif form.task EQ "searchPost">
	<cfset obj_post_logic = createObject("component","post_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_post_logic.showSearch()#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- getSearch --->
<cfif form.task EQ "getSearch">
	<cfset obj_post_logic = createObject("component","post_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_post_logic.getSearch(userID=val(session.userID),topicID=form.topicID,filterString=form.Filter,showCount="Yes")#</cfoutput>
	</cfsavecontent>
</cfif>
<!---------------------------------------------------------------------------------
-- post tasks 
---------------------------------------------------------------------------------->
<!--- showPost --->
<cfif form.task EQ "showPost">
	<cfset obj_post_logic = createObject("component","post_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_post_logic.displayPosts(numberToGet=val(session.postsToShow),userID=val(session.userID))#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- composePost --->
<cfif form.task EQ "composePost">
	<cfset obj_post_logic = createObject("component","post_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_post_logic.postInput(getNone=true,userID=val(session.userID))#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- addPost --->
<cfif form.task EQ "addPost">
	<cfset obj_post_logic = createObject("component","post_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_post_logic.postUpdate(userID=val(session.userID),topicID=form.TopicID,title=form.Subject,post=form.Post)#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- editPost --->
<cfif form.task EQ "editPost">
	<cfset obj_post_logic = createObject("component","post_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_post_logic.postInput(userID=val(session.userID),postID=val(form.itemID))#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- updatePost --->
<cfif form.task EQ "updatePost">
	<cfset obj_post_logic = createObject("component","post_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_post_logic.postUpdate(postID=form.itemID,userID=val(session.userID),topicID=form.TopicID,title=form.Subject,post=form.Post)#</cfoutput>
	</cfsavecontent>
	<cfset obj_post_logic = createObject("component","post_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_post_logic.displayPosts(numberToGet=val(session.postsToShow),userID=val(session.userID))#</cfoutput>
	</cfsavecontent>
</cfif>
<!---------------------------------------------------------------------------------
-- reply tasks 
---------------------------------------------------------------------------------->
<!--- addReply --->
<cfif form.task EQ "addReply">
	<cfset obj_post_logic = createObject("component","post_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_post_logic.replyInput(postID=int(form.itemID))#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- editReply --->
<cfif form.task EQ "editReply">
	<cfset obj_post_logic = createObject("component","post_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_post_logic.replyInput(replyID=int(form.itemID))#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- saveReply --->
<cfif form.task EQ "saveReply">
	<cfset obj_post_logic = createObject("component","post_logic").init(dsn=session.siteDsn)>
	<cfset x = obj_post_logic.saveReply(reply=form.replyText,postID=val(form.itemID),userID=val(session.userID))>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_post_logic.displayPosts(numberToGet=val(session.postsToShow),userID=val(session.userID))#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- updateReply --->
<cfif form.task EQ "updateReply">
	<cfset obj_post_logic = createObject("component","post_logic").init(dsn=session.siteDsn)>
	<cfset x = obj_post_logic.saveReply(reply=form.replyText,replyID=val(form.replyID),userID=val(session.userID))>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_post_logic.displayPosts(numberToGet=val(session.postsToShow),userID=val(session.userID))#</cfoutput>
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
<cfcatch type="any">
	<cfset obj_error = createObject("component","error_logic").init(dsn=session.siteDsn)>
	<cfoutput>#obj_error.fail(userID=val(session.userID),message=cfcatch.message,detail=cfcatch.detail,type=cfcatch.type,tagContext=cfcatch.tagContext,remoteIP=cgi.REMOTE_ADDR)#</cfoutput>
</cfcatch>
</cftry>
<cfoutput>#_html#</cfoutput>