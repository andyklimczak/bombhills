// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var ready = function(){
  // enable chosen js
  $('.chosen-select').attr("data-placeholder", "Select...").chosen({
    no_results_text: 'No results matched',
    width: '100%'
  });
}

document.addEventListener("turbolinks:load", ready);
