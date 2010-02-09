<cfparam name="task" type="string" default="home">
<cfparam name="p" type="string" default="0">
<cfset s_filename = GetFileFromPath(GetCurrentTemplatePath())>
<cfset s_pageName = "POS Overview">
<cfset i_iconSize = 14>
<!--- a825acff-9416-11de-a19e-ca2e881f03b0 --->
<cfset objDropdown = createObject("component","common.dropdown_c")>
<cfset objTower = createObject("component","tower")>
<!---reserveDays--->
<cfset i_days = 45>
<cfif isdefined("url.days")>
	<cfset i_days = val(url.days)>
<cfelse>
  <cfif isdefined("form.days")>
	  <cfset i_days = val(form.days)>
  </cfif>
</cfif>

<cfset task = "">
<cfif isdefined("url.task")>
	<cfset task = url.task>
<cfelse>
  <cfif isdefined("form.task")>
	  <cfset task = form.task>
  </cfif>
</cfif>

<cfset s_pid = "">
<cfif isdefined("url.pid")>
	<cfset s_pid = url.pid>
<cfelse>
  <cfif isdefined("form.pid")>
	  <cfset s_pid = form.pid>
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

<cfset i_marketID = 0>
<cfif isdefined("url.marketID")>
	<cfset i_marketID = val(url.marketID)>
<cfelse>
  <cfif isdefined("form.marketID")>
	  <cfset i_marketID = val(form.marketID)>
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
			  system = '#form.systemName#',
			  destination = '#form.destination#',
			  fueldate = now()
			where
			  fuelLocationID = #i_fuelLocationID#
		</cfquery>
	<cfelse>
		<cfquery datasource="braddoro" name="q_sql">
			insert into dyn_pos_fuel_reserve_location (reserveID, fuelType, amount, system, destination, fuelDate)
			values (#val(form.reserveID)#, '#form.fuelType#', #val(form.amount)#, '#form.systemName#', '#form.destination#', now())
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

<cfif isdefined("form.reactionID") or i_marketID > 0>
	<cfswitch expression="#task#">
	<cfcase value="updateMarket">
		<cfif i_marketID GT 0>
			<cfquery datasource="braddoro" name="q_sql">
				update dyn_pos_market_reactions
				set
				  reactionID = #val(form.reactionID)#,
				  amount = #val(form.amount)#,
				  marketPrice = #val(form.marketPrice)#,
				  location = '#form.location#',
				  destination = '#form.destination#',
				  lastUpdate = now()
				where
				  marketID = #i_marketID#
			</cfquery>
		</cfif>
		<cfset i_marketID = 0>
	</cfcase>
	<cfcase value="insertMarket">
		<cfquery datasource="braddoro" name="q_sql">
			insert into dyn_pos_market_reactions (ownerID, reactionID, amount, marketPrice, location, destination, lastUpdate)
			values (#val(form.ownerID)#, #val(form.reactionID)#, #val(form.amount)#, #val(form.marketPrice)#, '#form.location#', '#form.destination#', now())
		</cfquery>
		<cfset i_marketID = 0>
	</cfcase>
	<cfcase value="delMarket">
		<cfquery datasource="braddoro" name="q_sql">
			delete from dyn_pos_market_reactions where marketID = #i_marketID#
		</cfquery>
		<cfset i_marketID = 0>
	</cfcase>
	</cfswitch>
</cfif>

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
.warn {font-family : Arial , Helvetica , sans-serif;color: red;}
.inputtable {border:1px solid ##708090;font-size:.9em;border-collapse:collapse;padding:2px;}
.inputtablenob {##708090;font-size:.9em;border-collapse:collapse;padding:2px;}
.headerlabel {font-family : Arial , Helvetica , sans-serif;background-color : ##F1EFDE;font-size:1.125em;color: ##708090;font-weight:bold;}
.headersmall {font-family : Arial , Helvetica , sans-serif;background-color : ##F1EFDE;font-size:.9sem;color: ##708090;font-weight:bold;}
.banner {font-size:1.5em;font-weight:bold;}
}
</style>
<script type="text/javascript" src="ajax.js"></script>
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
	function js_silo(container, towerID, reactionID) {
		var s_ajax = "Task=silo";
		s_ajax += "&towerID=" + towerID;
		s_ajax += "&pid=#s_pid#";
		s_ajax += "&reactionID=" + reactionID;
		var s_return = http_post_request("tower_ajax.cfm", s_ajax);
		if (container != '' && document.getElementById(container)) {
			document.getElementById(container).innerHTML = s_return; 
		}
	}
</script>
</head> 
<body class="base">
<span class="headerlabel">#s_pageName#</span> <a href="#s_filename#?task=home&pid=#s_pid#"><img src="Button-Refresh-16x16.png" border="0" height="#i_iconSize#" width="#i_iconSize#" title="refresh"></a><br><br>
</cfoutput>
<cfquery datasource="braddoro" name="q_owner">
	select owner from braddoro.dyn_pos_owners where publicID = '#s_pid#'
</cfquery>

<cfoutput query="q_owner"><div class="banner">#owner#</div><br></cfoutput>

<cfquery datasource="braddoro" name="q_suntzu">
	select chapterID, chapterName, paragraphID, paragraph from suntzu order by RAND() limit 1;
</cfquery>

<cfoutput query="q_suntzu">
	<strong>The Art of War &mdash; Sun Tzu</strong><br>
	<strong>#chapterID#.#paragraphID# #chapterName#</strong> #paragraph#<br><br>
</cfoutput>

<cfif s_pid EQ "" OR s_pid EQ 0 OR q_owner.recordCount EQ 0>
	Missing PID.
	<cfabort>
</cfif>

<!--- BEGIN: Tower Info --->
<cfoutput><div class="headersmall">Tower Summary <a href="tower_acd.php?pid=#s_pid#"><span class="example">add/edit</span></a></div></cfoutput>
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
			<td class="header" style="padding-right:5px;" align="right">Race</td>
			<td class="header" style="padding-right:5px;">Size</td>
			<td class="header" style="padding-right:5px;" align="right">Offline In</td>
			<td class="header" style="padding-right:5px;">Stront.</td>
			<td class="header" style="padding-right:5px;" align="right">Fuel</td>
		</tr>
		<cfoutput>
			<cfset s_url = "tower_info.cfm?task=edit&p=#publicID#">
			<cfset s_class="">
			<cfset i_daysLeft = objTower.daysToOffline(towerID=towerID)>
			<cfif i_daysLeft LT 4><cfset s_class="warn"></cfif>
			<tr style="cursor:default;" title="click to view">
				<td class="#s_class#" style="padding-right:5px;" title="#towerID#"><!--- <cfif towerID LT 10>&nbsp;&nbsp;</cfif>#towerID#  ---><a href="tower_info.cfm?p=#publicID#&pid=#pid#&task=edit"><img src="Button-Play-16x16.png" border="0" height="#i_iconSize#" width="#i_iconSize#" title="edit"></a></td>
				<td class="#s_class#" style="padding-right:5px;">#system#</td>			
				<td class="#s_class#" style="padding-right:5px;" align="right">#planet#-#moon#</td>
				<td class="#s_class#" style="padding-right:5px;">#race#</td>
				<td class="#s_class#" style="padding-right:5px;">#size#</td>
				<td class="#s_class#" style="padding-right:5px;" align="right">#fix(i_daysLeft)#</td>
				<td class="#s_class#" style="padding-right:5px;" align="right">#StrontiumHours#</td>
				<td class="#s_class#" style="padding-right:5px;" align="right">#FuelDays#</td>
			</tr>
		</cfoutput>
	</cfoutput>
</table>
<br>
<!--- END: Tower Info --->

<!--- BEGIN: Market --->

<cfquery datasource="braddoro" name="q_reaction">
	SELECT distinct reactionID as 'value', reaction as 'display' 
	FROM cfg_pos_reactions
	order by reaction
</cfquery>

<cfquery datasource="braddoro" name="q_marketItem">
	SELECT *
	FROM dyn_pos_market_reactions
	where marketID = #i_marketID#
</cfquery>

<cfset s_display = "none">
<cfif i_marketID GT 0>
	<cfset s_value = "Save">
	<cfset s_display = "display">
	<cfset task = "updateMarket">
<cfelse>
	<cfset s_value = "Add">
	<cfset s_display = "none">
	<cfif task EQ "editmarket">
		<cfset s_display = "display">
		<cfset task = "insertMarket">
	</cfif>
</cfif>

<cfoutput>

<cfset i_ownerID = 1>
<div id="div_market" name="div_market" style="display:#s_display#;">
<form id="frm_reaction" name="frm_reaction" action="#s_filename#" method="post">
	<input type="hidden" id="task" name="task" value="#task#">
	<input type="hidden" id="marketID" name="marketID" value="#val(q_marketItem.marketID)#">
	<input type="hidden" id="ownerID" name="ownerID" value="#i_ownerID#">
	<input type="hidden" id="pid" name="pid" value="#s_pid#">
	<table class="inputtable">
		
	<tr>
	<td class="leftcol">System</td>
	<td>#objDropdown.dropdownQuery(displayString="",dropdownName="reactionID",dataQuery=q_reaction,selectedValue=val(q_marketItem.reactionID),defaultOption="Reaction")#
	</td>			
	</tr>

	<tr>
	<td class="leftcol">Amount</td>
	<td><input type="text" id="amount" name="amount" value="#val(q_marketItem.amount)#" size="5"></td>			
	</tr>

	<tr>
	<td class="leftcol">Market Price</td>
	<td><input type="text" id="marketPrice" name="marketPrice" value="#val(q_marketItem.marketPrice)#" size="10"></td>			
	</tr>

	<tr>
	<td class="leftcol">Location</td>
	<td><input type="text" id="location" name="location" value="#q_marketItem.location#" size="20"></td>			
	</tr>

	<tr>
	<td class="leftcol">Destination</td>
	<td><input type="text" id="destination" name="destination" value="#q_marketItem.destination#" size="20"></td>			
	</tr>
	
	<tr>
	<td class="leftcol">&nbsp;</td>
	<td><input type="submit" id="submit_market" name="submit_market" value="#s_value#"></td>
	</tr>

	</table>
</form>
</div>
</cfoutput>

<!--- 
<div class="headersmall">Market Summary</div>
<cfquery datasource="braddoro" name="q_owner">
select O.ownerID, O.owner, C.reaction, D.amount, U.min as 'marketPrice', D.location, D.destination, V.volume, D.marketID
from dyn_pos_market_reactions D
inner join cfg_pos_reactions C
	on C.reactionID = D.reactionID
inner join cfg_pos_volume V
	on C.eveID = V.eveID
inner join dyn_pos_owners O
	on D.ownerID = O.ownerID
inner join cfg_eve_market U
	on C.eveID = U.eveID
order by O.owner, D.location, (D.amount*U.min)/(D.amount*V.volume) desc, C.reaction	
</cfquery>
<div id="div_reaction_market" name="div_reaction">
	<table class="inputtable">
		<cfset i_value = 0>
		<cfset i_m3 = 0>
		<cfset s_class="detail">
		<cfset i_cols = 9>
		<cfoutput query="q_owner" group="owner">
			<tr style="cursor:default;" title="click to view">
				<td colspan="#i_cols#"><strong>#owner#</strong> <a href="#s_filename#?ownerID=ownerID&marketID=0&task=editMarket"><img src="Button-Add-16x16.png" border="0" height="#i_iconSize#" width="#i_iconSize#" title="add"></a></td>
			</tr>
			<tr>
				<td class="header" style="padding-right:5px;"></td>
				<td class="header" style="padding-right:5px;">Reaction</td>			
				<td class="header" style="padding-right:5px;">Destination</td>
				<td align="right" class="header" style="padding-right:5px;">ISK to M3</td>
				<td align="right" class="header" style="padding-right:5px;">Units</td>
				<td align="right" class="header" style="padding-right:5px;">Market Price</td>
				<td align="right" class="header" style="padding-right:5px;">Value</td>
				<td align="right" class="header" style="padding-right:5px;">M3</td>
				<td align="right" class="header" style="padding-right:5px;"></td>
			</tr>
			<cfoutput group="location">
				<tr>
					<td colspan="#i_cols#" style="padding-right:5px;" class="#s_class#"><strong>#location#</strong></td>
				</tr>
				<cfset i_value_location = 0>
				<cfset i_m3_location = 0>
				<cfset s_location = location>
				<cfoutput>
					<tr style="cursor:default;" title="click to view">
						<td style="padding-right:5px;" class="#s_class#"><a href="#s_filename#?marketID=#marketID#&task=editMarket"><img src="Button-Play-16x16.png" border="0" height="#i_iconSize#" width="#i_iconSize#" title="edit"></a></td>
						<td style="padding-right:5px;" class="#s_class#">#reaction#</td>			
						<td style="padding-right:5px;" class="#s_class#">#destination#</td>
						<td align="right" style="padding-right:5px;" class="#s_class#">#numberformat((amount*marketPrice)\(amount*volume))#</td>
						<td align="right" style="padding-right:5px;" class="#s_class#">#numberformat(amount)#</td>
						<td align="right" style="padding-right:5px;" class="#s_class#">#dollarformat(marketPrice)#</td>
						<td align="right" style="padding-right:5px;" class="#s_class#">#dollarformat(amount*marketPrice)#</td>
						<td align="right" style="padding-right:5px;" class="#s_class#">#numberformat(amount*volume)#</td>
						<td align="left" style="padding-right:5px;"><a href="#s_filename#?marketID=#marketID#&task=delMarket"><img src="Button-Delete-16x16.png" border="0" height="#i_iconSize#" width="#i_iconSize#" title="delete"></a></td>
					</tr>
					<cfset i_value_location = i_value_location + amount*marketPrice>
					<cfset i_m3_location = i_m3_location + amount*volume>
					<cfset i_value = i_value + amount*marketPrice>
					<cfset i_m3 = i_m3 + amount*volume>
				</cfoutput>
				<tr style="cursor:default;" title="click to view">
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td align="right"><strong>#s_location#</strong></td>
					<td align="right" style="padding-right:5px;" class="#s_class#"><strong>#dollarformat(i_value_location)#</strong></td>
					<td align="right" style="padding-right:5px;" class="#s_class#"><strong>#numberformat(i_m3_location)#</strong></td>
					<td></td>
				</tr>
			</cfoutput>
		</cfoutput>
		<cfoutput>
			<tr style="cursor:default;" title="click to view">
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td align="right" style="padding-right:5px;" class="#s_class#"><strong>#dollarformat(i_value)#</strong></td>
				<td align="right" style="padding-right:5px;" class="#s_class#"><strong>#numberformat(i_m3)#</strong></td>
				<td></td>
			</tr>
        </cfoutput>
	</table>
</div>
<br>
<!--- END: Market --->
 --->

<!--- BEGIN: Reaction --->
<cfoutput>
<div class="headersmall">Reaction Summary <a href="reaction_acd.php?pid=#s_pid#"><span class="example">add/edit</span></a></div>
</cfoutput>
<cfquery datasource="braddoro" name="q_owner">
select T.towerID, R.reactionID, T.system, T.planet, T.moon, R.reaction, O.owner, TR.lastEmptyDate, R.hoursToFill, silos, 
DATE_ADD(TR.lastEmptyDate, INTERVAL (hoursToFill*silos) HOUR) as 'emptyBefore',
dateDiff(DATE_ADD(TR.lastEmptyDate, INTERVAL (hoursToFill*silos) HOUR),now()) as 'daysLeft',
case TR.EorF when 'F' then 'Fill' when 'E' then 'Empty' else '' end as 'EorF',
M.min*(R.outputModifier*72000) as 'income',
M.min
from dyn_pos_tower T
inner join dyn_pos_tower_reaction TR
    on T.towerID = TR.towerID
	and T.active = 1
inner join cfg_pos_reactions R
    on TR.reactionID = R.reactionID
inner join dyn_pos_owners O
	on T.ownerID = O.ownerID
	and O.publicID = '#s_pid#'
inner join cfg_eve_market M
	on M.eveID = R.eveID
order by O.owner, T.system, T.planet, T.moon, R.reaction 	
</cfquery>
<div id="div_reaction" name="div_reaction">
	<cfset s_class="">
	<table class="inputtable">
		<cfset i_cols = 7>
		<cfset i_income = 0>
		<cfoutput query="q_owner" group="owner">
			<tr>
				<td class="header" style="padding-right:5px;"></td>
				<td class="header" style="padding-right:5px;">System</td>			
				<td class="header" style="padding-right:5px;">Moon</td>
				<td class="header" style="padding-right:5px;">Reaction</td>
				<td class="header" style="padding-right:5px;">Days Left</td>
				<td class="header" style="padding-right:5px;">Min Sell</td>
				<td class="header" style="padding-right:5px;">Income</td>
				
			</tr>
			<cfoutput>
				<cfset s_class="">
				<cfif daysLeft LT 2><cfset s_class="warn"></cfif>
				<tr style="cursor:default;" title="click to view">
					<td style="padding-right:5px;" class="#s_class#"><img src="Button-Pause-16x16.png" border="0" height="#i_iconSize#" width="#i_iconSize#" title="Update silo empty date." onclick="js_silo('div_reaction', '#towerID#','#reactionID#');"></td>
					<td style="padding-right:5px;" class="#s_class#">#system#</td>			
					<td align="right" style="padding-right:5px;" class="#s_class#">#planet#-#moon#</td>
					<td align="right" style="padding-right:5px;" class="#s_class#">#daysLeft#</td>
					<td style="padding-right:5px;" class="#s_class#">#reaction#</td>
					<td align="right" style="padding-right:5px;" class="#s_class#">#dollarFormat(min)#</td>
					<td align="right" style="padding-right:5px;" class="#s_class#">#dollarFormat(income)#</td>
				</tr>
				<cfset i_income = i_income + income>
			</cfoutput>
		</cfoutput>
		<cfoutput>				
		<tr style="cursor:default;" title="click to view">
			<td class="header" style="padding-right:5px;" class="#s_class#">&nbsp;</td>
			<td class="header" style="padding-right:5px;" class="#s_class#">&nbsp;</td>			
			<td class="header" align="right" style="padding-right:5px;" class="#s_class#">&nbsp;</td>
			<td class="header" align="right" style="padding-right:5px;" class="#s_class#">&nbsp;</td>
			<td class="header" align="right" style="padding-right:5px;" class="#s_class#">&nbsp;</td>
			<td class="header" style="padding-right:5px;" class="#s_class#"><strong>Monthly Income</strong></td>
			<td class="header" align="right" style="padding-right:5px;" class="#s_class#"><strong>#dollarFormat(i_income)#</strong></td>
		</tr>
		</cfoutput>	
	</table>
</div>
<br>
<!--- END: Reaction --->

<!--- BEGIN: POS Cost --->
<div class="headersmall">POS Cost</div>
<cfquery datasource="braddoro" name="q_fuel">
SELECT D.attributeGroup, D.attribute, SUM(C.attributeValue) as 'usePerHour', M.min 
FROM dyn_pos_tower T 
inner join dyn_pos_tower_attributes D
    on T.towerID = D.towerID
    and T.active = 1
inner join dyn_pos_owners O
	on T.ownerID = O.ownerID
	and O.publicID = '#s_pid#'
left join cfg_pos_volume V
    on D.attribute = V.itemName
inner join cfg_pos_tower_attributes C
    on D.towerTypeID = C.towerTypeID
    and D.attributeGroup = C.attributeGroup
    and D.attribute = C.attribute
inner join cfg_eve_market M
    on D.attribute = M.itemName
WHERE D.attributeGroup = 'Fuel'
    AND D.attribute <> 'Strontium Clathrates'
	AND D.attribute <> 'Nitrogen Isotopes'
	AND D.attribute <> 'Heavy Water'
	AND D.attribute <> 'Liquid Ozone'
GROUP by D.attributeGroup, D.attribute, M.min
order by D.attributeGroup, D.attribute, M.min 
</cfquery>

<cfset i_cols = 4>
<table class="inputtable">
<tr>
	<td class="header" align="left" style="padding-right:5px;">Type</td>
	<td class="header" align="right" style="padding-right:5px;">Use per Month</td>
	<td class="header" align="right" style="padding-right:5px;">Cost</td>
	<td class="header" align="right" style="padding-right:5px;">Cost per Month</td>
</tr>
<cfset i_total = 0>
<cfoutput query="q_fuel">
	<cfset i_min = min>
	<!--- 24 30.41 --->
	<cfset i_use = (usePerHour*24)*30>
	<tr>
		<td align="left" style="padding-right:5px;">#attribute#</td>
		<td align="right" style="padding-right:5px;">#numberformat(i_use)#</td>
		<td align="right" style="padding-right:5px;">#dollarformat(i_min)#</td>
		<td align="right" style="padding-right:5px;">#dollarformat(i_min*i_use)#</td>
	</tr>
	<cfset i_total = i_total + (i_min*i_use)>
</cfoutput>
<cfoutput>
	<tr>
		<td class="header" align="left" style="padding-right:5px;"></td>
		<td class="header" align="right" style="padding-right:5px;" colspan="2"><strong>Monthly Expense</strong></td>
		<td class="header" align="right" style="padding-right:5px;"><strong>#dollarformat(i_total)#</strong></td>
	</tr>
</cfoutput>	
</table>
<br>
<!--- END: POS Cost --->
<cfif i_income GT 0 and i_total GT 0>
<cfoutput>
	Net Profit: #decimalFormat(i_income-i_total)#<br />
	Profit margin: #decimalFormat((i_income-i_total)/i_income)#
</cfoutput><br /><br />
</cfif>

<!--- BEGIN: Fuel Reserve --->
<div class="headersmall">Fuel Summary</div>
<cfquery datasource="braddoro" name="q_pos">
select reserveName, fuelType as 'reserveFuelType', sum(amount) as 'reserveAmount', V.volume as 'reserveVolume', M.min      
from dyn_pos_fuel_reserves R
inner join dyn_pos_fuel_reserve_location L 
    on R.reserveID = L.reserveID
inner join dyn_pos_owners O
	on R.ownerID = O.ownerID
	and O.publicID = '#s_pid#'
inner join cfg_pos_volume V
	on L.fuelType = V.itemName
inner join cfg_eve_market M
    on fuelType = M.itemName
group by reserveName, fuelType, V.volume, M.min
order by reserveName, fuelType
</cfquery>

<cfquery datasource="braddoro" name="q_fuel">
	select reserveName, T.towerID, D.attribute as 'fuelType', 
	(((C.attributeValue*24)*#i_days#)) as 'amount',  
	(((C.attributeValue*24)*#i_days#))*V.volume as 'volume'
	from dyn_pos_tower T
	inner join dyn_pos_owners O
		on T.ownerID = O.ownerID
		and O.publicID = '#s_pid#'
	inner join dyn_pos_tower_attributes D
	    on T.towerID = D.towerID
	inner join cfg_pos_volume V
	    on D.attribute = V.itemName
	inner join cfg_pos_tower_attributes C
	    on D.attribute = C.attribute
	    and C.towerTypeID = D.towerTypeID
	inner join dyn_pos_fuel_reserves R
		on T.ownerID = R.ownerID
	WHERE D.attributeGroup = 'Fuel'
	and D.attribute <> 'Strontium Clathrates'
	and T.active = 1
	ORDER BY D.attribute 
</cfquery>
<!--- and T.ownerID = 1 
and O.publicID = '#s_pid#' --->

<cfset i_cols = 6>
<table class="inputtable">
	<cfoutput>
	<tr>
		<td colspan="#i_cols#" class="example">
			<form id="frm_edit" name="frm_edit" action="#s_filename#" method="post">
				<input type="hidden" id="pid" name="pid" value="#s_pid#">
				Fuel Days: <input type="text" id="days" name="days" class="example" value="#i_days#" size="5"> <input type="submit" id="submit_action" name="submit_action" class="example" value="Go">
			</form>
		</td>
	</tr>
	</cfoutput>
<cfoutput query="q_fuel" group="reserveName">
	<tr>
		<td class="header" align="left" style="padding-right:5px;">Fuel Type</td>
		<td class="header" align="right" style="padding-right:5px;">Shortfall</td>
		<td class="header" align="right" style="padding-right:5px;">In Reserve</td>
		<td class="header" align="right" style="padding-right:5px;">#i_days# days</td>
		<td class="header" align="right" style="padding-right:5px;">Cost</td>
		<td class="header" align="right" style="padding-right:5px;">M3</td>
	</tr>
	<cfset i_total = 0>
	<cfoutput group="fuelType">
		<cfset s_fuelType = "">
		<cfset i_amount = 0>
		<cfoutput>
			<cfset s_fuelType = #fuelType#>
			<cfset i_amount = i_amount + #amount#>
		</cfoutput>
		<tr>
			<td align="left" style="padding-right:5px;">#s_fuelType#</td>
			<cfloop query="q_pos">
				<cfif q_pos.reserveFuelType EQ s_fuelType>
					<td align="right" style="padding-right:5px;">#numberformat(reserveAmount)#</td>
					<td align="right" style="padding-right:5px;"><cfif i_amount-reserveAmount LT 0>0<cfelse>#numberformat(i_amount-reserveAmount)#</cfif></td>
					<td align="right" style="padding-right:5px;"><cfif i_amount-reserveAmount LT 0>0<cfelse>#numberformat((i_amount-reserveAmount)*reserveVolume)#</cfif></td>
					<td align="right" style="padding-right:5px;">
					<cfif s_fuelType EQ "Strontium Clathrates" OR 
						s_fuelType EQ "Nitrogen Isotopes" OR
						s_fuelType EQ "Heavy Water" OR
						s_fuelType EQ "Liquid Ozone">
						<cfif i_amount-reserveAmount GT 0>
							<cfswitch expression="#s_fuelType#">
								<cfcase value="Helium Isotopes"><span style="color: blue;">#numberFormat((i_amount-reserveAmount)\300)# Ice</span></cfcase>
								<cfcase value="Oxygen Isotopes"><span style="color: blue;">#numberFormat((i_amount-reserveAmount)\300)# Ice</span></cfcase>
								<cfcase value="Hydrogen Isotopes"><span style="color: blue;">#numberFormat((i_amount-reserveAmount)\300)# Ice</span></cfcase>
								<cfcase value="Nitrogen Isotopes"><span style="color: blue;">#numberFormat((i_amount-reserveAmount)\300)# Ice</span></cfcase>
								<cfcase value="Heavy Water"><span style="color: blue;">#numberFormat((i_amount-reserveAmount)\1000)# Ice</span></cfcase>
								<cfcase value="Liquid Ozone"><span style="color: blue;">#numberFormat((i_amount-reserveAmount)\1000)# Ice</span></cfcase>
							</cfswitch>
						</cfif>
					<cfelse>
						<cfif i_amount-reserveAmount LT 0>0<cfelse>#dollarformat((i_amount-reserveAmount)*min)#
							<cfset i_total = i_total + (i_amount-reserveAmount)* min>
						</cfif>
					</cfif>
					</td>
				</cfif> 
			</cfloop>
			<td align="right" style="padding-right:5px;">
				#numberformat(i_amount)#
				<cfswitch expression="#s_fuelType#">
					<cfcase value="Helium Isotopes"><span style="color: blue;">&nbsp;#numberFormat(i_amount\300)# Ice</span></cfcase>
					<cfcase value="Oxygen Isotopes"><span style="color: blue;">&nbsp;#numberFormat(i_amount\300)# Ice</span></cfcase>
					<cfcase value="Hydrogen Isotopes"><span style="color: blue;">&nbsp;#numberFormat(i_amount\300)# Ice</span></cfcase>
					<cfcase value="Nitrogen Isotopes"><span style="color: blue;">&nbsp;#numberFormat(i_amount\300)# Ice</span></cfcase>
					<cfcase value="Heavy Water"><span style="color: blue;">&nbsp;#numberFormat(i_amount\1000)# Ice</span></cfcase>
					<cfcase value="Liquid Ozone"><span style="color: blue;">&nbsp;#numberFormat(i_amount\1000)# Ice</span></cfcase>
				</cfswitch>				
			</td>
		</tr>
	</cfoutput>
</cfoutput>
<cfoutput>
	<tr>
		<td class="header" align="left" style="padding-right:5px;"></td>
		<td class="header" align="right" style="padding-right:5px;"></td>
		<td class="header" align="right" style="padding-right:5px;" colspan="2"><strong>Cash Needed</strong></td>
		<td class="header" align="right" style="padding-right:5px;"><strong>#dollarformat(i_total)#</strong></td>
		<td class="header" align="right" style="padding-right:5px;"></td>
	</tr>
</cfoutput>	
</table>
<br>
<!--- END: Fuel Reserve --->

<!--- BEGIN: Fuel --->
<div class="headersmall">Fuel Detail</div>
<cfquery datasource="braddoro" name="q_fuel">
	SELECT *
	FROM dyn_pos_fuel_reserve_location L
	where fuelLocationID = #i_fuelLocationID#
</cfquery>

<cfoutput>
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
	<input type="hidden" id="pid" name="pid" value="#s_pid#">
`	<table class="inputtable">
		
	<tr>
	<td class="leftcol">System</td>
	<td><input type="text" id="systemName" name="systemName" value="#q_fuel.system#" size="20"></td>			
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
<cfif task EQ "add" or task EQ "edit">
	<script language="JavaScript">document.getElementById("systemName").focus();</script>
</cfif>
</cfoutput>

<cfquery datasource="braddoro" name="q_owner">
	select R.reserveID, reserveName, fuelLocationID, system, amount, destination, fuelType, volume, fuelDate
	from dyn_pos_fuel_reserves R
	inner join dyn_pos_fuel_reserve_location L 
	    on R.reserveID = L.reserveID
	inner join dyn_pos_owners O
		on R.ownerID = O.ownerID
		and O.publicID = '#s_pid#'
	inner join cfg_pos_volume V
		on L.fuelType = V.itemName
	order by reserveName, system, fuelType
</cfquery>
<cfset i_cols = 7>
<table class="inputtable">
<cfoutput query="q_owner" group="reserveName">
	<tr>
		<td colspan="#i_cols#"><strong>#reserveName#</strong> <a href="#s_filename#?reserveID=#reserveID#&fuelLocationID=0&task=add&pid=#s_pid#"><img src="Button-Add-16x16.png" border="0" height="#i_iconSize#" width="#i_iconSize#" title="add"></a></td>
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
				<td align="left" style="padding-right:5px;"><a href="#s_filename#?fuelLocationID=#fuelLocationID#&task=edit&pid=#s_pid#"><img src="Button-Play-16x16.png" border="0" height="#i_iconSize#" width="#i_iconSize#" title="edit"></a></td>
				<td align="left" style="padding-right:5px;">#fuelType#</td>
				<td align="right" style="padding-right:5px;">#numberformat(amount)#</td>
				<td align="right" style="padding-right:5px;">#numberformat(amount*volume)#</td>
				<td align="left" style="padding-right:5px;">#destination#</td>
				<td align="left" style="padding-right:5px;">#dateFormat(fuelDate,"mm/dd/yyyy")#</td>
				<td align="left" style="padding-right:5px;"><a href="#s_filename#?fuelLocationID=#fuelLocationID#&task=del&pid=#s_pid#"><img src="Button-Delete-16x16.png" border="0" height="#i_iconSize#" width="#i_iconSize#" title="delete"></a></td>
			</tr>
		</cfoutput>
		<tr>
			<td colspan="#i_cols#"></td>
		</tr>
	</cfoutput>
</cfoutput>
	<tr>
		<td class="header" align="left" style="padding-right:5px;">&nbsp;</td>
		<td class="header" align="left" style="padding-right:5px;"></td>
		<td class="header" align="right" style="padding-right:5px;"></td>
		<td class="header" align="right" style="padding-right:5px;"></td>
		<td class="header" align="left" style="padding-right:5px;"></td>
		<td class="header" align="left" style="padding-right:5px;"></td>
		<td class="header" align="left" style="padding-right:5px;"></td>
	</tr>
</table>
<br>
<!--- END: Fuel --->
</body> 
</html>