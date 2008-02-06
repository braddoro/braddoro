<cfset objBraddoro = createObject("component","braddoro_display").logic_Init(dsn="braddoro")>
<cfset x = objBraddoro.logic_setConstant(constantName="userID",constantValue=val(session.userID))>
<cfparam name="_html" type="string" default="">
<cfparam name="form.task" type="string" default="">
<cfscript>
function SQLSafe(string) {
  var sqlList = "-- ,'";
  var replacementList = "#chr(38)##chr(35)##chr(52)##chr(53)##chr(59)##chr(38)##chr(35)##chr(52)##chr(53)##chr(59)# , #chr(38)##chr(35)##chr(51)##chr(57)##chr(59)#";
  return trim(replaceList(string,sqlList,replacementList));
}
</cfscript>

<!--- showPost --->
<cfif form.task EQ "showPost">
	<cfsavecontent variable="_html">
	<cfoutput>#objBraddoro.logic_displayPosts(numberToGet=objBraddoro.logic_GetConstant("postsToShow"))#</cfoutput>
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
<!--- searchPost --->
<cfif form.task EQ "searchPost">
	<cfsavecontent variable="_html">
	<cfoutput>#objBraddoro.logic_showSearch()#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- getSearch --->
<cfif form.task EQ "getSearch">
	<cfsavecontent variable="_html">
	<cfoutput>#objBraddoro.logic_getSearch(topicID=form.topicID,filterString=form.Filter)#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- editPost --->
<cfif form.task EQ "editPost">
	<cfsavecontent variable="_html">
	<cfoutput>#objBraddoro.logic_addPost(postID=form.itemID)#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- logIn --->
<cfif form.task EQ "logIn">
	<cfsavecontent variable="_html">
	<cfoutput>#objBraddoro.logic_logIn()#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- authenticateUser --->
<cfif form.task EQ "authenticateUser">
	<cfset x = objBraddoro.logic_authenticateUser(username=form.userName,password=form.password,remoteIP=cgi.REMOTE_ADDR)>
	<cfsavecontent variable="_html">
	<cfoutput>#objBraddoro.logic_displayPosts(numberToGet=objBraddoro.logic_GetConstant("postsToShow"))#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- showBanner --->
<cfif form.task EQ "showBanner">
	<cfsavecontent variable="_html">
	<cfoutput>#objBraddoro.display_showBanner(siteName=session.siteName)#</cfoutput>
	</cfsavecontent>
</cfif>
<!--- searchPost --->
<cfif form.task EQ "updatePost">
	<cfset x = objBraddoro.sql_updatePost(
		postID=form.itemID,
		userID=session.userID,
		topicID=form.TopicID,
		title=form.Subject,
		post=form.Post
		)>
	<cfsavecontent variable="_html">
		<cfoutput>#objBraddoro.logic_displayPosts(numberToGet=objBraddoro.logic_GetConstant("postsToShow"))#</cfoutput>
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

<cfoutput>#_html#</cfoutput>