<cfparam name="field1" type="string" default="">
<cfparam name="field2" type="string" default="">
<cfparam name="i_userID" type="numeric" default="0">
<html> 
<head> 
<title>Login</title> 
</head> 
<body>
<cfif field1 NEQ "" and field2 NEQ "">
	<cfset i_userID = createObject("component","common.auth_c").authenticate(loginName=form.field1,password=form.field2,remoteIP="#cgi.REMOTE_ADDR#",dsn="cmsdb",allowedAttempts=5,attemptInterval=2)>
	<cfif i_userID GT 0>
		<cfset session.publicID = createObject("component","common.auth_c").getUser(userID=i_userID,publicID="",dsn="cmsdb").publicID>
		<cflocation url="user_details.cfm" addtoken="false">
	</cfif>
</cfif>
<cfoutput>
<form id="myform" name="myform" action="#GetFileFromPath(GetCurrentTemplatePath())#" method="post">
<input type="text" id="field1" name="field1" value=""><br/>
<input type="text" id="field2" name="field2" value=""><br/>
<input type="submit" id="login" name="login" value="Go">
</form>
</cfoutput>
</body> 
</html>