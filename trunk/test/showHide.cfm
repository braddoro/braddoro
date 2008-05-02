<html>
<head>
<title>show hide test</title>
<style media="all" type="text/css">
.body {
	font-family: "MS Sans Serif", Geneva, sans-serif, Arial;
	background-color: #E7E7E7;
}
.panelContainer {
	border:1px solid #999999;
	width:200px;
	float:right;
}
.panelHeader {
	border-bottom:1px solid #999999;
	background-color: cornsilk;
	padding: 2px;
}
.panelBody {
	display: block;
	background-color: EFEFEF;
	padding: 2px;
	height: 250px;
	overflow:auto;
}
.panelFooter {
	border-top: 1px solid #999999;
	background-color: #DCDCDC;
	padding: 2px;"
} 
</style>
<script language="javascript" type="text/javascript">
function js_collapseMe(changeMe) {
	if (document.getElementById(changeMe).style.display == "block") {
		document.getElementById(changeMe).style.display = "none";
	} else {
		document.getElementById(changeMe).style.display = "block";
	}
}
</script>
</head>
<body class="body">
show hide test<br>
<div id="div_container" class="panelContainer">
	<div id="div_header" class="panelHeader" onclick="js_collapseMe('div_body');">Lorem Ipsum as translated by H. Rackham in 1914</div>
	<div id="div_body" class="panelBody">On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.</div>
	<div id="div_footer" class="panelFooter">&raquo;<a href="http://www.lipsum.com/">Lorem Ipsum</a></div>
</div>
</body>
</html>