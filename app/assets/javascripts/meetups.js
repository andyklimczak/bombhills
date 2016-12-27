function initDateTimePicker() {
  if($('#meetup-datetime-picker').length) {
    $('#meetup-datetime-picker').datetimepicker({
      minDate: moment().add(1, 'day'),
      sideBySide: true,
    });
  }
}

document.addEventListener("turbolinks:load", initDateTimePicker);
