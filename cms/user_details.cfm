<cfif not isdefined("session.publicID")>
	<cflocation url="login.cfm">
</cfif>
<cfset i_userID=createObject("component","common.auth_c").getUser(userID=0,publicID=session.publicID,dsn="cmsdb").userID>
<cfif isdefined("form.submit_password") and form.pass2 NEQ "">
	<cfif len(trim(form.pass2)) GT 6 and not compare(form.pass2,form.pass3)>
		<cfset createObject("component","common.auth_c").updatePassword(userID=val(form.userID),password=form.pass2,dsn="cmsdb")>
	</cfif>
</cfif>
<cfif isdefined("form.submit_name")>
	<cfif isdefined("form.isActive")>
		<cfset i_isActive = 1>
	<cfelse>
		<cfset i_isActive = 0>
	</cfif>
	<cfset i_userID = createObject("component","common.user_c").saveUserData(
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
<cfset q_selectUserData = createObject("component","common.user_c").selectUserData(userID=val(i_userID),dsn="cmsdb")>
<cfset i_userID = q_selectUserData.userID>
<html> 
<head> 
<title>User Information</title>
<style media="screen" type="text/css">
.base {font-family : Arial , Helvetica , sans-serif;background-color : #F1EFDE;font-size:.9em;}
.leftcol {width:150px;text-align:right;}
.toptab {background-color:#78866B;color:#FFFFFF;width:220px;padding:3px;}
.inputtable {width:500px;border:1px solid #708090;font-size:.9em;}
.headerlabel {font-family : Arial , Helvetica , sans-serif;background-color : #F1EFDE;font-size:1.125em;color: #708090;font-weight:bold;}
}
</style>
<script language="javascript">
function js_collapseThis(changeme,showType) {
	var s_showType = "block";
	if (arguments.length == 2) {
		s_showType = showType; 
	}
	if (document.getElementById(changeme).style.display == "none") {
		document.getElementById(changeme).style.display = s_showType;
	} else {
		document.getElementById(changeme).style.display = "none";
	}
}
</script>
</head> 
<body class="base">
<div class="headerlabel">User Information</div><br>
<cfoutput>
<form id="frm_name" name="frm_name" action="#GetFileFromPath(GetCurrentTemplatePath())#" method="post">
<div id="div_name_head" style="cursor: hand;" onclick="js_collapseThis('div_name_body');" class="toptab" title="Click to show or hide text.">Name</div>
<div id="div_name_body" style="display:inline;">
	<input type="hidden" id="userID" name="userID" value="#i_userID#">
	<table class="inputtable">
	
	<tr>
	<td class="leftcol">Login Name</td>
	<td><input type="text" id="loginName" name="loginName" value="#q_selectUserData.loginName#" size="30"></td>
	</tr>
	
	<tr>
	<td class="leftcol">User Name</td>
	<td><input type="text" id="userName" name="userName" value="#q_selectUserData.userName#" size="30"></td>
	</tr>
	
	<tr>
	<td class="leftcol">Prefix</td>
	<td><input type="text" id="prefix" name="prefix" value="#q_selectUserData.prefix#" size="10"></td>
	</tr>
	
	<tr>
	<td class="leftcol">First Name</td>
	<td><input type="text" id="firstName" name="firstName" value="#q_selectUserData.firstName#" size="30"></td>
	</tr>
	
	<tr>
	<td class="leftcol">Middle Name</td>
	<td><input type="text" id="middleName" name="middleName" value="#q_selectUserData.middleName#" size="30"></td>
	</tr>
	
	<tr>
	<td class="leftcol">Last Name</td>
	<td><input type="text" id="lastName" name="lastName" value="#q_selectUserData.lastName#" size="30"></td>
	</tr>
	
	<tr>
	<td class="leftcol">Suffix</td>
	<td><input type="text" id="suffix" name="suffix" value="#q_selectUserData.suffix#" size="10"></td>
	</tr>
	
	<cfset s_checked = "">
	<cfif val(q_selectUserData.isActive)>
		<cfset s_checked = "checked">
	</cfif>
	<tr>
	<td class="leftcol">Active</td>
	<td><input type="checkbox" id="isActive" name="isActive" value="1" #s_checked#></td>
	</tr>
	
	<tr>
	<td class="leftcol">&nbsp;</td>
	<td><input type="submit" id="submit_name" name="submit_name" value="Go"></td>
	</tr>
	
	</table>
</div>
</form>
<form id="frm_number" name="frm_number" action="#GetFileFromPath(GetCurrentTemplatePath())#" method="post">
<div id="div_number_head" style="cursor: hand;" onclick="js_collapseThis('div_number_body');" class="toptab" title="Click to show or hide text.">Number</div>
<div id="div_number_body" style="display:inline;">
	<input type="hidden" id="userID" name="userID" value="#i_userID#">
	<table class="inputtable">
		
	<tr>
	<td class="leftcol">New Number</td>
	<td><input type="text" id="input" name="input" value="" size="30"></td>
	</tr>

	<tr>
	<td class="leftcol">Description</td>
	<td><input type="text" id="description" name="description" value="" size="50"></td>
	</tr>
	
	<tr>
	<td class="leftcol">&nbsp;</td>
	<td><input type="submit" id="address" name="address" value="Go"></td>
	</tr>
	
	</table>
</div>
</form>
<form id="frm_date" name="frm_date" action="#GetFileFromPath(GetCurrentTemplatePath())#" method="post">
<div id="div_date_head" style="cursor: hand;" onclick="js_collapseThis('div_date_body');" class="toptab" title="Click to show or hide text.">Date</div>
<div id="div_date_body" style="display:inline;">
	<input type="hidden" id="userID" name="userID" value="#i_userID#">
	<table class="inputtable">
	
	<tr>
	<td class="leftcol">New Date</td>
	<td>#createObject("component","common.dateInput_c").showDate(currentDate=dateformat(now(),"mm/dd/yyyy"),fieldName="newDate")#</td>
	</tr>

	<tr>
	<td class="leftcol">Description</td>
	<td><input type="text" id="description" name="description" value="" size="50"></td>
	</tr>
	
	<tr>
	<td class="leftcol">&nbsp;</td>
	<td><input type="submit" id="submit_date" name="submit_date" value="Go"></td>
	</tr>

	</table>
</div>
</form>
<form id="frm_pass" name="frm_pass" action="#GetFileFromPath(GetCurrentTemplatePath())#" method="post">
<div id="div_pass_head" style="cursor: hand;" onclick="js_collapseThis('div_pass_body');" class="toptab" title="Click to show or hide text." style="display:inline;">Change Password</div>
<div id="div_pass_body" style="display:inline;">
	<input type="hidden" id="userID" name="userID" value="#i_userID#">
	<table class="inputtable">
	
	<tr>
	<td class="leftcol">Old Password</td>
	<td><input type="text" id="pass1" name="pass1" value="" size="30"></td>
	</tr>
	
	<tr>
	<td class="leftcol">New Passsword</td>
	<td><input type="text" id="pass2" name="pass2" value="" size="30"></td>
	</tr>
	
	<tr>
	<td class="leftcol">Passsword Confirm</td>
	<td><input type="text" id="pass3" name="pass3" value="" size="30"></td>
	</tr>
	
	<tr>
	<td class="leftcol">&nbsp;</td>
	<td><input type="submit" id="submit_password" name="submit_password" value="Go"></td>
	</tr>
	
	</table>
</div>
</form>
</cfoutput>
</body> 
</html>