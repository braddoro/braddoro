<cfcomponent output="false">
	<cffunction name="daysToOffline" access="package" output="false" returntype="numeric">
		<cfargument name="towerID" type="numeric" required="true">
		
		<cfset i_daysToOffline = 60>

		<cfquery datasource="braddoro" name="q_attributes">
			SELECT T.towerID, D.attributeGroup, D.attribute, D.attributeValue, C.attributeValue as 'usePerHour', V.volume
			FROM dyn_pos_tower T 
			inner join dyn_pos_tower_attributes D
			    on T.towerID = D.towerID
			    and T.towerID = #arguments.towerID#
			left join cfg_pos_volume V
				on D.attribute = V.itemName
			inner join cfg_pos_tower_attributes C
			    on D.towerTypeID = C.towerTypeID
			    and D.attributeGroup = C.attributeGroup
			    and D.attribute = C.attribute
				and D.attributeGroup = 'Fuel'
				and D.attribute <> 'Strontium Clathrates'
			order by C.attributeGroup, C.attribute  
		</cfquery>
		<cfquery datasource="braddoro" name="q_maxUse">
			SELECT 
			attribute, 
			attributeValue as 'maxuse'
			FROM dyn_pos_tower_attributes 
            where towerID = #arguments.towerID#
			and attributeGroup = 'Base'
			and (attribute = 'Liquid Ozone per Hour' or attribute = 'Heavy Water per Hour' or attribute = 'Fuel Days' or attribute = 'Strontium Hours')
			order by attribute
        </cfquery>
		<cfset i_days = q_maxUse.maxuse[1]>
		<cfset i_hours = q_maxUse.maxuse[4]>

		<cfoutput query="q_attributes">
			<cfset s_fieldName = replace(attribute," ","_","All")>
			<cfset i_userPerHour = 0>
			<cfset i_daysLeft = 0>
			<cfswitch expression="#q_attributes.attribute#">
			<cfcase value="Heavy Water">
				<cfset i_userPerHour = val(q_maxUse.maxuse[2])>
				<cfset i_default = ((i_userPerHour*24)*i_days)-attributeValue>
				<cfif i_userPerHour NEQ 0 and i_userPerHour NEQ 0>
					<cfset i_daysLeft = (attributeValue/i_userPerHour)/24>
				<cfelse>
					<cfset i_daysLeft = i_daysToOffline>
				</cfif>
			</cfcase>
			<cfcase value="Liquid Ozone">
				<cfset i_userPerHour = val(q_maxUse.maxuse[3])>
				<cfset i_default = ((i_userPerHour*24)*i_days)-attributeValue>
				<cfif i_userPerHour NEQ 0 and i_userPerHour NEQ 0>
					<cfset i_daysLeft = (attributeValue/i_userPerHour)/24>
				<cfelse>
					<cfset i_daysLeft = i_daysToOffline>
				</cfif>
			</cfcase>
			<cfdefaultcase>
				<cfset i_userPerHour = val(usePerHour)>
				<cfset i_default = (i_userPerHour*24)*i_days-attributeValue>
				<cfif i_userPerHour NEQ 0 and i_userPerHour NEQ 0>
					<cfset i_daysLeft = (attributeValue/i_userPerHour)/24>
				<cfelse>
					<cfset i_daysLeft = i_daysToOffline>
				</cfif>
			</cfdefaultcase>
			</cfswitch>
			<cfif i_daysLeft LT i_daysToOffline>
				<cfset i_daysToOffline = i_daysLeft> 
			</cfif>
			
		</cfoutput>
	
		<cfreturn i_daysToOffline>
	</cffunction>


	<cffunction name="getMarketInfo" access="package" output="false" returntype="string">
		<cfargument name="eveID" type="numeric" required="true">
		<cfargument name="type" type="string" required="true">

		<cfset s_url = "http://eve-central.com/api/marketstat?typeid=#arguments.eveID#&regionlimit=10000002">
		<cfhttp url="#s_url#" method="GET" resolveurl="Yes" throwOnError="Yes"/>
		<cfset s_xmlDoc = xmlParse(CFHTTP.FileContent)>
		<cfset s_elements = xmlSearch(s_xmlDoc, "/marketstat/sell")>
		<!---<cfset s_resources = s_xmlDoc.xmlroot.xmlChildren>--->
				
		<cfsavecontent variable="s_getMarketInfo">
		<cfoutput>
		<cfdump var="#s_elements#">
			<!---<cfdump var="#s_resources#">--->
			<!---myxmldoc = xmlParse(s_xmlDoc);--->
			<!---<cfscript>
				selectedElements = xmlSearch(s_xmlDoc, "/sell");
				for (i = 1; i LTE arrayLen(selectedElements); i = i + 1) {
			      writeOutput(selectedElements[i].XmlText & "<br>");
				}
			</cfscript>--->
		</cfoutput>
		</cfsavecontent>
						
		<cfreturn s_getMarketInfo>
	</cffunction>

	<cffunction name="createTower" access="package" output="false" returntype="string">
		<cfargument name="system" type="string" required="true">
		<cfargument name="planet" type="numeric" required="true">
		<cfargument name="moon" type="numeric" required="true">
		<cfargument name="towerTypeID" type="numeric" required="true">
		<cfargument name="ownerID" type="numeric" required="true">
		
		<cfset i_towerID = 0>
		
		<cfquery datasource="braddoro" name="q_create1">
			inert into dyn_pos_tower (towerTypeID, system, planet, moon, active, ownerID, publicID)
			SELECT #arguments.towerTypeID#, '#arguments.system#', #arguments.planet#, #arguments.moon#, 1, #arguments.ownerID#, UUID() FROM dyn_pos_tower where towerTypeID = #arguments.towerTypeID# and towerID = -1
        </cfquery>

		<cfquery datasource="braddoro" name="q_create2">
			select towerID from dyn_pos_tower
			order by towerID
			limit 1   
        </cfquery>
		<cfset i_towerID = val(q_create2.towerID)>

		<cfquery datasource="braddoro" name="q_create3">
			inert dyn_pos_tower_attributes (towerID, towerTypeID, attributeGroup, attribute, attributeValue)
			SELECT #i_towerID#, #arguments.towerTypeID#, attributeGroup, attribute, attributeValue FROM dyn_pos_tower_attributes where towerTypeID = #arguments.towerTypeID# and towerID = -1  
        </cfquery>
						
		<cfreturn i_towerID>
	</cffunction>

</cfcomponent>