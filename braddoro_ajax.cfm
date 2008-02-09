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
</cflock>

<cfparam name="_html" type="string" default="">
<cfparam name="form.task" type="string" default="">

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
	
	<cfset obj_content_logic = createObject("component","content_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_content_logic.displayPosts(numberToGet=val(session.postsToShow),userID=val(session.userID))#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- showBanner --->
<cfif form.task EQ "showBanner">
	<cfset obj_application = createObject("component","application_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
		<cfoutput>#obj_application.banner(userID=val(session.userID))#</cfoutput>
	</cfsavecontent>
</cfif>

<!--- showPost --->
<cfif form.task EQ "showPost">
	<cfset obj_content_logic = createObject("component","content_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_content_logic.displayPosts(numberToGet=val(session.postsToShow),userID=val(session.userID))#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- searchPost --->
<cfif form.task EQ "searchPost">
	<cfset obj_content_logic = createObject("component","content_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_content_logic.showSearch()#</cfoutput>
	</cfsavecontent>
</cfif>

<cfset objBraddoro = createObject("component","braddoro_display").logic_Init(dsn="braddoro")>
<cfset x = objBraddoro.logic_setConstant(constantName="userID",constantValue=val(session.userID))>

<!--- getSearch --->
<cfif form.task EQ "getSearch">
	<cfsavecontent variable="_html">
	<cfoutput>#objBraddoro.logic_getSearch(topicID=form.topicID,filterString=form.Filter)#</cfoutput>
	</cfsavecontent>
</cfif>

<!--- composePost --->
<cfif form.task EQ "composePost">
	<cfsavecontent variable="_html">
	<cfoutput>#objBraddoro.logic_addPost(getNone=true)#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- addPost --->
<cfif form.task EQ "addPost">
	<cfset x = objBraddoro.sql_insertPost(userID=session.userID,topicID=form.TopicID,title=form.Subject,post=form.Post)>
	<cfsavecontent variable="_html">
	<cfoutput>#objBraddoro.logic_displayPosts(numberToGet=objBraddoro.logic_GetConstant("postsToShow"))#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- editPost --->
<cfif form.task EQ "editPost">
	<cfsavecontent variable="_html">
	<cfoutput>#objBraddoro.logic_addPost(postID=form.itemID)#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- updatePost --->
<cfif form.task EQ "updatePost">
	<cfset obj_content_sql = createObject("component","content_sql").init(dsn=session.siteDsn)>
	<cfset x = obj_content_sql.updatePost(postID=form.itemID,userID=session.userID,topicID=form.TopicID,title=form.Subject,post=form.Post)>
	<cfset obj_content_logic = createObject("component","content_logic").init(dsn=session.siteDsn)>
	<cfsavecontent variable="_html">
	<cfoutput>#obj_content_logic.displayPosts(numberToGet=val(session.postsToShow),userID=val(session.userID))#</cfoutput>
	</cfsavecontent>
</cfif>

<!--- addReply --->
<cfif form.task EQ "addReply">
	<cfsavecontent variable="_html">
	<cfoutput>#objBraddoro.logic_displayReply(postID=int(form.itemID))#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- editReply --->
<cfif form.task EQ "editReply">
	<cfsavecontent variable="_html">
	<cfoutput>#objBraddoro.logic_displayReply(replyID=int(form.itemID))#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- saveReply --->
<cfif form.task EQ "saveReply">
	<cfset x = objBraddoro.sql_insertReply(reply=form.replyText,postID=val(form.itemID))>
	<cfsavecontent variable="_html">
	<cfoutput>#objBraddoro.logic_displayPosts(numberToGet=objBraddoro.logic_GetConstant("postsToShow"))#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- addPost --->
<!--- updateReply --->
<cfif form.task EQ "updateReply">
	<cfset x = objBraddoro.sql_updateReply(reply=form.replyText,replyID=val(form.replyID))>
	<cfsavecontent variable="_html">
	<cfoutput>#objBraddoro.logic_displayPosts(numberToGet=objBraddoro.logic_GetConstant("postsToShow"))#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- showMessages --->
<cfif form.task EQ "showMessages">
	<cfsavecontent variable="_html">
	<cfoutput>#objBraddoro.logic_showMessages(userID=session.userID)#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- saveMessage --->
<cfif form.task EQ "saveMessage">
	<cfsavecontent variable="_html">
	<cfoutput>#objBraddoro.logic_showMessagesOutput(from_userID=val(session.userID),to_userID=val(form.message_userID),messageText=form.messageText)#</cfoutput>
	</cfsavecontent>
</cfif>

<cfoutput>#_html#</cfoutput>