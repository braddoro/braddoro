<hr>
<cfoutput>
<!--- 
<cfset filePath = GetFileFromPath(GetCurrentTemplatePath())>
<cfset fileObj = createObject("java","java.io.File").init(expandPath(filePath))>
<cfset fileDate = createObject("java","java.util.Date").init(fileObj.lastModified())>
#fileObj.lastModified()#
 --->

<!--- <cfset myFile = CreateObject("java", "java.io.File")>
<cfset myFile.init(GetCurrentTemplatePath())>
<cfset last_modified = myFile.lastModified()>
#last_modified#<br> --->
<!--- #dateformat(last_modified,"mm/dd/yyyy")# #timeformat(last_modified,"hh:mm TT")# --->

<!--- <cfset filePath = "#GetCurrentTemplatePath()#">
<cfset fileObj = createObject("java","java.io.File").init(filePath)>
<cfset fileDate = createObject("java","java.util.Date").init(fileObj.lastModified())>
#dateformat(fileDate,"mm/dd/yyyy")# #timeformat(fileDate,"hh:mm TT")# --->
</cfoutput>
</body>
</html>