// -*- mode: javascript; coding: utf-8 -*-

function convert(convText, convMode) {
    $.ajax({
	type: "post",
	url: "/api/convert",
	dataType: "json",
	data: {
	    text: convText,
	    mode: convMode,
	    escape: true
	},
	success: function(data) {
	    $("#results").html(data.text);
	},
	error: function(req, status, message) {
	    $("#results").html(message);
	}
    });
}

function onConvertButtonClick(mode) {
    var text = $("#inputarea")[0].value;
    convert(text, mode);
}

function onResetButtonClick() {
    $("#inputarea")[0].value = "";
    $("#results")[0].innerHTML = "";
}

