<cfparam name="displayString" type="string" default="">
<cfparam name="dropdownName" type="string" default="">
<cfparam name="itemList" type="string" default="">
<cfparam name="selectedValue" type="string" default="">
<cfparam name="defaultOption" type="string" default="">
<cfoutput>
#attributes.displayString#<select id="#attributes.dropdownName#" name="#attributes.dropdownName#">
<option value="">#attributes.defaultOption#</option>
<cfloop list="#attributes.itemList#" index="s_current">
	<option value="#s_current#"<cfif attributes.selectedValue EQ s_current> SELECTED</cfif>>#s_current#</option>
</cfloop>
</select>
</cfoutput>