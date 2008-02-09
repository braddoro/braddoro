<cfcomponent displayname="content_sql.cfc" output="false">

<cfproperty name="module_dsn" displayname="module_dsn" type="string" default="">

<cffunction name="init" displayname="init" access="public" output="false">
	<cfargument required="true" type="string" name="dsn">
	
	<cfset module_dsn = arguments.dsn>
	
	<cfreturn this>
</cffunction>


<!--- Begin Function --->
<cffunction access="package" output="false" returntype="query" name="getPosts">
	<cfargument name="numberToGet" type="Numeric" default="0">
	<cfargument name="topicID" type="numeric" default="0">
	<cfargument name="filterString" type="string" default="">
	<cfargument name="postID" type="numeric" default="0">
	<cfargument name="getNone" type="boolean" default="false">
	
	<cfquery name="q_getPosts" datasource="#module_dsn#">
		select  
		P.postID,
		T.topicID,
		T.topic,
		T.description,
		P.userID, 
		U.siteName,
		P.title, 
		P.post, 
		P.addedDate
		from braddoro.dyn_posts P
		inner join braddoro.dyn_users U
		on U.userID = P.userID
		inner join braddoro.cfg_topics T
		on T.topicID = P.topicID
		where P.active = 'Y'
	<cfif arguments.getNone>
		and 0=1
	</cfif>		
	<cfif arguments.postID GT 0>
		and P.postID = #arguments.postID#
	</cfif>
	<cfif arguments.topicID GT 0>
		and T.topicID = #arguments.topicID#
	</cfif>
	<cfif arguments.filterString GT "">
		and P.post like '%#arguments.filterString#%'
	</cfif>
		order by P.addedDate desc
	<cfif arguments.numberToGet GT 0>
		limit #arguments.numberToGet#
	</cfif>
	</cfquery>

  <cfreturn q_getPosts>
</cffunction>
<!--- End Function --->

</cfcomponent>