/*
 * Set chosenjs settings on new message page
 */
function ready(){
  if($('.chosen-select').length) {
    $('.chosen-select').attr("data-placeholder", "Select...").chosen({
      no_results_text: 'No results matched',
      width: '100%'
    });
  }
}

document.addEventListener("turbolinks:load", ready);
