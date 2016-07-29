/*
 * Switch between show & edit in spot modal
 */
function switchTab() {
  $('.usersspotsedit').hide();
  $('#spotsbutton').click(function() {
    $('.userspots').show();
    $('.usersspotsedit').hide();
    $(this).css('background-color', '#233E47');
    $('#spotseditbutton').css('background-color', '#006964');
  });
  $('#spotseditbutton').click(function() {
    $('.userspots').hide();
    $('.usersspotsedit').show();
    $(this).css('background-color', '#233E47');
    $('#spotsbutton').css('background-color', '#006964');
  });
}

document.addEventListener("turbolinks:load", switchTab);
