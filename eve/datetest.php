<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<script language="javascript" type="text/javascript" src="..\common\mootools-1.2.4-core-nc.js"></script>
<script language="javascript" type="text/javascript" src="..\common\datepicker.js"></script>
<link rel="stylesheet" href="..\common\datepicker_vista.css" type="text/css">
<style type="text/css">
	input.date {width: 150px;color: #000;};
</style>
<script language="javascript" type="text/javascript">
	window.addEvent("load", function() {new DatePicker(".demo_vista", {pickerClass: "datepicker_vista", format: "m/d/Y", positionOffset: { x: 0, y: 5 }});});
</script>
</head>
<body>
<form id="search" name="search">
	<table class="searchtable" border="0" id="td_searchInput">

	<tr>
	<td class="searchlabel">Date:</td>
	<td colspan="2">
	<input name="startDate" type="text" value="" class="date demo_vista" />
	<input name="endDate" type="text" value="" class="date demo_vista" />
	</td>
	</tr>

	<tr>
	<td class="searchlabel"></td>
	<td><input type="submit" name="go" value="Submit"></td>
	<td>&nbsp;</td>
	</tr>

	</table>
</form>
</body>
</html>
