<cfoutput>
<rss version="2.0">
<channel>
<title>braddoro rss feed</title>
<webMaster>braddoro@yahoo.com</webMaster>
<language>en-US</language>
<link>http://braddoro.com/</link>
<description>braddoro</description>
<pubDate>#dateformat(now(),"ddd, dd mmm yyyy")# #timeformat(now(),"HH:mm:ss")# EST</pubDate>
<generator>brad</generator>
<docs>http://cyber.law.harvard.edu/rss/rss.html</docs>
<cfset obj_content_sql = createObject("component","content_sql").init(dsn="braddoro")>
<cfset q_getPosts = obj_content_sql.getPosts(numberToGet=20)>
<cfloop query="q_getPosts">
	<item>
	<title>#Topic# :: #HTMLEditFormat(Title,"3.2")#</title>
	<link>http://braddoro.com/braddoro/show.cfm?n=#postID#</link>
	<description>#HTMLEditFormat(Post,"3.2")#</description>
	<guid isPermaLink="false">#PostID#</guid>
	<pubDate>#dateformat(addedDate,"ddd, dd mmm yyyy")# #timeformat(addedDate,"HH:mm:ss")# EST</pubDate>
	<comments>http://braddoro.com/braddoro/show.cfm?n=#postID#</comments>
	<category>#Topic#</category>
	<author>#siteName#</author>
	</item>
</cfloop>	
</channel>
</rss>
</cfoutput>