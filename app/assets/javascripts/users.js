/*
 * Switch between show & edit in spot modal
 */
function switchTab() {
  $('.usersspotsedit').hide();
  $('#spotsbutton').click(function() {
    $('.userspots').show();
    $('.usersspotsedit').hide();
    $(this).css('background-color', '#251950');
    $('#spotseditbutton').css('background-color', 'var(--main-color)');
  });
  $('#spotseditbutton').click(function() {
    $('.userspots').hide();
    $('.usersspotsedit').show();
    $(this).css('background-color', '#251950');
    $('#spotsbutton').css('background-color', 'var(--main-color)');
  });
}

document.addEventListener("turbolinks:load", switchTab);
