/**
 * Switch between show & edit in spot modal
 */
function switchTab() {
  $('.user-spots-edit').hide();
  $('#spots-btn').click(function() {
    $('.user-spots').show();
    $('.user-spots-edit').hide();
    $(this).css('background-color', '#251950');
    $('#spots-edit-btn').css('background-color', 'var(--main-color)');
  });
  $('#spots-edit-btn').click(function() {
    $('.user-spots').hide();
    $('.user-spots-edit').show();
    $(this).css('background-color', '#251950');
    $('#spots-btn').css('background-color', 'var(--main-color)');
  });
}

document.addEventListener("turbolinks:load", switchTab);
