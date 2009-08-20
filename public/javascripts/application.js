$(document).ready(function() {

  $("button").overlay();

  $("#smiley1").mouseover(function(){
    $("#smiley2").stop().fadeTo(500,0.25);
  }).mouseout(function(){
    $("#smiley2").stop().fadeTo(500,1.0);
  }).click(function() {
    $("input[name=feeling_sick]").val("false");

    $("form#status").submit();

    $("#smiley2").fadeTo(500,0, function() {
      ol_api.close();
    });
  });

  $("#smiley2").mouseover(function(){
    $("#smiley1").stop().fadeTo(500,0.25);
  }).mouseout(function(){
    $("#smiley1").stop().fadeTo(500,1.0);
  }).click(function() {
    $("#overform1").fadeOut(500,function() {
      $("#overform2").fadeIn(500);
    });
  });

  $(".timeselect").click(function() {
    $(this).effect("highlight",{},2000);
    $("input#time").val($(this).attr('id').substring(2));
    if ($("input[name=to_users]").val().length > 0) {
      $("ul.facelist").effect("highlight",{},2000);
      $(".maininput").effect("highlight",{},2000);
      $("#mainform").submit();
    }
  });

  $("#list_user").autocomplete("/suggest.json", properties = {
		matchContains: true,
		minChars: 2,
		selectFirst: false,
		intro_text: "Type Name",
		no_result: "No Names"
	});

  var ol_api = $("#overlay").overlay({
    api: true,
    expose: {
      color: '#BAD0DB',
      opacity: 0.7,
      closeSpeed: 1000
    }
  });

  ol_api.load();

  setTimeout(function() {
    $(".success").fadeOut();
  }, 8000);

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
    $("#mainoinput[name=to_users]").val('');
    $("input[name=time]").val('');
    $("input[name=list_user]").val('');

    $('input[name=list_user]').focus();

    ev.preventDefault();
  });

  $("form#status").submit(function(ev) {
    $.post("/statuses.json", {
      "feeling_sick": $('input[name=feeling_sick]').val(),
      "symptoms": $("input[name=symptoms]").val()
    });

    ev.preventDefault();
  });

});