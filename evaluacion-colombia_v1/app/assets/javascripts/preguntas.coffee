# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on "ready page:load", ->
  $(document).ready ->
    
    #Agregar Nuevos campos de alternativas de pregunta
    nextinput = 0
    nextinput_alt = 0 #para alternativas dentro de la grilla
    
    #var x = número de campos existentes en el contenedor
    j = $("#pregunta_campos ul").length
    x = 0
    $("#alternativas_insertar").click ->
      console.log "entro uno"
      nextinput++
      campo = "<ul><li id=\"rut" + nextinput + "\">Alternativa:<input type=\"text\" name=\"alternativa[alternativa_" + nextinput + "]\" ><select name=\"valor[valor_" + nextinput + "]\" id=\"valor_" + nextinput + "\">\"<option value=\"\">Selecione-valor</option><option value=\"1\">Uno</option><option value=\"2\">Dos</option><option value=\"3\">Tres</option><option value=\"4\">Cuatro</option><option value=\"5\">Cinco</option><option value=\"6\">Seis</option><option value=\"7\">Siete</option><option value=\"8\">Ocho</option><option value=\"9\">Nueve</option><option value=\"10\">Diez</option></select></li><a href=\"#\" class=\"eliminar\">&times;</a></ul>"
      $("#alternativas_campos").append campo
      x++

    
    #elimina alternativas 
    $("body").on "click", ".eliminar", (e) -> #click en eliminar campo
      console.log "entro"
      $(this).parent("ul").remove() #eliminar el campo
      false

    $("#video_estadopp").change (e) -> #click en eliminar campo
      value = ""
      $("#video_estado option:selected").each ->
        value += $(this).attr("value")

      url = "/admin/observacion/observaciones"
      $.get url,
        id: value
      , (data) ->

      window.location.reload true