# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.EvaluacionController = {}

EvaluacionController.evaluaciones = (->
  metodo_privado = (var_x) ->
    console.log(var_x)
  procesar_asignacion = (data, textStatus, jqXHR) ->
    console.log(data)
    console.log(textStatus)
    console.log(jqXHR)
    $("#modal-asignacion-evaluacion").modal("hide")
  init: () ->
    console.log("Holiwera!")
    $(".asignar-evaluacion-modal").click ->
      trigger = $(this)
      #Asignamos la variable escondida con el valor dado
      $("#modal-asignacion-evaluacion").find("#evaluacion-id").val(trigger.attr("data-evaluacion-id"))
      $("#modal-asignacion-evaluacion").modal()
      $("#modal-asignacion-evaluacion #guardar-guardar-evaluacion").click ->
        data =
          evaluador_id: $("#modal-asignacion-evaluacion #select-evaluador-id").val()
        $.post(
          trigger.attr("data-url"),
          data,
          (data, textStatus, jqXHR) ->
            procesar_asignacion(data, textStatus, jqXHR)
        )
)()

$(document).ready -> 
  EvaluacionController.evaluaciones.init()