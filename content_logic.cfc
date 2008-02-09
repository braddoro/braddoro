<cfcomponent displayname="content_logic.cfc" output="false">

<cfproperty name="module_dsn" displayname="module_dsn" type="string" default="">

<cffunction name="init" displayname="init" access="public" output="false">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>

<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="displayPosts">
	<cfargument name="numberToGet" type="numeric" required="true">
	<cfargument name="userID" type="numeric" required="true">

	<cfset obj_content_sql = createObject("component","content_sql").init(dsn=module_dsn)>
	<cfset q_getPosts = obj_content_sql.getPosts(numberToGet=arguments.numberToGet)>
	<cfset obj_content_display = createObject("component","content_display")>	
	<cfsavecontent variable="s_displayPosts">
	<cfoutput>#obj_content_display.showPosts(postQuery=q_getPosts,userID=arguments.userID)#</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_displayPosts>
</cffunction>
<!--- End Function --->


<!--- Begin Function  --->
<cffunction access="public" output="false" returntype="string" name="showSearch">

	<cfset obj_content_sql = createObject("component","content_sql").init(dsn=module_dsn)>
	<cfset q_topics = obj_content_sql.getTopics()>
	<cfset obj_content_display = createObject("component","content_display")>
	<cfsavecontent variable="s_showSearch">
	<cfoutput>#obj_content_display.showSearch(topicList=q_topics)#</cfoutput>
	</cfsavecontent>
	
	<cfreturn s_showSearch>
</cffunction>

</cfcomponent>