<cfset i_userID=createObject("component","cfc.auth_c").getUser(userID=0,publicID=session.publicID,dsn="cmsdb").userID>
<html> 
<head> 
<title>User Information</title> 
</head> 
<body>
<cfif isdefined("form.change") and form.pass2 NEQ "">
	<cfif len(trim(form.pass2)) GT 6 and not compare(form.pass2,form.pass3)>
		<cfset createObject("component","cfc.auth_c").updatePassword(userID=val(form.userID),password=form.pass2,dsn="cmsdb")>
	</cfif>
</cfif>
<cfif isdefined("form.edit")>
	<cfif isdefined("form.isActive")>
		<cfset i_isActive = 1>
	<cfelse>
		<cfset i_isActive = 0>
	</cfif>
	<cfset i_userID = createObject("component","cfc.user_c").saveUserData(
		dsn="cmsdb",
		userID=val(form.userID),
		loginName   = form.loginName,
		prefix      = form.prefix,
		firstName   = form.firstName,
		middleName  = form.middleName ,
		lastName    = form.lastName,
		suffix      = form.suffix,
		userName    = form.userName,
		isActive    = i_isActive
		)>
</cfif>
<cfset q_selectUserData = createObject("component","cfc.user_c").selectUserData(userID=val(i_userID),dsn="cmsdb")>
<cfoutput>
<form id="myform" name="myform" action="#GetFileFromPath(GetCurrentTemplatePath())#" method="post">
<input type="hidden" id="userID" name="userID" value="#q_selectUserData.userID#">
<table>

<tr>
<td>Login Name</td>
<td><input type="text" id="loginName" name="loginName" value="#q_selectUserData.loginName#" size="30"></td>
</tr>

<tr>
<td>User Name</td>
<td><input type="text" id="userName" name="userName" value="#q_selectUserData.userName#" size="30"></td>
</tr>

<tr>
<td>Prefix</td>
<td><input type="text" id="prefix" name="prefix" value="#q_selectUserData.prefix#" size="10"></td>
</tr>

<tr>
<td>First Name</td>
<td><input type="text" id="firstName" name="firstName" value="#q_selectUserData.firstName#" size="30"></td>
</tr>

<tr>
<td>Middle Name</td>
<td><input type="text" id="middleName" name="middleName" value="#q_selectUserData.middleName#" size="30"></td>
</tr>

<tr>
<td>Last Name</td>
<td><input type="text" id="lastName" name="lastName" value="#q_selectUserData.lastName#" size="30"></td>
</tr>

<tr>
<td>Suffix</td>
<td><input type="text" id="suffix" name="suffix" value="#q_selectUserData.suffix#" size="10"></td>
</tr>

<cfset s_checked = "">
<cfif val(q_selectUserData.isActive)>
	<cfset s_checked = "checked">
</cfif>
<tr>
<td>Active</td>
<td><input type="checkbox" id="isActive" name="isActive" value="1" #s_checked#></td>
</tr>

<tr>
<td>&nbsp;</td>
<td><input type="submit" id="edit" name="edit" value="Go"></td>
</tr>
</table>
</form>


<form id="myform2" name="myform2" action="#GetFileFromPath(GetCurrentTemplatePath())#" method="post">
<input type="hidden" id="userID" name="userID" value="#q_selectUserData.userID#">
<table>

<tr>
<td>Old Password</td>
<td><input type="text" id="pass1" name="pass1" value="" size="30"></td>
</tr>

<tr>
<td>New Passsword</td>
<td><input type="text" id="pass2" name="pass2" value="" size="30"></td>
</tr>

<tr>
<td>Passsword Confirm</td>
<td><input type="text" id="pass3" name="pass3" value="" size="30"></td>
</tr>

<tr>
<td>&nbsp;</td>
<td><input type="submit" id="change" name="change" value="Go"></td>
</tr>
</table>
</form>
</cfoutput>
</body> 
</html>