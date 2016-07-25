/*
 * Switch between show & edit in spot modal
 */
function switchTab() {
  $('#spotsbutton').click(function() {
    console.log('test');
    $('.userspots').hide();
    $('.usersspotsedit').show();
  });
}

document.addEventListener("turbolinks:load", switchTab);
