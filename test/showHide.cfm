<html>
<head>
<title>panel test</title>
<style media="all" type="text/css">
.body {
	font-family: "MS Sans Serif", Geneva, sans-serif, Arial;
	background-color: #E7E7E7;
}
.panelContainer {
	border: 1px solid #999999;
	width: 250px;
}
.panelHeader {
	border-bottom: 1px solid #999999;
	background-color: #003366;
	color: #FFFFFF;
	padding: 2px;
	font-weight: bold;
}
.panelBody {
	display: block;
	background-color: white;
	padding: 2px;
	height: 250px;
	overflow:auto;
}
.panelFooter {
	border-top: 1px solid #999999;
	background-color: #DCDCDC;
	padding: 1px;
}
.searchInput {
	border-bottom: 1px solid #999999;
	background-color: white;
	padding: 1px;
	height: 75px;
}
.searchOutput {
	border-bottom: 1px solid #999999;
	background-color: white;
	padding: 1px;
	height: 175px;
	overflow: auto;
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
panel test<br>
<br>
<div id="div_container" class="panelContainer">
	<div id="div_header" class="panelHeader" onclick="js_collapseMe('div_body');">Lorem Ipsum as translated by H. Rackham in 1914&nbsp;(2)</div>
	<div id="div_body">
		<div id="div_searchHead" class="panelFooter" onclick="js_collapseMe('div_search');">Search</div>
		<div id="div_search" class="panelBody" style="display:none;">
			<div id="div_searchInput" class="searchInput">
				<br>
			<input type="text" size="25" value="search">
			<select>
				<option value="0">select an option</option>
				<option value="1">option 1</option>
				<option value="1">option 2</option>
			</select>
			<button value="go">go</button>
			</div>
			<div id="div_searchOutput" class="searchOutput">
				<li>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</li> 
				<li>Nulla tristique feugiat mi.</li> 
				<li>Mauris ultrices blandit nulla.</li>
				<li>Morbi ultrices pharetra tellus.</li>
				<li>Suspendisse consectetuer ullamcorper magna.</li> 
				<li>Sed sagittis orci vitae ligula.</li>
			</div>
		</div>		
		<div id="div_relatedHead" class="panelFooter" onclick="js_collapseMe('div_related');">Related</div>
		<div id="div_related" class="panelBody" style="display:block;">
			On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.
		</div>

		<div id="div_historyHead" class="panelFooter" onclick="js_collapseMe('div_history');">History</div>		
		<div id="div_history" class="panelBody" style="display:none;">
			Lorem ipsum dolor sit amet, consectetuer adipiscing elit. 
			Nulla tristique feugiat mi. 
			Mauris ultrices blandit nulla.
			Morbi ultrices pharetra tellus.
			Suspendisse consectetuer ullamcorper magna. 
			Sed sagittis orci vitae ligula.
			<br><br>
			Ut condimentum dolor ac ante.
			Aliquam luctus egestas nisi.
			Phasellus pharetra nisl quis urna. 
			Vivamus vulputate odio eget nunc.
			Curabitur faucibus tellus nec nisi.
			<br><br>
			Ut id risus sit amet pede viverra luctus. 
			Maecenas volutpat condimentum massa.
			Donec ornare viverra tellus.
			<br><br>
			Mauris a dolor vel orci mattis convallis. 
			Nam dignissim justo vitae nisl.
			Duis ornare eleifend nulla.
			Curabitur non lacus cursus mauris lobortis sodales. 
			Fusce vestibulum feugiat lorem.
			<br><br>
			Duis vitae ligula vitae arcu pellentesque scelerisque. 
			Vestibulum tempus tincidunt purus.
			Nullam tristique consectetuer nulla.
		</div>
	</div>
	<div id="div_footer" class="panelHeader">&nbsp;&raquo;<a href="http://www.lipsum.com/" class="panelHeader">Add</a></div>
</div>
<br>
<!---
<br> <div id="div_container" class="panelContainer">
	<div id="div_header" class="panelHeader" onclick="js_collapseMe('div_body');">Lorem Ipsum as translated by H. Rackham in 1914</div>
	<div id="div_body" class="panelBody">On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.</div>
	<div id="div_footer" class="panelFooter">&raquo;<a href="http://www.lipsum.com/">Lorem Ipsum</a></div>
</div>
<br> --->
</body>
</html>