<cfinclude template="head.cfm">
<cfprocessingdirective suppresswhitespace="true">
<cfoutput>
<!--- Begin Page Content --->

<div onclick="js_collapseThis('div_showcalendar');" style="cursor: pointer;" title="Click to show or hide.">&nbsp;Troop Calendar</div>
<div align="center" id="div_showcalendar" style="display:none;">
<iframe src="http://www.google.com/calendar/embed?title=Troop%2018%20Events&amp;height=600&amp;wkst=2&amp;bgcolor=%23FFFFFF&amp;src=kqfrn0cp2jsdq3kd6o0dtot7m4%40group.calendar.google.com&amp;color=%23528800&amp;src=%23moonphase%40group.v.calendar.google.com&amp;color=%23AB8B00&amp;src=usa__en%40holiday.calendar.google.com&amp;color=%230D7813&amp;ctz=America%2FNew_York" style=" border-width:0 " width="800" height="600" frameborder="0" scrolling="no"></iframe>
<br><a href="http://www.google.com/calendar/ical/kqfrn0cp2jsdq3kd6o0dtot7m4@group.calendar.google.com/public/basic.ics">download calendar</a>
</div>
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
	<span id="search" onclick="js_collapseThis('span_search_input','inline-block');" style="cursor: pointer;">&nbsp;Search Messages</span><br>
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
		<a href="#s_spoofedURL#newpost.cfm?publicID=#publicID#">edit</a>
		</div>
	</div>
	<br>
</div>
</cfloop>

<!--- End Page Content --->
</cfoutput>
</cfprocessingdirective>
<cfinclude template="foot.cfm">