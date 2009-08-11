<cfparam name="attributes.displayString" type="string" default="">
<cfparam name="attributes.dropdownName" type="string" default="">
<cfparam name="attributes.itemList" type="string" default="">
<cfparam name="attributes.selectedValue" type="string" default="">
<cfparam name="attributes.defaultOption" type="string" default="">
<cfparam name="attributes.defaultValue" type="string" default="">
<cfparam name="attributes.script" type="string" default="">
<cfoutput>
#attributes.displayString#<select id="#attributes.dropdownName#" name="#attributes.dropdownName#" onChange="#attributes.script#">
<option value="#attributes.defaultValue#">#attributes.defaultOption#</option>
<cfloop list="#attributes.itemList#" index="s_current">
	<option value="#s_current#"<cfif attributes.selectedValue EQ s_current> SELECTED</cfif>>#s_current#</option>
</cfloop>
</select>
</cfoutput>