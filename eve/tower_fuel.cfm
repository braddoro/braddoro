<cfparam name="task" type="string" default="home">
<cfparam name="p" type="string" default="0">
<cfset s_filename = GetFileFromPath(GetCurrentTemplatePath())>
<cfset s_pageName = "Fuel Reserves">
<cfset objDropdown = createObject("component","common.dropdown_c")>
<cfset objDateInput = createObject("component","common.dateInput_c")>

<cfset task = "">
<cfif isdefined("url.task")>
	<cfset task = url.task>
<cfelse>
  <cfif isdefined("form.task")>
	  <cfset task = form.task>
  </cfif>
</cfif>

<cfset i_fuelLocationID = 0>
<cfif isdefined("url.fuelLocationID")>
	<cfset i_fuelLocationID = val(url.fuelLocationID)>
<cfelse>
  <cfif isdefined("form.fuelLocationID")>
	  <cfset i_fuelLocationID = val(form.fuelLocationID)>
  </cfif>
</cfif>

<cfswitch expression="#task#">
<cfcase value="save">
	<cfif i_fuelLocationID GT 0>
		<cfquery datasource="braddoro" name="q_sql">
			update dyn_pos_fuel_reserve_location
			set
			  reserveID = #val(form.reserveID)#,
			  fuelType = '#form.fuelType#',
			  amount = #val(form.amount)#,
			  system = '#form.system#',
			  destination = '#form.destination#',
			  fueldate = now()
			where
			  fuelLocationID = #i_fuelLocationID#
		</cfquery>
	<cfelse>
		<cfquery datasource="braddoro" name="q_sql">
			insert into dyn_pos_fuel_reserve_location (reserveID, fuelType, amount, system, destination, fuelDate)
			values (#val(form.reserveID)#, '#form.fuelType#', #val(form.amount)#, '#form.system#', '#form.destination#', now())
		</cfquery>
	</cfif>
</cfcase>
<cfcase value="del">
	<cfquery datasource="braddoro" name="q_sql">
		delete from dyn_pos_fuel_reserve_location where fuelLocationID = #i_fuelLocationID#
	</cfquery>
	<cfset i_fuelLocationID = 0>
</cfcase>
</cfswitch>

<cfoutput>
<html> 
<head> 
<title>#s_pageName#</title>
<style media="screen" type="text/css">
.base {font-family : Arial , Helvetica , sans-serif;background-color : ##F1EFDE;font-size:.9em;}
.leftcol {width:150px;text-align:right;background-color:##A6A68C;padding:2px;}
.rightcol {background-color:##A6A68C;padding:2px;}
.example {font-family : Arial , Helvetica , sans-serif;font-size:.75em;padding:2px;}
.smallwarn {font-family : Arial , Helvetica , sans-serif;font-size:.75em;color: red;}
.smallok {font-family : Arial , Helvetica , sans-serif;font-size:.75em;color: green;}
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
	function js_changeBG(changeme,colorbg) {
		document.getElementById(changeme).style.backgroundColor = colorbg;
	}
	function js_opener(myurl) {
		window.open(myurl,"_self","","false");
	} 
</script>
</head> 
<body class="base">
<span class="headerlabel">#s_pageName#</span> <a href="#s_filename#?task=home"><img src="Button-Refresh-16x16.png" border="0" height="12" width="12" title="refresh"></a><br><br>

<cfquery datasource="braddoro" name="q_fuel">
	SELECT *
	FROM dyn_pos_fuel_reserve_location
	where fuelLocationID = #i_fuelLocationID#
</cfquery>

<cfset i_reserveID = 0>
<cfif isdefined("url.reserveID")>
	<cfset i_reserveID = val(url.reserveID)>
<cfelseif isdefined("form.reserveID")>
	  <cfset i_reserveID = val(form.reserveID)>
<cfelseif isdefined("q_fuel.reserveID")>
	  <cfset i_reserveID = val(q_fuel.reserveID)>
</cfif>

<cfif val(q_fuel.fuelLocationID) GT 0>
	<cfset s_value = "Save">
<cfelse>
	<cfset s_value = "Add">
</cfif>

<cfif task EQ "add" or task EQ "edit">
	<cfset s_display = "display">
<cfelse>
	<cfset s_display = "none">
</cfif>
<div id="div_input" name="div_input" style="display:#s_display#;">
<form id="frm_edit" name="frm_edit" action="#s_filename#" method="post">
	<input type="hidden" id="task" name="task" value="save">
	<input type="hidden" id="fuelLocationID" name="fuelLocationID" value="#val(q_fuel.fuelLocationID)#">
	<input type="hidden" id="reserveID" name="reserveID" value="#i_reserveID#">
	<table class="inputtable">
		
	<tr>
	<td class="leftcol">System</td>
	<td><input type="text" id="system" name="system" value="#q_fuel.system#" size="20"></td>			
	</tr>

	<tr>
	<td class="leftcol">Type</td>
	<td><input type="text" id="fuelType" name="fuelType" value="#q_fuel.fuelType#" size="20"></td>			
	</tr>

	<tr>
	<td class="leftcol">Amount</td>
	<td><input type="text" id="amount" name="amount" value="#val(q_fuel.amount)#" size="10"></td>			
	</tr>

	<tr>
	<td class="leftcol">Destination</td>
	<td><input type="text" id="destination" name="destination" value="#q_fuel.destination#" size="20"></td>			
	</tr>
	
	<tr>
	<td class="leftcol">&nbsp;</td>
	<td><input type="submit" id="submit_fuel" name="submit_fuel" value="#s_value#"></td>
	</tr>

	</table>
</form>
</div>
</cfoutput>

<cfquery datasource="braddoro" name="q_owner">
select R.reserveID, reserveName, fuelLocationID, system, amount, destination, fuelType, volume, fuelDate
from dyn_pos_fuel_reserves R
inner join dyn_pos_fuel_reserve_location L 
    on R.reserveID = L.reserveID
    and R.ownerID = 1
inner join cfg_pos_volume V
	on L.fuelType = V.itemName
order by reserveName, system, fuelType
</cfquery>
<cfset i_cols = 7>
<table class="inputtable">
<cfoutput query="q_owner" group="reserveName">
	<tr>
		<td colspan="#i_cols#"><strong>#reserveName#</strong> <a href="#s_filename#?reserveID=#reserveID#&fuelLocationID=0&task=add"><img src="Button-Add-16x16.png" border="0" height="12" width="12" title="add"></a></td>
	</tr>
	<tr>
		<td class="header" align="left" style="padding-right:5px;"> </td>
		<td class="header" align="left" style="padding-right:5px;">Fuel Type</td>
		<td class="header" align="right" style="padding-right:5px;">Amount</td>
		<td class="header" align="right" style="padding-right:5px;">M3</td>
		<td class="header" align="left" style="padding-right:5px;">Destination</td>
		<td class="header" align="left" style="padding-right:5px;">Date</td>
		<td class="header" align="left" style="padding-right:5px;"> </td>
	</tr>
	<cfoutput group="system">
		<tr>
			<td colspan="#i_cols#"><strong>#system#</strong></td>
		</tr>
		<cfoutput>
			<tr>
				<td align="left" style="padding-right:5px;">
				<a href="#s_filename#?fuelLocationID=#fuelLocationID#&task=edit"><img src="Button-Play-16x16.png" border="0" height="12" width="12" title="edit"></a></td>
				<td align="left" style="padding-right:5px;">#fuelType#</td>
				<td align="right" style="padding-right:5px;">#numberformat(amount)#</td>
				<td align="right" style="padding-right:5px;">#numberformat(amount*volume)#</td>
				<td align="left" style="padding-right:5px;">#destination#</td>
				<td align="left" style="padding-right:5px;">#dateFormat(fuelDate,"mm/dd/yyyy")#</td>
				<td align="left" style="padding-right:5px;"><a href="#s_filename#?fuelLocationID=#fuelLocationID#&task=del"><img src="Button-Delete-16x16.png" border="0" height="12" width="12" title="delete"></a></td>
			</tr>
		</cfoutput>
		<tr>
			<td colspan="#i_cols#"></td>
		</tr>
	</cfoutput>
</cfoutput>
</table>
</body> 
</html>