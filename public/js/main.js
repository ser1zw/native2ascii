// -*- mode: javascript; coding: utf-8 -*-

function convert(convText, convMode) {
    $.ajax({
	type: "post",
	url: "/api/convert",
	dataType: "json",
	data: {
	    text: convText,
	    mode: convMode
	},
	success: function(data) {
	    $("#results").html(data.text.replace("\n", "<br/>"));
	}
    });
}

function onConvertButtonClick() {
    var text = $("#inputarea")[0].value;
    var mode = $("input:radio[name='mode']:checked").val();
    convert(text, mode);
}

function onResetButtonClick() {
    $("#inputarea")[0].value = '';
    $("#results")[0].value = '';
}

