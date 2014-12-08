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
//= require magnific-popup
//= require jquery_ujs
//= require turbolinks
//= require_tree

//mfp-content
$(document).keyup(function(event) {
	//$("#searchForm #id").on("keypress", function(event){
	if ( event.which == 27 && $("#checkdevform").length > 0) {
	     event.preventDefault();
	     $("#searchForm #id").val("");
	     $("#checkdevform #id").focus();
	  }
});

var ready;
ready = function(){
	if ($("#checkdevform").length > 0)
    {
    	$("#checkdevform #id").focus();
    }

	$('.takepicture').magnificPopup({type:'iframe', itleSrc: 'Cambiar foto del propietario'});
	$('.printBarCode').magnificPopup({type:'iframe', itleSrc: 'Imprimir código'});
	
	$('#owner_clave').on("change",function() {
		dataOwner(this);
	});
}

$(document).ready(ready);
//on reload with turbolinks
$(document).on('page:load', ready);

function dataOwner(object){
	if($(object).val() != ""){
	$.ajax({
	  dataType: "json",
	  url: "http://0.0.0.0:3000/owners/find.json?clave=" + $(object).val()})
	.done(function(data) {
	      $("#owner_nombre").val(data.nombre);
	      $("#owner_pe").val(data.pe);
	      $("#owner_id").val(data.id);
	      $("#device_owner_id").val(data.id);
	    })
	.fail(function(data){
	    	$("#owner_nombre").val("");
			$("#owner_pe").val("");
			//$("#owner_id").val(""); //para no desasociar
			$('#owner_clave').focus();
	    });
	}
}
