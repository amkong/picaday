$(document).ready(function() {

  // $("input").keypress(function(event) {
  //   if (event.which == 13) {
  //       event.preventDefault();
  //       $("form").submit();
  //   }
  // });
  $.fn.center = function () {
    this.css("position","absolute");
    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + 
                                                $(window).scrollTop()) + "px");
    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + 
                                                $(window).scrollLeft()) + "px");
    return this;
  }

  $('.center-of-screen').center();

  init_up_vote();
  
});


$(document).keydown(function(e){
    if (e.keyCode == 38 && $('.gamma-single-view').css('display') != 'none' ) { 
      id = $('.gamma-single-view img').attr("src").split("#")[1]
      console.log(id);
      address = "/images/" + id + "/upvote"
      //Upvote image
      $.post(address, function( data ) {
        console.log(data);
      });
    }
});

function upvote_animation(){
   $('#upvote').show();
   setTimeout(function() { 
       $('#upvote').fadeOut(); 
   }, 5000);
}

function init_up_vote(){
  $('.ajax-up-vote').click(function(e) {
      e.preventDefault();
      var address = $(this).attr("href");
      $.post(address, function( data ) {
        console.log(data);
      });
  });
}
