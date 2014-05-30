# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  if $("#devicestable").length > 0
    $('#devicestable').dataTable
      sPaginationType: "full_numbers"
      bJQueryUI: true
      bProcessing: true
      bServerSide: true
      sAjaxSource: $('#devicestable').data('source')
#When page is loaded by turbolink
$(document).on "page:load", ->
  if $("#devicestable").length > 0
    $('#devicestable').dataTable
      sPaginationType: "full_numbers"
      bJQueryUI: true
      bProcessing: true
      bServerSide: true
      sAjaxSource: $('#devicestable').data('source')