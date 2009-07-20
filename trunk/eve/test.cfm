<cfprocessingdirective suppresswhitespace="true">
<cfoutput>
#now()#<br>
#createObject("component","dateInput_c").showTime(currentDate=now(),fieldName="test")#
#createObject("component","dateInput_c").showDate(currentDate=now(),fieldName="test")#
</cfoutput>
</cfprocessingdirective>