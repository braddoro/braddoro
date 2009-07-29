<cfparam name="task" type="string" default="home">
<cfparam name="form.sortDir" type="string" default="ASC">
<!--- <cfparam name="form.filter_actionTypeID" type="numeric" default="0"> --->
<cfparam name="p" type="numeric" default="0">
<cfset s_filename = GetFileFromPath(GetCurrentTemplatePath())>
<cfset s_pageName = "Actions">
<cfset objDropdown = createObject("component","common.dropdown_c")>
<cfset objDateInput = createObject("component","common.dateInput_c")>
<cfoutput>
<cfif isdefined("form.submit_action") and isdefined("form.actionID") and isdefined("form.task") and form.task EQ "edit">
	<cfset s_actionDateTime = "#form.actionDateTime_year#-#numberformat(form.actionDateTime_month,'00')#-#numberformat(form.actionDateTime_day,'00')# #numberformat(form.actionDateTime_hour,'00')#:#numberformat(form.actionDateTime_minute,'00')#">
	<cfif val(form.actionID) GT 0>
		<cfquery datasource="cmsdb" name="q_actions">
			update cms.log_actions set
			  actionTypeID = #val(form.actionTypeID)#,
			  actionDateTime = '#s_actionDateTime#',
			  action = '#form.action#',
			  description = '#form.description#'
			where actionID = #val(form.actionID)# 
		</cfquery>
	<cfelse>
		<cfquery datasource="cmsdb" name="q_actions">
			insert into cms.log_actions (actionTypeID, actionDateTime, action, description)
			values (#val(form.actionTypeID)#, '#s_actionDateTime#', '#form.action#', '#form.description#')
		</cfquery>
	</cfif>
	<cfset task = "home">
</cfif>
<cfswitch expression="#task#">
<cfcase value="edit">
</cfcase>
</cfswitch>
<cfif isdefined("form.submit_filter")>
	<cfset s_showFilter = "block">
<cfelse>
	<cfset s_showFilter = "none">
</cfif>
<!--- Begin HTML --->
<html> 
<head> 
<title>#s_pageName#</title>
<style media="screen" type="text/css">
.base {font-family : Arial , Helvetica , sans-serif;background-color : ##F1EFDE;font-size:.9em;}
.leftcol {width:150px;text-align:right;background-color:##A6A68C;}
.toptab {background-color:##78866B;color:##FFFFFF;width:220px;padding:3px;}
.header {background-color:##78866B;color:##FFFFFF;padding:2px;}
.detail {padding:2px;}
.inputtable {border:1px solid ##708090;font-size:.9em;border-collapse:collapse;padding:2px;}
.inputtablenob {##708090;font-size:.9em;border-collapse:collapse;padding:2px;}
.headerlabel {font-family : Arial , Helvetica , sans-serif;background-color : ##F1EFDE;font-size:1.125em;color: ##708090;font-weight:bold;}
.headersmall {font-family : Arial , Helvetica , sans-serif;background-color : ##F1EFDE;font-size:.9sem;color: ##708090;font-weight:bold;}
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
<div class="headerlabel">#s_pageName#</div><br>
<cfswitch expression="#task#">
<cfcase value="edit">
	<cfquery datasource="cmsdb" name="q_edit">
		select * from cms.log_actions where actionID = #p#
	</cfquery>
	<cfif val(q_edit.actionID) GT 0>
		<cfset s_value = "Save">
		<cfset s_postDate = dateformat(q_edit.actionDateTime,"mm/dd/yyyy")>
		<cfset s_postTime = timeformat(q_edit.actionDateTime,"hh:mm TT")>
	<cfelse>
		<cfset s_value = "Add">
		<cfset s_postDate = dateformat(now(),"mm/dd/yyyy")>
		<cfset s_postTime = timeformat(now(),"hh:mm TT")>
	</cfif>
	<a href="#s_filename#?task=home">home</a>
	<form id="frm_edit" name="frm_edit" action="#s_filename#" method="post">
		<input type="hidden" id="task" name="task" value="edit">
		<input type="hidden" id="actionID" name="actionID" value="#val(q_edit.actionID)#">
		<table class="inputtable">
			
		<tr>
		<td class="leftcol">Date</td>
		<td>#objDateInput.showDate(currentDate=s_postDate,fieldName="actionDateTime")#</td>
		</tr>

		<tr>
		<td class="leftcol">Time</td>
		<td>#objDateInput.showTime(currentDate=s_postTime,fieldName="actionDateTime",minuteRange=5,use24=true)#</td>
		</tr>

		<tr>
		<td class="leftcol">Action</td>
		<td>
		<cfquery datasource="cmsdb" name="q_actionType">
			select actionTypeID, actionType from cms.cfg_action_types order by actionType
		</cfquery>
		<select id="actionTypeID" name="actionTypeID">
			<option value="0"></option>
			<cfloop query="q_actionType">
				<option value="#actionTypeID#"<cfif q_actionType.actionTypeID EQ q_edit.actionTypeID> SELECTED</cfif>>#actionType#</option>
			</cfloop>
		</select>
		</td>
		</tr>

		<tr>
		<td class="leftcol">Detail</td>
		<td><input type="text" id="action" name="action" value="#q_edit.action#" size="50"></td>
		</tr>

		<tr>
		<td class="leftcol">Description</td>
		<td><textarea id="description" name="description" rows="10" cols="60">#q_edit.description#</textarea></td>
		</tr>

		<tr>
		<td class="leftcol">&nbsp;</td>
		<td><input type="submit" id="submit_action" name="submit_action" value="#s_value#"></td>
		</tr>

		</table>
	</form>
</cfcase>
<cfcase value="home">
	<a href="#s_filename#?task=edit&p=0">add</a>
	<form id="frm_filter" name="frm_pass" action="#s_filename#" method="post">
	<div id="div_filter_head" style="cursor: hand;" onclick="js_collapseThis('div_filter_body');" class="toptab" title="Click to show or hide text." style="display:inline;">Filter & Sort</div>
	<div id="div_filter_body" style="display:#s_showFilter#;">
	<div class="headersmall">Filter</div>
	<cfquery datasource="cmsdb" name="q_actionType">
		select distinct A.actionTypeID as 'value', T.actionType as 'display' 
		from cms.log_actions A
		inner join cms.cfg_action_types T
		on A.actionTypeID = T.actionTypeID
		order by T.actionType
	</cfquery>
	<cfif isdefined("form.filter_actionTypeID")>
		<cfset i_actionTypeID = val(form.filter_actionTypeID)> 
	<cfelse>
		<cfset i_actionTypeID = 0>
	</cfif>
	#objDropdown.dropdownQuery(displayString="",dropdownName="filter_actionTypeID",dataQuery=q_actionType,selectedValue=i_actionTypeID,defaultOption="Action Type")#
	<div class="headersmall">Sort</div>
	#objDropdown.dropdown(displayString="",dropdownName="sortDir",itemList="ASC,DESC",selectedValue="#form.sortDir#",defaultOption="Sort Dir")#
	<input type="submit" id="submit_filter" name="submit_filter" value="Go">
	</div>
	</form>
	<table class="inputtable">
	<cfset i_rows = 1>
	<cfset i_day = 0>
	<cfset i_Week = 0>
	<cfset i_year = 0>
	<cfquery datasource="cmsdb" name="q_actions">
		select A.actionID, A.actionTypeID, A.actionDateTime, A.action, T.actionType, A.description 
		from cms.log_actions A
		left join cms.cfg_action_types T
		on A.actionTypeID = T.actionTypeID
		<cfif isdefined("form.filter_actionTypeID") and val(form.filter_actionTypeID) GT 0>
		where A.actionTypeID = #val(form.filter_actionTypeID)#
		</cfif>		
		order by A.actionDateTime #form.sortDir#
	</cfquery>
	<cfloop query="q_actions">
		<cfif currentRow MOD 2><cfset s_bgcolor = "##99A68C"><cfelse><cfset s_bgcolor = "##A6A68C"></cfif>
		<cfif NOT (i_year EQ year(actionDateTime) and i_Week EQ week(actionDateTime))>
			<tr>
			<td class="header">&nbsp;</td>
			<td class="header" colspan="4"><strong>#dateFormat(actionDateTime,"mm/dd/yyyy")#</strong></td>
			</tr>
			<tr>
			<td class="header">&nbsp;</td>
			<td class="header">Action Date</td>
			<td class="header">Type</td>
			<td class="header">Action</td>
			<td class="header">Description</td>
			</tr>
			<cfset i_rows = 1>
		</cfif>
		<tr>
		<td class="detail" bgcolor="#s_bgcolor#"><a href="#s_filename#?task=edit&p=#actionID#">#i_rows#</a></td>
		<td class="detail" bgcolor="#s_bgcolor#" align="right">
			<cfif i_day EQ day(actionDateTime)>#timeFormat(actionDateTime,"hh:mm TT")#<cfelse>#dateFormat(actionDateTime,"mm/dd/yyyy")# #timeFormat(actionDateTime,"hh:mm TT")#</cfif>
		</td>
		<td class="detail" bgcolor="#s_bgcolor#">#actionType#</td>
		<td class="detail" bgcolor="#s_bgcolor#">#action#</td>
		<td class="detail" bgcolor="#s_bgcolor#">#description#</td>
		</tr>
		<cfset i_rows++>
		<cfset i_day = day(actionDateTime)>
		<cfset i_week = week(actionDateTime)>
		<cfset i_year = year(actionDateTime)>
	</cfloop>
	</table>
</cfcase>
</cfswitch>
</body> 
</html>
</cfoutput>