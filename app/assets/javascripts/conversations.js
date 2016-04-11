// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var ready;

ready = function(){
    // enable chosen js
    $('.chosen-select').attr("data-placeholder", "Select recipients...").chosen({
        no_results_text: 'No results matched'
    });
}

$(document).ready(ready);
