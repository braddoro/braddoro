<cfcomponent output="false">

<cfproperty name="module_dsn" displayname="module_dsn" type="string" default="">
<cfproperty name="module_siteTitle" displayname="module_siteTitle" type="string" default="braddoro.com">

<cffunction name="getSiteTitle" access="public" output="false" returntype="string">
	<cfreturn module_siteTitle>
</cffunction>

<cffunction name="init" displayname="init" access="public" output="false">
	<cfargument required="true" type="string" name="dsn">
	<cfset module_dsn = arguments.dsn>
	<cfreturn this>
</cffunction>

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="fail">
	<cfargument name="userID" type="numeric" default="0">
	<cfargument name="message" type="string" default="">
	<cfargument name="detail" type="string" default="">
	<cfargument name="type" type="string" default="">
	<cfargument name="tagContext" type="Array" default="">
	<cfargument name="remoteIP" type="string" default="">

	<cfset obj_application_sql = createObject("component","error_sql").init(dsn=module_dsn)>
	<cfset x = obj_application_sql.fail(argumentCollection=arguments)>
	<cfif arguments.remoteIP EQ "75.176.87.141" or arguments.userID EQ 12>
		<cfset lcl_showError = true>
	<cfelse>
		<cfset lcl_showError = false>
	</cfif>
	<cfset obj_error_display = createObject("component","error_display")>	
	<cfsavecontent variable="s_fail">
	<cfoutput>#obj_error_display.fail(message=arguments.message,detail=arguments.detail,type=arguments.type,tagContext=arguments.tagContext,showError=lcl_showError,remoteIP=arguments.remoteIP)#</cfoutput>
	</cfsavecontent>	

	<cfreturn s_fail>
</cffunction>
<!--- End Function --->

<cfscript>
function SQLSafe(string) {
  var sqlList = "-- ,'";
  var replacementList = "#chr(38)##chr(35)##chr(52)##chr(53)##chr(59)##chr(38)##chr(35)##chr(52)##chr(53)##chr(59)# , #chr(38)##chr(35)##chr(51)##chr(57)##chr(59)#";
  return trim(replaceList(string,sqlList,replacementList));
}
</cfscript>

	
</cfcomponent>