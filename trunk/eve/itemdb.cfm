<cfparam name="form.typeName" type="string" default="">
<cfparam name="form.description" type="string" default="">
<cfparam name="form.groupID" type="numeric" default="0">
<cfparam name="form.marketGroupID" type="numeric" default="0">
<cfparam name="form.raceID" type="numeric" default="0">
<cfparam name="form.twoColumnOutput" type="string" default="">
<cfparam name="form.typeID" type="numeric" default="0">
<cfoutput>
<link href="braddoro.css" rel="stylesheet" type="text/css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
</head>
<body class="body">
<form action="itemdb.cfm" method="post" class="mediumtext">
<cfquery datasource="braddoro" name="q_raceID">
SELECT raceID, raceName FROM braddoro.chrraces where raceID > 0 ORDER BY raceName
</cfquery>
<select id="raceID" name="raceID">
<option value="0">Select a Race</option>
<cfloop query="q_raceID">
<option value="#raceID#"<cfif q_raceID.raceID EQ form.raceID> SELECTED</cfif>>#raceName#</option>	
</cfloop>
</select><br>
<cfquery datasource="braddoro" name="q_marketGroupID">
SELECT distinct marketGroupID, marketGroupName FROM braddoro.invmarketgroups where marketGroupID > 0 ORDER BY marketGroupName
</cfquery>
<select id="marketGroupID" name="marketGroupID">
<option value="0">Select a Market Group</option>
<cfloop query="q_marketGroupID">
<option value="#marketGroupID#"<cfif q_marketGroupID.marketGroupID EQ form.marketGroupID> SELECTED</cfif>>#marketGroupName#</option>	
</cfloop>
</select><br>
<cfquery datasource="braddoro" name="q_groupID">
SELECT groupID, groupName FROM braddoro.invgroups where groupID > 0 ORDER BY groupName
</cfquery>
<select id="groupID" name="groupID">
<option value="0">Select a Group</option>
<cfloop query="q_groupID">
<option value="#groupID#"<cfif q_groupID.groupID EQ form.groupID> SELECTED</cfif>>#groupName#</option>	
</cfloop>
</select><br>
typeID: <input type="text" id="typeID" name = "typeID" value="#form.typeID#"><br>
typeName: <input type="text" id="typeName" name = "typeName" value="#form.typeName#"><br>
description: <input type="text" id="description" name = "description" value="#form.description#"><br>
only show 2 columns <input type="checkbox" id="twoColumnOutput" name="twoColumnOutput" value="checked" #form.twoColumnOutput#><br>
<input type="submit" value="Submit" /><br>
</form>
<cfset b_noLimit = false>
<cfquery datasource="braddoro" name="q_itemDB">
SELECT I.typeID, I.typeName 
<cfif not form.twoColumnOutput EQ "checked">
, I.description, I.graphicID, I.raceID, I.marketGroupID, G.groupName, I.groupID
</cfif>
FROM braddoro.invtypes I
inner join braddoro.invgroups G
on I.groupID = G.groupID
WHERE I.marketGroupID > 0
<cfif form.raceID GT 0>
	<cfset b_noLimit = true>
	and I.raceID = #form.raceID#
</cfif>
<cfif form.marketGroupID GT 0>
	<cfset b_noLimit = true>
	and I.marketGroupID = #form.marketGroupID#
</cfif>
<cfif form.typeID GT 0>
	<cfset b_noLimit = true>
	and I.typeID = #val(form.typeID)#
</cfif>
<cfif form.groupID GT 0>
	<cfset b_noLimit = true>
	and I.groupID = #form.groupID#
</cfif>
<cfif form.typeName NEQ "">
	and I.typeName like '%#form.typeName#%'
</cfif>
<cfif form.description NEQ "">
	and I.description like '%#form.description#%'
</cfif>
ORDER BY I.typeName
<cfif not b_Nolimit>
limit 1000
</cfif>
</cfquery>
<div id="div_top" class="divtop">
<cfif isdefined("q_itemDB")><strong>Results: #q_itemDB.recordCount#</strong></cfif>
<table style="border-collapse:collapse;" border="0">
<tr style="color:white;background-color:navy;">
<th>typeID</th>
<th>typeName</th>
<cfif not form.twoColumnOutput EQ "checked">
<th>groupName</th>
<th>description</th>
<th>graphicID</th>
<th>raceID</th>
<th>marketGroupID</th>
</cfif>
</tr>
<cfloop query="q_itemDB">
	<cfif currentRow MOD 2><cfset s_bgcolor = "##EFEFEF"><cfelse><cfset s_bgcolor = "A3A3A3"></cfif>
	<tr bgcolor="#s_bgcolor#">
	<td>#typeID#</td>
	<td>#typeName#</td>
<cfif not form.twoColumnOutput EQ "checked">
	<td>#groupName#</td>
	<td>#description#</td>
	<td>#graphicID#</td>
	<td>#raceID#</td>
	<td>#marketGroupID#</td>
</cfif>		
	</tr>
</cfloop>
</table>
</div>
</body>
</html>
</cfoutput>
<!--- <cftry> --->
<!--- <cfcatch type="any">
	<cfoutput>#cfcatch.message##
		#cfcatch.detail#
		#cfcatch.type#
		#cfcatch.tagContext#
		#cgi.REMOTE_ADDR#
	</cfoutput>
</cfcatch>
</cftry> --->