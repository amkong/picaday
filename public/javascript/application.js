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
  
});



