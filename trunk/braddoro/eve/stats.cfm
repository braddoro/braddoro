<cfparam name="url.killerAlliance" type="string" default="">
<cfparam name="url.killerCorp" type="string" default="">
<cfparam name="url.killer" type="string" default="">
<cfparam name="url.killedAlliance" type="string" default="">
<cfparam name="url.killedCorp" type="string" default="">
<cfparam name="url.killed" type="string" default="">
<cfquery name="q_killers" datasource="braddoro">
SELECT distinct 
	k2.alliance, 
	k2.corp, 
	k2.name 
FROM braddoro.dyn_killmail k1
INNER JOIN braddoro.dyn_killmail_killers k2 
	ON k1.killmailID = k2.killmailID
WHERE k1.deleted = 0 
<cfif url.killerAlliance NEQ "">
	and k2.alliance like '%#url.killerAlliance#%'
</cfif>
<cfif url.killerCorp NEQ "">
	and k2.corp like '%#url.killerCorp#%'
</cfif>
<cfif url.killer NEQ "">
	and k2.name like '%#url.killer#%'
</cfif>
<cfif url.killedAlliance NEQ "">
	and k1.alliance like '%#url.killedAlliance#%'
</cfif>
<cfif url.killedCorp NEQ "">
	and k1.corp like '%#url.killedCorp#%'
</cfif>
<cfif url.killed NEQ "">
	and k1.victim like '%#url.killed#%'
</cfif>
ORDER BY 
	k2.alliance, 
	k2.corp, 
	k2.name,
	k1.killmailDateTime
</cfquery>
<cfquery name="q_killed" datasource="braddoro">
SELECT distinct 
	k1.killmailDateTime,
	k1.alliance, 
	k1.corp, 
	k1.victim,
	k1.uniqueID,
	k1.destroyed
FROM braddoro.dyn_killmail k1
INNER JOIN braddoro.dyn_killmail_killers k2 
	ON k1.killmailID = k2.killmailID
WHERE k1.deleted = 0 
<cfif url.killerAlliance NEQ "">
	and k2.alliance like '%#url.killerAlliance#%'
</cfif>
<cfif url.killerCorp NEQ "">
	and k2.corp like '%#url.killerCorp#%'
</cfif>
<cfif url.killer NEQ "">
	and k2.name like '%#url.killer#%'
</cfif>
<cfif url.killedAlliance NEQ "">
	and k1.alliance like '%#url.killedAlliance#%'
</cfif>
<cfif url.killedCorp NEQ "">
	and k1.corp like '%#url.killedCorp#%'
</cfif>
<cfif url.killed NEQ "">
	and k1.victim like '%#url.killed#%'
</cfif>
ORDER BY 
	k1.alliance, 
	k1.corp, 
	k1.victim
</cfquery>
<style type="text/css">
.large {font-size 1.2 em;}
.indent0 {margin-left:0px;font-weight:bold;}
.indent1 {margin-left:10px;}
.indent2 {margin-left:20px;}
.indent3 {margin-left:40px;font-size:.75em;}
.indent4 {margin-left:40px;}
</style>
<html>
<head>
<title>Free Worlds Alliance Killmail Stats</title>
<!--- <script type="text/javascript" src="utility.js"></script> --->
<script language="javascript">
function js_collapseThis(changeme) {
	if (document.getElementById(changeme).style.display == "block") {
		document.getElementById(changeme).style.display = "none";
	} else {
		document.getElementById(changeme).style.display = "block";
	}
}
</script>
</head>
<body>
<cfoutput>
<h4>Free Worlds Alliance Killmail Stats</h4>
<cfinclude template="links.cfm">
<b>
<cfif url.killerAlliance NEQ "">
Searching for: #url.killerAlliance#
</cfif>
<cfif url.killerCorp NEQ "">
Searching for: #url.killerCorp#
</cfif>
<cfif url.killer NEQ "">
Searching for: #url.killer#
</cfif>
<cfif url.killedAlliance NEQ "">
Searching for: #url.killedAlliance#
</cfif>
<cfif url.killedCorp NEQ "">
Searching for: #url.killedCorp#
</cfif>
<cfif url.killed NEQ "">
Searching for: #url.killed#
</cfif><br>
</b>
<span style="cursor:hand;" onclick="js_collapseThis('div_killers');"><h3>Killers</h3></span>
</cfoutput>
<div id="div_killers" style="display:block;">
<hr>
<cfoutput query="q_killers" group="alliance">
	<div class="indent0">&rsaquo;&nbsp;<a href="stats.cfm?killerAlliance=#URLEncodedFormat(alliance)#">#alliance#</a></div>
	<cfoutput group="corp">
		<div class="indent1">&raquo;&nbsp;<a href="stats.cfm?killerCorp=#URLEncodedFormat(corp)#">#corp#</a></div>
		<cfoutput>
			<div class="indent2">&middot;&nbsp;<a href="stats.cfm?killer=#URLEncodedFormat(name)#">#name#</a></div>
		</cfoutput>
		<br>
	</cfoutput>
	<br>
</cfoutput>
</div>
<span style="cursor:hand;" onclick="js_collapseThis('div_killed');"><h3>Killed</h3></span>
<hr>
<div id="div_killed" style="display:block;">
<cfoutput query="q_killed" group="alliance">
	<div class="indent0">&rsaquo;&nbsp;<a href="stats.cfm?killedAlliance=#URLEncodedFormat(alliance)#">#alliance#</a></div>
	<cfoutput group="corp">
		<div class="indent1">&raquo;&nbsp;<a href="stats.cfm?killedCorp=#URLEncodedFormat(corp)#">#corp#</a></div>
		<cfoutput group="victim">
			<div class="indent2">&dagger;&nbsp;<a href="stats.cfm?killed=#URLEncodedFormat(victim)#">#victim#</a></div>
			<cfoutput>
				<div class="indent3"><a href="stats.cfm?killed=#URLEncodedFormat(victim)#">#dateformat(killmailDateTime,"mm/dd/yyyy")# #timeformat(killmailDateTime,"hh:mm TT")# #destroyed#</a>&nbsp;-&nbsp;<a href="show.cfm?n=#uniqueID#" target="_blank">[view]</a></div>
			</cfoutput>
		</cfoutput>
		<br>
	</cfoutput>
	<br>
</cfoutput>
</div>
</body>
</html>