<cfinclude template="head.cfm">
<cfprocessingdirective suppresswhitespace="true">
<cfoutput>
<!--- Begin Page Content --->

<cfparam name="searchinput" type="string" default="">

<cfquery datasource="bsa" name="q_posts">
	select postID, subject, postDate, postText, addedBy, oldID, publicID 
	from dyn_post 
<cfif searchinput NEQ "">
	where postText like '%#searchinput#%'
</cfif>
	order by postDate DESC 
<cfif searchinput EQ "">
	LIMIT 30;
</cfif>
</cfquery>

<cfif searchinput NEQ "">
	<cfset s_display = "inline-block">
<cfelse>
	<cfset s_display = "none">
</cfif>

<div class="">
	<span id="search" onclick="js_collapseThis('span_search_input','inline-block');" style="cursor: pointer;">&nbsp;Search</span><br>
	<span id="span_search_input" name="span_search_input" style="display:#s_display#;">
		<form action="#GetFileFromPath(GetCurrentTemplatePath())#" method="post" id="searchForm" name="searchForm">&nbsp;<input type="text" id="searchinput" name="searchinput" size="15" value="#searchinput#">
		<input type="submit" id="searchGo" name="searchGo" value="Go">&nbsp;<cfif isdefined("q_posts") and q_posts.recordCount GT 0><span style="font-size:.75em">(results: #q_posts.recordCount#)</span></cfif>
		</form>
	</span>
</div>
<cfloop query="q_posts">
<div id="div_#publicID#">
	<div id="div_#publicID#_bar" class="color4 thinborder_nobottom" style="font-size:1.25em;font-weight:bold;">#subject#</div>
	<div id="div_#publicID#_text" class="color5 thinborder">#replace(postText,chr(10),"<br>","All")#
		<div class="color5" align="right" style="font-size:.66em;color:##FFFFFF;">
		posted: #dateformat(postDate,"dddd")# #dateformat(postDate,"mm/dd/yyyy")# #timeformat(postDate,"hh:mm TT")#
		<a href="newpost.cfm?publicID=#publicID#">edit</a>
		</div>
	</div>
	<br>
</div>
</cfloop>

<!--- End Page Content --->
</cfoutput>
</cfprocessingdirective>
<cfinclude template="foot.cfm">