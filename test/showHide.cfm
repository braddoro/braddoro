<html>
<head>
<title>show hide test</title>
<script language="javascript" type="text/javascript">
function js_collapseMe(changeme) {
	if (document.getElementById(changeme).style.display == "block") {
		document.getElementById(changeme).style.display = "none";
	} else {
		document.getElementById(changeme).style.display = "block";
	}
}
</script>
</head>
<body>
show hide test<br>
<br>
This is an example of a show hide div to see if it works for you on your linux box in FF.<br>
<br>
<div id="div_container" style="border:1px solid black;width:200px;float:right;">
	<div id="div_header" style="border-bottom:1px solid black;background-color: cornsilk;" onclick="js_collapseMe('div_body');">This is the header</div>
	<div id="div_body" style="display:block;background-color: EFEFEF;">On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.</div>
</div>
</body>
</html>