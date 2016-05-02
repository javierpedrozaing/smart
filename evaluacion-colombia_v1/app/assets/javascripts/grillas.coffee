# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ready page:load", ->
  $(document).ready ->
    

    reorganizarAlternativas = (id_pregunta, elimina_pregunta) ->
      if elimina_pregunta is 1
        $conteoDomDescripcion = $("#alternativas_campos_" + id_pregunta).children("ul").children("li").children("input").length
        $conteoDomValor = $("#alternativas_campos_" + id_pregunta).children("ul").children("li").children("select").length
      else
        $conteoDomDescripcion = $("#alternativas_campos_" + id_pregunta).children("ul").children("li").children("input").length - 1
        $conteoDomValor = $("#alternativas_campos_" + id_pregunta).children("ul").children("li").children("select").length - 1
      i = 1
      while i <= $conteoDomDescripcion
        if elimina_pregunta is 1
          
          #selecionamos el id del alternativa a reorganizar 
          $alternativa_cambio_id = $($("#alternativas_campos_" + id_pregunta).children("ul")[i])
          $alternativa_cambio_id_eliminacion = $($("#alternativas_campos_" + id_pregunta).children("ul").children("a")[i])
          
          #cambiamos los nombres y los ids de los objetos existentes
          $alternativa_cambio_id.attr "data-id", i
          $alternativa_cambio_id_eliminacion.attr "data-id", i
        else
          $alternativa_cambio = $($("#alternativas_campos_" + id_pregunta).children("ul").children("li").children("input")[i]) #.attr('name','alternativa[alternativa_'+id_pregunta+'_'+i+']');
          $alternativa_cambio.attr "name", "alternativa[alternativa_" + id_pregunta + "_" + i + "]"
          console.log "alternativa[alternativa_" + id_pregunta + "_" + i + "]"
        i++
      j = 1
      while j <= $conteoDomValor
        
        #selecionamos el id del valor a reorganizar
        $valor_cambio = $($("#alternativas_campos_" + id_pregunta).children("ul").children("li").children("select")[j])
        $valor_cambio.attr "name", "valor[valor_" + id_pregunta + "_" + j + "]"
        console.log "valor[valor_" + id_pregunta + "_" + j + "]"
        j++
    j = $("#pregunta_campos").children("ul").children("li").children("textarea").length
    x = 0
    nextinput = j
    nextinput_alt = 0
    $("#pregunta_insertar").click ->
      nextinput++
      pregunta = "<ul  data-id=\"" + nextinput + "\"><li><label>pregunta</label><br><textarea rows=\"4\" cols=\"50\" name=\"pregunta[pregunta_" + nextinput + "]\" ></textarea></li><a href=\"#\" class=\"eliminar_pregunta\">Eliminar pregunta</a><br>"
      agregar_alternativa = "<div class=\"field\" ><label>Alternativas</label><br> <a href=\"#\" class=\"alternativas_insertar\" data-id=\"" + nextinput + "\">Agregar Alternativas</a><div id=\"alternativas_campos_" + nextinput + "\" class=\"campos\" ></div></div></ul><br>"
      $("#pregunta_campos").append pregunta + agregar_alternativa
      j++
      $(".alternativas_insertar").click (e) ->
        if e.isDefaultPrevented() is false
          e.preventDefault()
          if e.isDefaultPrevented() is true
            x = $("#alternativas_campos_" + $(this).attr("data-id") + " ul").length + 1
            pregunta_padre = $(this).attr("data-id")
            nextinput_alt = x++
            $alternativa = "<ul data-id=\"" + pregunta_padre + "\"><li  style=\"float:left;\">Alternativa:<input type=\"text\" name=\"alternativa[alternativa_" + pregunta_padre + "_" + nextinput_alt + "]\" ><select name=\"valor[valor_" + pregunta_padre + "_" + nextinput_alt + "]\" >"
            $opciones = "<option value=\"0\">Selecione-valor</option><option value=\"1\">Uno</option><option value=\"2\">Dos</option><option value=\"3\">Tres</option><option value=\"4\">Cuatro</option><option value=\"5\">Cinco</option><option value=\"6\">Seis</option><option value=\"7\">Siete</option><option value=\"8\">Ocho</option><option value=\"9\">Nueve</option><option value=\"10\">Diez</option></select></li>"
            $boton_eliminar = "<a href=\"#\" class=\"eliminar\" data-id=\"" + pregunta_padre + "\">&times;</a></ul><br>"
            $("#alternativas_campos_" + $(this).attr("data-id")).append $alternativa + $opciones + $boton_eliminar


    $("body").on "click", ".eliminar_pregunta", (e) ->
      l = 1
      while l <= $("#pregunta_campos").children("ul").children("li").children("textarea").length - 1
        $pregunta_cambio_id = $($("#pregunta_campos").children("ul")[l])
        console.log $pregunta_cambio_id
        $pregunta_cambio_id_alternativa = $($("#pregunta_campos").children("ul").children(".field").children("a")[l])
        $pregunta_cambio_id_alternativa_crea_campos = $($("#pregunta_campos").children("ul").children("div").children("div")[l])
        $pregunta_cambio_name = $($("#pregunta_campos").children("ul").children("li").children("textarea")[l])
        console.log $pregunta_cambio_name
        $pregunta_cambio_id.attr "data-id", l
        $pregunta_cambio_id_alternativa.attr "data-id", l
        $pregunta_cambio_id_alternativa_crea_campos.attr "id", "alternativas_campos_" + l
        $pregunta_cambio_name.attr "name", "pregunta[pregunta_" + l + "]"
        console.log "pregunta[pregunta_" + l + "]"
        $pregunta_cambio_name.attr "name", "pregunta[pregunta_" + l + "]"
        reorganizarAlternativas l, elimina_pregunta = 1
        l++
      if j > 0
        $(this).parent("ul").remove()
        j--
      false

    $("body").on "click", ".eliminar", (e) ->
      id_pregunta = $(this).attr("data-id")
      reorganizarAlternativas id_pregunta, elimina_pregunta = 0
      $(this).parent("ul").remove()
      false
