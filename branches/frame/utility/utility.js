function ChangeTextSize(element,changeBy) {
	document.getElementById(element).rows = parseInt(document.getElementById(element).rows)+parseInt(changeBy);
}

function ChangeTextSizeW(element,changeBy) {
	document.getElementById(element).cols = parseInt(document.getElementById(element).cols)+parseInt(changeBy);
}
function isNumber(frm, fld, val) {
	if(isNaN(val)) {
		document.forms[frm].elements[fld].focus();
		alert("This is not a number.");
	}
}
function js_collapseThis(changeme) {
	if (document.getElementById(changeme).style.display == "block") {
		document.getElementById(changeme).style.display = "none";
	} else {
		document.getElementById(changeme).style.display = "block";
	}
}
function js_changeBG(changeme,colorbg) {
	document.getElementById(changeme).style.backgroundColor = colorbg;
}