<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
<title>Ship Fitting</title>
<link rel="stylesheet" href="input.css" type="text/css">
<script language="javascript" type="text/javascript" src="input.js"></script>
</head>
<body>
<?php include("import_fit.php"); ?>
<div id="div_input" name="div_input"></div>
<br/>
<div id="div_output" name="div_output"></div>
<script language="javascript" type="text/javascript">
<?php 
$b_command = 0;
if (isset($_REQUEST["command"])) {
	if ($_REQUEST["command"] == 1) {
		$b_command = 1;	
	} else {
		$b_command = 0;
	}
}
echo "g_command = $b_command"; ?>;
js_ajax('edit',0,'div_input');
js_ajax('show',0,'div_output');
</script>
</body>
</html>
