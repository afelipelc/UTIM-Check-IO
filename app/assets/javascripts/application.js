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

//on reload with turbolinks
$(document).on('page:load', function() {
    if ($("#checkdevform").length > 0)
    {
    	$("#checkdevform #id").focus();
    }

 //    $('a[data-popup]').on('click', function(e) { 
	//     e.preventDefault();
	//     openPopup(this);
	// });
	// $('.takepicture').on('click', function(e){
	// 	//get the Token autentication value by meta_tag
	// 	var token = $('meta[name=csrf-token]').attr("content");
	// 	window.open( $(this).attr('href'), "Tomar foto", "height=600, width=900" );
	// 	e.preventDefault();
	// });

	$('.takepicture').magnificPopup({type:'iframe', itleSrc: 'Cambiar foto del propietario'});
	$('.printBarCode').magnificPopup({type:'iframe', itleSrc: 'Imprimir código'});
});
//mfp-content
$(document).keyup(function(event) {
	//$("#searchForm #id").on("keypress", function(event){
	if ( event.which == 27 && $("#checkdevform").length > 0) {
	     event.preventDefault();
	     $("#searchForm #id").val("");
	     $("#checkdevform #id").focus();
	  }
});

$(document).ready(function(){
	// $('a[data-popup]').on('click', function(e) { 
	//     e.preventDefault();
	//     openPopup(this);
	// });
	// $('.takepicture').on('click', function(e){
	// 	//get the Token autentication value by meta_tag
	// 	var token = $('meta[name=csrf-token]').attr("content");
	// 	window.open( $(this).attr('href'), "Tomar foto", "height=600, width=900" );
	// 	e.preventDefault();
	// });

	$('.takepicture').magnificPopup({type:'iframe', itleSrc: 'Cambiar foto del propietario'});
	$('.printBarCode').magnificPopup({type:'iframe', itleSrc: 'Imprimir código'});
	
	$('#owner_clave').on("change",function() {
	dataOwner(this);
	});
});

function openPopup(object){
	window.open( $(object).attr('href'), "Imprimir etiqueta", "height=200, width=400" );
	e.preventDefault(); 
}

function dataOwner(object){
	if($(object).val() != ""){
	$.ajax({
	  dataType: "json",
	  url: "http://localhost:3000/owners/find.json?clave=" + $(object).val()})
	.done(function(data) {
	      $("#owner_nombre").val(data.nombre);
	      $("#owner_pe").val(data.pe);
	      $("#owner_id").val(data.id);
	    }).fail(function(){
	    	$("#owner_nombre").val("");
			$("#owner_pe").val("");
			//$("#owner_id").val("");
			$('#owner_clave').focus();
	    });
	}
}

