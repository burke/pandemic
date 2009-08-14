$(document).ready(function() {

  $("button").overlay();

  $("#smiley1").mouseover(function(){
    $("#smiley2").stop().fadeTo(500,0.4);
  }).mouseout(function(){
    $("#smiley2").stop().fadeTo(500,1.0);
  });
  $("#smiley2").mouseover(function(){
    $("#smiley1").stop().fadeTo(500,0.3);
  }).mouseout(function(){
    $("#smiley1").stop().fadeTo(500,1.0);
  });

  $("#list_user").autocomplete("/suggest.json", properties = {
		matchContains: true,
		minChars: 2,
		selectFirst: false,
		intro_text: "Type Name",
		no_result: "No Names"
	});
	$("#submit").click(function(){
		var data = $("#to_users").val();
		alert(data);
	});

  var ol_api = $("#overlay").overlay({
    api: true,
    expose: {
      color: '#BAD0DB',
      opacity: 0.7,
      closeSpeed: 1000
    }
  });

  setTimeout(function(){
    ol_api.load();
  },1000);

  $("form#mainform").submit(function(ev) {
    $.post("/meetings.json", {
      "name": $('input[name=to_users]').val(),
      "time": $('#time').val()
    }, function(data) {

      var newResult = "<div class='result'>I met with <span class='name'>"+data['name']+"</span> for <span class='time'>"+data['time_str']+"</span>. (X)</div>";

      $("#history").prepend(newResult);
      $("#history .result:first").hide().show("slow");

    }, "json");

    $("li.token").remove();
    $("input[name=to_users]").val('');
    $("input[name=time]").val('');
    $("input[name=list_user]").val('');

    $('input[name=list_user]').focus();

    ev.preventDefault();
  });

});