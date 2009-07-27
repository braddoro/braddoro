<link href="bsa.css" rel="stylesheet" type="text/css" media="screen">
<cfprocessingdirective suppresswhitespace="true">
<cfoutput>
<cfparam name="n" type="string" default="">
<cfquery datasource="bsa" name="q_posts">
	select postID, subject, postDate, postText, addedBy, oldID, publicID 
	from dyn_post 
	where publicID = '#n#'
	order by postDate DESC 
</cfquery>
<cfloop query="q_posts">
<div id="div_#publicID#" class="base">
	<div id="div_#publicID#_bar" class="color4 thinborder_nobottom">#subject#</div>
	<div id="div_#publicID#_text" class="color5 thinborder">#replace(postText,chr(10),"<br>","All")#
		<div class="color5" align="right" style="font-size:.66em;color:##FFFFFF;">
		posted: #dateformat(postDate,"dddd")# #dateformat(postDate,"mm/dd/yyyy")# #timeformat(postDate,"hh:mm TT")#
		</div>
	</div>
	<br>
</div>
</cfloop>
</cfoutput>
</cfprocessingdirective>