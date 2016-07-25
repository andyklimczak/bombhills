/*
 * Switch between show & edit in spot modal
 */
function switchTab() {
  $('.usersspotsedit').hide();
  $('#spotsbutton').click(function() {
    $('.userspots').show();
    $('.usersspotsedit').hide();
  });
  $('#spotseditbutton').click(function() {
    $('.userspots').hide();
    $('.usersspotsedit').show();
  });
}

document.addEventListener("turbolinks:load", switchTab);
