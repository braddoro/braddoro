<cfset lcl_dsn = "braddoro">
<cfset obj_application = createObject("component","application_logic").init(dsn=lcl_dsn)>
<cfoutput>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title>#obj_application.getSiteTitle()#</title>
<head>
<!--- <link href="#obj_application.getCSSfile()#" rel="stylesheet" type="text/css"> --->
<link href="braddoro.css" rel="stylesheet" type="text/css">
</head>
<body class="body">
<div id="div_top" class="divtop">
<fieldset>
<div id="div_banner" class="banner"><cfoutput>#obj_application.banner(userID=0)#</cfoutput></div>
<div id="quote">#obj_application.Quote()#</div>
</fieldset>
</div>
<body class="body">
<div id="div_main" class="divright">
<cfif isdefined("url.n") and val(url.n) GT 0>
	<cfset obj_content_sql = createObject("component","content_sql").init(dsn=lcl_dsn)>
	<cfset q_getPosts = obj_content_sql.getPosts(postID=val(url.n))>
	<cfset obj_content_display = createObject("component","content_display")>	
	#obj_content_display.showPosts(postQuery=q_getPosts,userID=0)#
</cfif>
</div>
</body>
</html>
</cfoutput>