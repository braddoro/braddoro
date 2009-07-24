<cfquery datasource="bsa" name="q_posts">select postID, subject, postDate, postText, addedBy, oldID, publicID from dyn_post order by postDate DESC LIMIT 30;</cfquery>
<cfoutput>
<rss version="2.0">
<channel>
<title>BSA Troop 18, Newell NC</title>
<webMaster>troopeighteen@gmail.com</webMaster>
<language>en-US</language>
<link>http://bsatroop18.org/</link>
<description>RSS Feed</description>
<pubDate>#dateformat(now(),"ddd, dd mmm yyyy")# #timeformat(now(),"HH:mm:ss")# EST</pubDate>
<generator>BSA Troop 18</generator>
<cfloop query="q_posts">
	<item>
	<title>#HTMLEditFormat(subject,"3.2")#</title>
	<link>http://bsatroop18.org/show.cfm?n=#publicID#</link>
	<description>#HTMLEditFormat(postText,"3.2")#</description>
	<guid isPermaLink="false">http://bsatroop18.org/show.cfm?n=#publicID#</guid>
	<pubDate>#dateformat(postDate,"ddd, dd mmm yyyy")# #timeformat(postDate,"HH:mm:ss")# EST</pubDate>
	<category>BSA</category>
	<author>BSA Troop 18</author>
	</item>
</cfloop>	
</channel>
</rss>
</cfoutput>