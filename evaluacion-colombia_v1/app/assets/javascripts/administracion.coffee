# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $("#filtro").hide()
  $("#filtrar_ocultar").hide()
  $("#filtrar_ocultar").click ->
    $("#filtro").hide()
    $("#filtrar").show()
    $("#filtrar_ocultar").hide()

  
  #Mostrar filtro
  $("#filtrar").click ->
    $("#filtro").show()
    $("#filtrar").hide()
    $("#filtrar_ocultar").show()
