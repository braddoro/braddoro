<cfprocessingdirective suppresswhitespace="true">
<cfoutput>
#now()#<br>
#createObject("component","dateInput_c").showTime(currentDate=now(),fieldName="test",minuteRange=5)#
#createObject("component","dateInput_c").showDate(currentDate=now(),fieldName="test")#
</cfoutput>
</cfprocessingdirective>