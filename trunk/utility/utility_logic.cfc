<cfcomponent output="false">

<!--- Begin Function  --->
<cffunction name="init" displayname="init" access="package" output="false">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>

	<cfreturn this>
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