# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ready page:load", ->    
$(document).ready ->
  console.log "paso la prueba"
  #click en eliminar campo	
  #creamos la fecha actual para validar con la de grabación
  fechaMayorOIgualQue = (fecha_ejemplo, fecha_ejemplo2) ->
    bRes = false
    console.log fecha_ejemplo
    sAno0 = fecha_ejemplo.substr(0, 4)
    sMes0 = fecha_ejemplo.substr(5, 2)
    sDia0 = fecha_ejemplo.substr(8, 2)
    console.log sDia0 + sMes0 + sAno0
    sDia1 = fecha_ejemplo2.substr(0, 2)
    sMes1 = fecha_ejemplo2.substr(3, 2)
    sAno1 = fecha_ejemplo2.substr(6, 4)
    bRes = true  if sDia0 <= sDia1  if sMes0 is sMes1  unless sMes0 < sMes1  if sAno0 is sAno1  unless sAno0 < sAno1
    bRes
  $.getScript "http://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"
  $("#video_estado").change (e) ->
    value = ""
    $("#video_estado option:selected").each ->
      value += $(this).attr("value")

    $selecion = value
    url = "/observacion"
    $.get url,
      id: value
    , ((data) ->
      $("#struct").remove()
      txt1 = "<div class=\"col-md-6\" id=\"struct\">"
      txt2 = "<table cellspacing=\"0\" cellpadding=\"0\" class=\"table\" id=\"table\"> "
      txt3 = "<thead><tr><th>id</th><th>Tipo documento</th><th>Numero documento</th><th>Nombres</th><th>Apellido Paterno</th><th>Apellido Materno</th>" + "<th>Telefono</th><th>Celular</th><th>Email</th><th>Fecha de Grabación</th><th>Estado</th></tr></thead>"
      txt4 = "<tbody></tbody>"
      txt5 = "</table>"
      txt6 = "</div>"
      $("#video_estado").after txt1 + txt2 + txt3 + txt4 + txt5 + txt6
      $cuerpo = ""
      $count = 0
      f = new Date()
      fechaactual = f.getDate() + "-0" + (f.getMonth() + 1) + "-" + f.getFullYear()
      $.each data, (index, value) ->
        $count++
        value.fecha_grabacion
        fechaactual

        if value.video_estado is "Grabación finalizada"
          estado = "<td>" + value.video_estado + "</td>"
        else
          unless fechaMayorOIgualQue(value.fecha_grabacion, fechaactual) is false
            estado = "<td style='background:red;'>" + value.video_estado + "</td>"
          else
            estado = "<td>" + value.video_estado + "</td>"
          console.log fechaMayorOIgualQue(value.fecha_grabacion, fechaactual) + value.fecha_grabacion + fechaactual
        $cuerpo += "<tr>" + "<td>" + $count + "</td>" + "<td>" + value.tipo + "</td>" + "<td>" + value.documento + "</td>" + "<td>" + value.nombre + "</td>" + "<td>" + value.apellido_paterno + "</td>" + "<td>" + value.apellido_materno + "</td>" + "<td>" + value.telefono + "</td>" + "<td>" + value.celular + "</td>" + "<td>" + value.email + "</td>" + "<td>" + value.fecha_grabacion + "</td>" + estado + "</tr>"
        $("#reporte_trabajo_asignado_camarografo .table tbody").html $cuerpo

      $("#table").dataTable()
    ), "json"    