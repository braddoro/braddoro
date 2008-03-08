<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<title>braddoro.com</title>
<head>
<link href="braddoro/utility/braddoro.css" rel="stylesheet" type="text/css">
</head>
<frameset id="master_frame" class="body" rows="25%,75%">
<frame src="application/application.cfm" frameborder="false" id="head_frame" name="head_frame" noresize="false" scrolling="false">
<frame src="post/post.cfm" frameborder="false" id="main_frame" name="main_frame" noresize="false" scrolling="false">
<noframes>get a real browser</noframes>
</frameset>
</html>
<cftry>
<cfoutput>
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