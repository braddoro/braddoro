<cftry>
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
</head>
<body class="body">
<div id="div_top" class="divtop">
<cfquery datasource="braddoro" name="q_stationFuel">
SELECT 
S.stationID,
S.ownerID, 
S.stationName, 
S.system, 
S.planet, 
S.moon, 
S.raceID, 
S.stationTypeID,
T.stationTypeID, 
T.raceID, 
T.[size] as 'size', 
T.maxUse, 
T.coolant, 
T.enrichedUranium, 
T.mechanicalParts, 
T.oxygen, 
T.robotics, 
T.strontiumCathrates, 
T.isotopes, 
T.charter, 
T.power, 
T.cpu, 
T.fuelBaySize, 
T.strontiumBaySize,
F.stationFuelID,
F.stationID,
F.coolant,
F.enrichedUranium,
F.heavyWater,
F.liquidOzone,
F.mechanicalParts,
F.isotopes,
F.oxygen,
F.robotics,
F.strontiumCathrates,
F.charter,
F.powerUsed,
F.cpuUsed
FROM dyn_station S
inner join cfg_stationtype T
on S.stationTypeID = T.stationTypeID
inner join dyn_station_fuel F
on S.stationID = F.stationID
</cfquery>
<cfloop query="q_stationFuel">
#stationName#<br>
</cfloop>
</div>
</body>
</html>
</cfoutput>
<cfcatch type="any">
	<cfoutput>
		#cfcatch.message#
		#cfcatch.detail#
		#cfcatch.type#
		<!--- #cfcatch.tagContext# --->
		#cgi.REMOTE_ADDR#
	</cfoutput>
</cfcatch>
</cftry>