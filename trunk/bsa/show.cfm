<cfprocessingdirective suppresswhitespace="true">
<cfoutput>
<!--- Begin Page Content --->

<cfparam name="n" type="string" default="">

<cfquery datasource="bsa" name="q_posts">
	select postID, subject, postDate, postText, addedBy, oldID, publicID 
	from dyn_post 
	where publicID = '#n#'
	order by postDate DESC 
</cfquery>

<cfloop query="q_posts">
<div id="div_#publicID#">
	<div id="div_#publicID#_bar" class="color4 thinborder_nobottom" style="font-size:1.25em;font-weight:bold;">#subject#</div>
	<div id="div_#publicID#_text" class="color5 thinborder">#replace(postText,chr(10),"<br>","All")#
		<div class="color5" align="right" style="font-size:.66em;color:##FFFFFF;">
		posted: #dateformat(postDate,"dddd")# #dateformat(postDate,"mm/dd/yyyy")# #timeformat(postDate,"hh:mm TT")#
		</div>
	</div>
	<br>
</div>
</cfloop>

<!--- End Page Content --->
</cfoutput>
</cfprocessingdirective>