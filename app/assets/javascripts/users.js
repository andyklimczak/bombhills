/**
 * Switch between show & edit in spot modal
 */
function switchTab() {
  $('.user-spots-edit').hide();
  $('#spots-btn').click(function() {
    $('.user-spots').show();
    $('.user-spots-edit').hide();
  });
  $('#spots-edit-btn').click(function() {
    $('.user-spots').hide();
    $('.user-spots-edit').show();
  });
}

document.addEventListener("turbolinks:load", switchTab);
