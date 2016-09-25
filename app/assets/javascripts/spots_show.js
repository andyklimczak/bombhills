function initMenuChildClick() {
  $('.menu-child').click(function(e) {
    $('.menu-child').removeClass('active');
    $(this).addClass('active');
    $('.show-spot-content').hide();
    $('.spot-info-container').children().eq($(this).index()).show();
  });
}

function init() {
  if($('.show-spot-container').length) {
    initMenuChildClick();
  }
}

document.addEventListener("turbolinks:load", init);
