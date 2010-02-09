<cfparam name="task" type="string" default="home">
<cfparam name="p" type="string" default="0">
<cfset s_filename = GetFileFromPath(GetCurrentTemplatePath())>
<cfset s_pageName = "Tower Info">
<cfset objDropdown = createObject("component","common.dropdown_c")>
<cfset objDateInput = createObject("component","common.dateInput_c")>
<cfset i_iconSize = 14>
<cfset task = "home">
<cfif isdefined("url.task")>
	<cfset task = url.task>
<cfelse>
  <cfif isdefined("form.task")>
	  <cfset task = form.task>
  </cfif>
</cfif>

<cfset p = "blank">
<cfif isdefined("url.p")>
	<cfset p = url.p>
<cfelse>
  <cfif isdefined("form.p")>
	  <cfset p = form.p>
  </cfif>
</cfif>

<cfset s_pid = "0">
<cfif isdefined("url.pid")>
	<cfset s_pid = url.pid>
<cfelse>
  <cfif isdefined("form.pid")>
	  <cfset s_pid = form.pid>
  </cfif>
</cfif>

<cfset i_towerID = 0>
<cfquery datasource="braddoro" name="q_public">
	select towerID 
	from dyn_pos_tower
	where publicID = '#p#' 
</cfquery>
<cfset i_towerID = val(q_public.towerID)>

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
<span class="headerlabel">#s_pageName#</span> <a href="tower_overview.cfm?task=home&pid=#s_pid#">home</a><br><br>
</cfoutput>

<cfswitch expression="#task#">

<cfcase value="save">
	<cfif i_towerID GT 0>
		<cfquery datasource="braddoro" name="q_tower">
			update dyn_pos_tower set 
			system = '#form.system#',
			planet = #val(form.planet)#,
			moon = #val(form.moon)#
			where towerID = #i_towerID#
		</cfquery>
		<cfquery datasource="braddoro" name="q_update">
			SELECT D.attributeValue/C.attributeValue*MAXUSE.attributeValue as 'usePerHour'
			FROM dyn_pos_tower_attributes D
			inner join cfg_pos_tower_attributes C
			on D.towerTypeID = C.towerTypeID
			and D.attributeGroup = C.attributeGroup
			and D.attribute = C.attribute
			and C.attributeGroup = 'Base'
			and (C.attribute = 'PG' or C.attribute = 'CPU')
			and D.towerID = #i_towerID#
			inner join (
			    SELECT attribute, attributeValue
			    FROM cfg_pos_tower_attributes
			    where towerTypeID = #val(form.towerTypeID)#
			    and attributeGroup = 'Fuel'
			    and attribute = 'Heavy Water'
			) MAXUSE
			on case when MAXUSE.attribute = 'Heavy Water' then 'CPU'
			when MAXUSE.attribute = 'Liquid Ozone' then 'PG' end = C.attribute		
		</cfquery>
		<cfquery datasource="braddoro" name="q_update2">
			update dyn_pos_tower_attributes SET attributeValue = '#q_update.usePerHour#' 
		    where towerID = #i_towerID#
		    and attributeGroup = 'Base'
		    and attribute = 'Heavy Water per Hour'
		</cfquery>
		<cfquery datasource="braddoro" name="q_update">
			SELECT D.attributeValue/C.attributeValue*MAXUSE.attributeValue as 'usePerHour'
			FROM dyn_pos_tower_attributes D
			inner join cfg_pos_tower_attributes C
			on D.towerTypeID = C.towerTypeID
			and D.attributeGroup = C.attributeGroup
			and D.attribute = C.attribute
			and C.attributeGroup = 'Base'
			and (C.attribute = 'PG' or C.attribute = 'CPU')
			and D.towerID = #i_towerID#
			inner join (
			    SELECT attribute, attributeValue
			    FROM cfg_pos_tower_attributes
			    where towerTypeID = #val(form.towerTypeID)#
			    and attributeGroup = 'Fuel'
			    and attribute = 'Liquid Ozone'
			) MAXUSE
			on case when MAXUSE.attribute = 'Heavy Water' then 'CPU'
			when MAXUSE.attribute = 'Liquid Ozone' then 'PG' end = C.attribute		
		</cfquery>
		<cfquery datasource="braddoro" name="q_update2">
			update dyn_pos_tower_attributes SET attributeValue = '#q_update.usePerHour#' 
		    where towerID = #i_towerID#
		    and attributeGroup = 'Base'
		    and attribute = 'Liquid Ozone per Hour'
		</cfquery>
		<cfloop list="#form.fieldnames#" index="currItem">
			<cfset s_currItem = replace(currItem,"_"," ","All")>
			<cfquery datasource="braddoro" name="q_update">
				update dyn_pos_tower_attributes set attributeValue = '#trim(evaluate('form.' & currItem))#'
				where towerID = #i_towerID#
				and attribute = '#s_currItem#'
			</cfquery>
		</cfloop>
	</cfif>
	
	<cflocation url="#s_filename#?p=#p#&pid=#s_pid#&task=edit" addtoken="false">
</cfcase>

<cfcase value="home">
	<cfquery datasource="braddoro" name="q_owner">
		SELECT T.towerID, T.system, T.planet, T.moon, C.race, C.size, T.towerTypeID, O.owner, T.publicID
		FROM dyn_pos_tower T
		inner join cfg_pos_tower_types C
			on T.towerTypeID = C.towerTypeID
		inner join dyn_pos_owners O
			on T.ownerID = O.ownerID
		where O.publicID = '#pid#'
		order by O.owner, T.system, T.planet, T.moon
	</cfquery>
	<table class="inputtable">
			<tr>
			<td class="header">Owner</td>
			<td class="header">System</td>			
			<td class="header">Planet</td>
			<td class="header">Moon</td>
			<td class="header">Race</td>
			<td class="header">Size</td>
			</tr>
		<cfoutput query="q_owner">
			<cfset s_url = "#s_filename#?task=edit&p=#publicID#">
			<tr id="towerID_#towerID#" onclick="js_opener('#s_url#');" onmouseover="js_changeBG(this.id,'##AB9448');" onmouseout="js_changeBG(this.id,'##F1EFDE');" style="cursor:default;" title="click to view">
			<td>#owner#</td>
			<td>#system#</td>			
			<td>#planet#</td>
			<td>#moon#</td>
			<td>#race#</td>
			<td>#size#</td>
			</tr>
		</cfoutput>
	</table>
	
</cfcase>

<cfcase value="edit">

<!--- 
Fuel need query
select 
T.system, T.planet, T.moon, T.towerID, D.attribute, 
(((C.attributeValue*24)*21)-D.attributeValue) as 'fuelNeeded',  
(((C.attributeValue*24)*21)-D.attributeValue)*V.volume as 'volumeNeeded'
from dyn_pos_tower T
inner join dyn_pos_tower_attributes D
    on T.towerID = D.towerID
inner join cfg_pos_volume V
    on D.attribute = V.itemName
inner join cfg_pos_tower_attributes C
    on D.attribute = C.attribute
    and C.towerTypeID = D.towerTypeID
WHERE D.attributeGroup = 'Fuel'
and D.attribute <> 'Strontium Clathrates' 
ORDER BY D.towerID, D.attribute 
 --->

<!---<cfquery datasource="braddoro" name="q_fuelDays">
select D.towerID, D.attribute, D.attributeValue, V.volume, C.attributeValue, floor(V.volume*C.attributeValue) as 'volPerHour'
from dyn_pos_tower_attributes D
inner join cfg_pos_volume V
    on D.attribute = V.itemName
inner join cfg_pos_tower_attributes C
    on D.attribute = C.attribute
    and C.towerTypeID = D.towerTypeID
WHERE D.attributeGroup = 'Fuel' and (D.attribute <> 'Strontium Clathrates' and D.attribute <> 'Heavy Water' and D.attribute <> 'Liquid Ozone')
and towerID = 1

union 

select D.towerID, D.attribute, D.attributeValue, V.volume, D.attributeValue, floor(V.volume*D.attributeValue) as 'volPerHour' 
from dyn_pos_tower_attributes D
inner join cfg_pos_volume V
    on D.attribute = V.itemName
WHERE D.attributeGroup = 'Fuel' and (D.attribute = 'Heavy Water' or D.attribute = 'Liquid Ozone')
and towerID = 1
</cfquery>
=floor(110000/SUM(G35:G42),1)/24--->

	<cfoutput>
		<cfquery datasource="braddoro" name="q_tower">
			SELECT T.towerID, T.system,T.planet, T.moon, C.race, C.size, T.towerTypeID, O.owner, T.publicID, T.towerTypeID
			FROM dyn_pos_tower T
			inner join cfg_pos_tower_types C
				on T.towerTypeID = C.towerTypeID
			inner join dyn_pos_owners O
				on T.ownerID = O.ownerID
			where T.towerID = #i_towerID#
		</cfquery>
		<cfif val(q_tower.towerID) GT 0>
			<cfset s_value = "Save">
		<cfelse>
			<cfset s_value = "Add">
		</cfif>
		<cfset i_blankRows = 4>
		<form id="frm_edit" name="frm_edit" action="#s_filename#" method="post">
			<input type="hidden" id="task" name="task" value="save">
			<input type="hidden" id="p" name="p" value="#q_tower.publicID#">
			<input type="hidden" id="pid" name="pid" value="#s_pid#">
			<input type="hidden" id="towerTypeID" name="towerTypeID" value="#val(q_tower.towerTypeID)#">
			<table class="inputtable">
			
			<tr>
			<td class="leftcol">Tower ID</td>
			<td colspan="#i_blankRows#">#q_tower.towerID#</td>			
			</tr>

			<tr>
			<td class="leftcol">Owner</td>
			<td colspan="#i_blankRows#">#q_tower.owner#</td>			
			</tr>
	
			<tr>
			<td class="leftcol">Type</td>
			<td colspan="#i_blankRows#">#q_tower.race# #q_tower.size#</td>			
			</tr>
	
			<tr>
			<td class="leftcol">System</td>
			<td colspan="#i_blankRows#"><input type="text" id="system" name="system" value="#q_tower.system#" size="30"></td>			
			</tr>
		
			<tr>
			<td class="leftcol">Planet</td>
			<td colspan="#i_blankRows#"><input type="text" id="planet" name="planet" value="#q_tower.planet#" size="5"></td>			
			</tr>
		
			<tr>
			<td class="leftcol">Moon</td>
			<td colspan="#i_blankRows#"><input type="text" id="moon" name="moon" value="#q_tower.moon#" size="5"></td>			
			</tr>
			<cfquery datasource="braddoro" name="q_attributes">
				SELECT T.towerID, D.attributeGroup, D.attribute, D.attributeValue, C.attributeValue as 'usePerHour', V.volume
				FROM dyn_pos_tower T 
				inner join dyn_pos_tower_attributes D
				    on T.towerID = D.towerID
				    and T.towerID = #i_towerID#
				left join cfg_pos_volume V
					on D.attribute = V.itemName
				inner join cfg_pos_tower_attributes C
				    on D.towerTypeID = C.towerTypeID
				    and D.attributeGroup = C.attributeGroup
				    and D.attribute = C.attribute
				order by C.attributeGroup, C.attribute  
			</cfquery>
			<cfquery datasource="braddoro" name="q_maxUse">
				SELECT 
				attribute, 
				attributeValue as 'maxuse'
				FROM dyn_pos_tower_attributes 
	            where towerID = #i_towerID#
				and attributeGroup = 'Base'
				and (attribute = 'Liquid Ozone per Hour' or attribute = 'Heavy Water per Hour' or attribute = 'Fuel Days' or attribute = 'Strontium Hours')
				order by attribute
	        </cfquery>
			<cfset i_days = q_maxUse.maxuse[1]>
			<cfset i_hours = q_maxUse.maxuse[4]>
			<cfset i_totalVolume = 0>
			</cfoutput>
			<cfoutput query="q_attributes" group="attributeGroup">
				<tr>
					<td class="leftcol"><strong>#attributeGroup#</strong></td>
					<td>&nbsp;</td>
					<cfif attributeGroup EQ "Fuel">
						<td class="example" align="right"><strong>Need</strong></td>
						<td class="example" align="right"><strong>Days</strong></td>
						<td class="example" align="right"><strong>Volume</strong></td>
					<cfelse>				
						<td class="example">&nbsp;</td>
						<td class="example">&nbsp;</td>
						<td class="example">&nbsp;</td>
					</cfif>
				</tr>
				<cfoutput>
					<cfset s_fieldName = replace(attribute," ","_","All")>
					<tr>
					<td class="leftcol">#attribute#</td>
						<td><input type="text" id="#s_fieldName#" name="#s_fieldName#" value="#attributeValue#" size="10"> 
						<cfset i_userPerHour = 0>
						<cfset i_daysLeft = 0>
						<cfset i_volume = 0>
						<!--- =[fuel bay size]/sumproduct([all volumes],[all fuel per hours])/24--->
						<cfif attributeGroup EQ "Fuel">
							<cfswitch expression="#q_attributes.attribute#">
							<cfcase value="Heavy Water">
								<cfset i_userPerHour = val(q_maxUse.maxuse[2])>
								<cfset i_default = ((i_userPerHour*24)*i_days)-attributeValue>
								<cfif i_userPerHour NEQ 0 and i_userPerHour NEQ 0>
									<cfset i_daysLeft = (attributeValue/i_userPerHour)/24>
								</cfif>
								<cfset i_volume = i_default*volume>
							</cfcase>
							<cfcase value="Liquid Ozone">
								<cfset i_userPerHour = val(q_maxUse.maxuse[3])>
								<cfset i_default = ((i_userPerHour*24)*i_days)-attributeValue>
								<cfif i_userPerHour NEQ 0 and i_userPerHour NEQ 0>
									<cfset i_daysLeft = (attributeValue/i_userPerHour)/24>
								</cfif>
								<cfset i_volume = i_default*volume>
							</cfcase>
							<cfcase value="Strontium Clathrates">
								<cfset i_userPerHour = val(usePerHour)>
								<cfset i_default = (i_userPerHour*i_hours)-attributeValue>
								<cfif i_userPerHour NEQ 0 and i_userPerHour NEQ 0>
									<cfset i_daysLeft = (attributeValue/i_userPerHour)>
								</cfif>
								<cfset i_volume = i_default*volume>
							</cfcase>
							<cfdefaultcase>
								<cfset i_userPerHour = val(usePerHour)>
								<cfset i_default = (i_userPerHour*24)*i_days-attributeValue>
								<cfif i_userPerHour NEQ 0 and i_userPerHour NEQ 0>
									<cfset i_daysLeft = (attributeValue/i_userPerHour)/24>
								</cfif>
								<cfset i_volume = i_default*volume>
								<cfset i_daysLeft = (attributeValue/i_userPerHour)/24>
							</cfdefaultcase>
							</cfswitch>
							<cfset i_totalVolume = i_totalVolume+i_volume>
						<cfelse>
							<cfset i_default = usePerHour>
						</cfif>
						</td>
						<cfif i_default LT 0>
							<cfset s_class = "smallok"> 
						<cfelse>
							<cfset s_class = "example">
						</cfif>
						<td align="right"><span class="#s_class#"><strong>#numberformat(i_default)#</strong></span></td>
						<cfif i_daysLeft LT 3 and q_attributes.attribute NEQ "Strontium Clathrates">
							<cfset s_class = "smallwarn"> 
						<cfelse>
							<cfset s_class = "example">
						</cfif>
						<td align="right"><span class="#s_class#"><cfif attributeGroup EQ "Fuel">#numberformat(i_daysLeft)#</cfif></span></td>
						<cfif i_default LT 0>
							<cfset s_class = "smallok"> 
						<cfelse>
							<cfset s_class = "example">
						</cfif>
						<td align="right"><span class="#s_class#"><cfif attributeGroup EQ "Fuel">#numberformat(i_volume)#</cfif></span></td>
					</tr>
				</cfoutput>
			</cfoutput>
			<cfoutput>
			<tr>
			<td class="leftcol">&nbsp;</td>
			<td colspan="#i_blankRows-1#"><input type="submit" id="submit_action" name="submit_action" value="#s_value#"></td>
			<td class="example" align="right"><strong>#numberformat(i_totalVolume)#</strong></td>
			</tr>
			
			</table>
		</form>
	</cfoutput>
	
<cfquery datasource="braddoro" name="q_owner">
SELECT T.towerID, T.system, T.planet, T.moon, C.race, C.size, T.towerTypeID, O.owner, T.publicID, 
A1.attributeValue as 'StrontiumHours',
A2.attributeValue as 'FuelDays'
FROM dyn_pos_tower T
inner join dyn_pos_tower_attributes A1
    on T.towerID = A1.towerID
    and A1.attribute = 'Strontium Hours'
inner join dyn_pos_tower_attributes A2
    on T.towerID = A2.towerID
    and A2.attribute = 'Fuel Days'
inner join cfg_pos_tower_types C
	on T.towerTypeID = C.towerTypeID
inner join dyn_pos_owners O
	on T.ownerID = O.ownerID
where O.publicID = '#s_pid#'
and T.active = 1
order by O.owner, T.system, T.planet, T.moon
</cfquery>
<table class="inputtable">
	<cfset i_cols = 7>
	<cfoutput query="q_owner" group="owner">
		<tr>
			<td class="header" style="padding-right:5px;"></td>
			<td class="header" style="padding-right:5px;">System</td>			
			<td class="header" style="padding-right:5px;">Location</td>
			<td class="header" style="padding-right:5px;" align="right">Type</td>
		</tr>
		<cfoutput>
			<cfset s_url = "tower_info.cfm?task=edit&p=#publicID#">
			<cfset s_class="">
			<tr style="cursor:default;" title="click to view">
				<td class="#s_class#" style="padding-right:5px;" title="#towerID#"><a href="tower_info.cfm?p=#publicID#&pid=#pid#&task=edit"><img src="Button-Play-16x16.png" border="0" height="#i_iconSize#" width="#i_iconSize#" title="edit"></a></td>
				<td class="#s_class#" style="padding-right:5px;">#system#</td>			
				<td class="#s_class#" style="padding-right:5px;" align="right">#planet#-#moon#</td>
				<td class="#s_class#" style="padding-right:5px;">#race# #size#</td>
			</tr>
		</cfoutput>
	</cfoutput>
</table>
	
</cfcase>

<cfdefaultcase>
</cfdefaultcase>
</cfswitch>
</body> 
</html>