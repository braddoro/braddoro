function js_ajax(task,itemID,orderID,container) {
	var s_ajax = "task="+task;
	s_ajax += "&itemID="+itemID;
	s_ajax += "&orderID="+document.getElementById("orderID").value;
	if (task == "saveNote") {
		s_ajax += "&noteBy=" + document.getElementById("input_noteBy").value;
		s_ajax += "&note=" + document.getElementById("input_note").value;
	}
	if (task == "saveItem") {
		s_ajax += "&itemName=" + document.getElementById("input_itemName").value;
		s_ajax += "&amount=" + document.getElementById("input_amount").value;
		s_ajax += "&itemStatusID=" + document.getElementById("input_itemStatusID").value;
		document.getElementById("input_itemName").value = "";
		document.getElementById("input_amount").value = "";
		document.getElementById("input_itemStatusID").value = "";
	}
	var s_return = http_post_request("orders_ajax.php", s_ajax);
	if (container == "") {
		return s_return;
	} else {
		if (document.getElementById(container)) {
			document.getElementById(container).innerHTML = s_return;
		}else{
			alert(container);
		}
	}
}