// FUTURE REFACTORING CANDIDATE

// HERE BE DRAGONNES, ETC.

$(document).ready(function() {

  $(document).bind("meeting.insert", function(e) {
    $(".result.unevented .x")
      .click(function(ev){
        var that = this;
        $.post(
          "/meetings/"+$(that).closest(".result").attr('id').substring(8),
          {'_method': 'delete'},
          function() {
            $(that).closest(".result").hide('slow',function(){
              $(this).remove();
            });
          }
        );
        ev.preventDefault();
      });
    $(".result.unevented").removeClass("unevented");
  });

  $(document).trigger("meeting.insert");

  // FUTURE REFACTORING CANDIDATE
  $("#smiley1").mouseover(function(){
    $("#smiley2,#smiley3").stop().fadeTo(500,0.25);
  }).mouseout(function(){
    $("#smiley2,#smiley3").stop().fadeTo(500,1.0);
  }).click(function() {
    $("input[name=feeling_sick]").val("notsick");
    $("form#status").submit();
    $("#smiley2,#smiley3").fadeTo(500,0);
  });

  $("#smiley2").mouseover(function(){
    $("#smiley1,#smiley3").stop().fadeTo(500,0.25);
  }).mouseout(function(){
    $("#smiley1,#smiley3").stop().fadeTo(500,1.0);
  }).click(function() {
    $("input[name=feeling_sick]").val("sickatwork");
    $("#overform1").fadeOut(500,function() {
      $("#overform2").fadeIn(500);
    });
  });

  $("#smiley3").mouseover(function(){
    $("#smiley1,#smiley2").stop().fadeTo(500,0.25);
  }).mouseout(function(){
    $("#smiley1,#smiley2").stop().fadeTo(500,1.0);
  }).click(function() {
    $("input[name=feeling_sick]").val("sickathome");
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

  if (window.OVERLAY||false) {
    var ol_api = $("#overlay").overlay({
      api: true,
      expose: {
        color: '#BAD0DB',
        opacity: 0.7,
        closeSpeed: 1000
      }
    });
    ol_api.load();
  }

  setTimeout(function() {
    $(".success").fadeOut();
  }, 8000);

  $("form#mainform").submit(function(ev) {
    $.post("/meetings.html", {
      "name": $('input[name=to_users]').val(),
      "time": $('#time').val(),
      "location": $('#locationinput').val()
    }, function(data) {

      $("#history").prepend(data);
      $("#history .result:first").hide().show("slow");

    });

    $("li.token").remove();
    $("input[name=to_users]").val('');
    $("input[name=time]").val('');
    $("input[name=list_user]").val('');

    $('input[name=list_user]').focus();

    ev.preventDefault();
  });

  $("form#status").submit(function(ev) {
    var symplist = "";
    $("input.symptom").each(function(i) {
      if (this.checked) {
        symplist += ($(this).attr('id')+",");
      }
    });

    $.post("/statuses.json", {
      "feeling_sick": $('input[name=feeling_sick]').val(),
      "symptoms": symplist
    },function(){
      $("#overlay").html("<h3>Your input has been recorded. Thanks!</h3>");
      setTimeout(function(){ol_api.close();},3000);
    });

    ev.preventDefault();
  });

});