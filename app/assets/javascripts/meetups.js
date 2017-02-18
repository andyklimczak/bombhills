/**
 * Init the date time picker on new/edit meetup
 */
function initDateTimePicker() {
  if($('#meetup-datetime-picker').length) {
    $('#meetup-datetime-picker').datetimepicker({
      minDate: moment().add(1, 'day'),
      sideBySide: true,
    });
  }
}

/**
 * Init the meetups table on /meetups
 */
function initMeetupsTable() {
  var meetupsTable = $('#meetups-table');
  if(meetupsTable.length > 0) {
    meetupsTable.bootstrapTable({});
  }
}

document.addEventListener("turbolinks:load", initDateTimePicker);
document.addEventListener("turbolinks:load", initMeetupsTable);
