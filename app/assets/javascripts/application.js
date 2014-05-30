// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.ui.datepicker
//= require dataTables/jquery.dataTables
//= require jquery_ujs
//= require turbolinks
//= require_tree

//on reload with turbolinks
$(document).on('page:load', function() {
    if ($("#checkdevform").length > 0)
    {
    	$("#checkdevform #id").focus();
    }
});

$(document).keyup(function(event) {
	//$("#searchForm #id").on("keypress", function(event){
	if ( event.which == 27 && $("#checkdevform").length > 0) {
	     event.preventDefault();
	     $("#searchForm #id").val("");
	     $("#checkdevform #id").focus();
	  }
});