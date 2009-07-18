<!--- <cfhttp 
   url = "http://epvg.evekb.co.uk/?a=rss"
   port = "80"
   method = "get"
   proxyServer = "hostname"
   proxyPort = "port_number"
   proxyUser = "username"
   proxyPassword = "password"
   username = "username"
   password = "password"
   userAgent = "user_agent"
   charset = "character encoding"
   resolveURL = "yes" or "no"
   throwOnError = "yes" or no"
   redirect = "yes" or "no"
   timeout = "timeout_period"
   getasbinary = "yes or no"
   multipart = "yes or no"
   path = "path"
   file = "filename"
   name = "queryname"
   columns = "query_columns"
   firstrowasheaders = "yes" or "no"
   delimiter = "character"
   textQualifier = "character"
> --->

<!--- This example displays the information provided by the Macromedia
Designer & Developer Center XML feed, 
http://www.macromedia.com/desdev/resources/macromedia_resources.xml 
See http://www.macromedia.com/desdev/articles/xml_resource_feed.html
for more information on this feed --->

<!--- http://www.macromedia.com/desdev/resources/macromedia_resources.xml --->
<!--- Set the URL address --->
<cfset urlAddress="http://rooksandkings.com/killboard/?a=kills">

<!--- Use the CFHTTP tag to get the file content represented by urladdress 
      Note that />, not an end tag. terminates this tag --->
<cfhttp url="#urladdress#" method="GET" resolveurl="Yes" throwOnError="Yes"/>

<!--- Parse the xml and output a list of resources --->
<cfset xmlDoc = XmlParse(CFHTTP.FileContent)>
<!--- Get the array of resource elements, the xmlChildren of the xmlroot --->
<cfset resources=xmlDoc.xmlroot.xmlChildren>
<cfset numresources=ArrayLen(resources)>
<cfdump var="#resources#">
<!--- <cfloop index="i" from="1" to="#numresources#">
    <cfset item=resources[i]>
    <cfoutput>
        <strong><a href=#item.url.xmltext#>#item.title.xmltext#</strong></a><br>
        <strong>Author</strong>&nbsp;&nbsp;#item.author.xmltext#<br>
        <strong>Applies to these products</strong><br>
        <cfloop index="i" from="4" to="#arraylen(item.xmlChildren)#">
            #item.xmlChildren[i].xmlAttributes.Name#<br>
        </cfloop>
        <br>
    </cfoutput>
</cfloop>
 --->