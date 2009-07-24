<cfinclude template="head.cfm">
<cfprocessingdirective suppresswhitespace="true">
<cfoutput>
<!--- Begin Page Content --->

<cfparam name="postID" type="numeric" default="0">
<cfparam name="publicID" type="string" default="">
<cfparam name="postDate_year" type="string" default="">
<cfparam name="postDate_month" type="string" default="">
<cfparam name="postDate_day" type="string" default="">
<cfparam name="postDate_hour" type="string" default="">
<cfparam name="postDate_minute" type="string" default="">
<cfparam name="postDate_ampm" type="string" default="">
<cfparam name="subject" type="string" default="">
<cfparam name="postText" type="string" default="">

<!--- <cfset ical = createObject("component","ical").init(data)>
<cfset results = ical.getEvents()> --->

<cfif isdefined("form.searchGo") and isdefined("form.field1") and form.field1 EQ "trustworthy1">
	<cfif postDate_ampm EQ "pm">
		<cfset s_hour = postDate_hour+12>
	<cfelse>
		<cfset s_hour = postDate_hour>
	</cfif>
	<cfset s_formDate = "#postDate_year#-#numberformat(postDate_month,'00')#-#numberformat(postDate_day,'00')# #numberformat(s_hour,'00')#:#numberformat(postDate_minute,'00')#">
	<cfif not isdate(s_formDate)>
		<cfset s_formDate = '#dateformat(now(),"yyyy-mm-dd")# #timeformat(now(),"HH:MM:SS")#'>
	</cfif>
	<cfif val(postID) GT 0>
		record updated
		<!--- #dateformat(postDate,"yyyy-mm-dd")# #timeformat(postDate,"HH:MM:SS")# --->
		<cfquery datasource="bsa" name="q_save">
			update dyn_post set
			postDate = '#s_formDate#',
			subject = '#subject#',
			postText = '#postText#'
			where postID = #val(postID)#
		</cfquery>
	<cfelse>
		record inserted
		<cfquery datasource="bsa" name="q_save">
			insert into dyn_post (postDate,subject,postText,publicID)
			values('#s_formDate#','#subject#','#postText#',UUID())
		</cfquery>
		<!--- #dateformat(postDate,"yyyy-mm-dd")# #timeformat(postDate,"HH:MM:SS")# --->
	</cfif>
</cfif>

<cfquery datasource="bsa" name="q_edit">
	select * 
	from dyn_post
	where postID = 0
<cfif val(postID) GT 0>
	or postID = #val(postID)#
</cfif>
<cfif publicID NEQ "">
	or publicID = '#publicID#'
</cfif>
</cfquery>


<cfif val(q_edit.postID) GT 0>
	<cfset s_value = "Save">
	<cfset s_postDate = dateformat(q_edit.postDate,"mm/dd/yyyy")>
	<cfset s_postTime = timeformat(q_edit.postDate,"hh:mm TT")>
<cfelse>
	<cfset s_value = "Add">
	<cfset s_postDate = dateformat(now(),"mm/dd/yyyy")>
	<cfset s_postTime = timeformat(now(),"hh:mm TT")>
</cfif>
<form action="#GetFileFromPath(GetCurrentTemplatePath())#" method="post" id="searchForm" name="searchForm">
<input type="hidden" id="postID" name="postID" value="#val(q_edit.postID)#">
<div>Post Date</div><div>
	#createObject("component","dateInput_c").showDate(currentDate=s_postDate,fieldName="postDate")#
	<!--- <input type="text" id="postDate" name="postDate" size="10" value="#s_postDate#"> --->
	#createObject("component","dateInput_c").showTime(currentDate=s_postTime,fieldName="postDate",minuteRange=5,use24=false)#
</div>
<div>Title</div><div><input type="text" id="subject" name="subject" size="75" value="#q_edit.subject#"></div>
<div>Message</div><div><textarea rows="20" cols="60" id="postText" name="postText">#q_edit.postText#</textarea></div>
<div>Password</div><div><input type="text" id="field1" name="field1" value=""></div>
<div>&nbsp;</div><div><input type="submit" id="searchGo" name="searchGo" value="#s_value#"></div>
</form>

<!--- End Page Content --->
</cfoutput>
</cfprocessingdirective>
<cfinclude template="foot.cfm">