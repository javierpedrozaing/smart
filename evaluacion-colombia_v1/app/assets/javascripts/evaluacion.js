// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('ready page:load', function() {
  console.log("Evaluacion!");

  var MAX_ACTIVIDAD = 10;
  
  var URL_EVALUAR = 'evaluador/evaluar';

  // var categorias = ["ACD","ACE","CDE","CLA","CNV","EVF","MDC","PAT","URM"];

  // todos los formularios
  $(".edit_evaluacion_respuesta input").on('click', function(){
    console.log("submit");
    $(this).submit();
  });





  //var actividades=[1,2,3,4];//Se crea con cuatro elementos para que empiece el conteo en 4 dejando las actividades obligatorias.
  var actividades=[];
  // Desabilitar botón de logout
  // Se comprueba que este el botón para añadir actividad bajo el div con id main
  var patt = new RegExp(URL_EVALUAR);
  var res = patt.exec(document.URL);
  if(res != null && res.length > 0){
    $('a[href="/personas/sign_out"]').hide();  
  }

  // var evaluar_button = $('a[href="/' + URL_EVALUAR + '"]');
  // evaluar_button.on('click',function(e){
  //   if(!confirm("¿Estás seguro/a de comenzar a evaluar?")){
  //     e.preventDefault();
  //   }
  // });

  $('table.table-condensed.table-bordered.preguntasEval thead').on('click', function(e){
    var tbody = $(this).parent().find('tbody');
    if (tbody.is(":visible")){
      tbody.hide();
    } else {
      tbody.show();
    }
  });

  var mostrarActividades = function mostrarActividades(){
    $('#btAdd').show();
    $('#btRemove').show();
    $('.ocultable').hide();
    console.log("actividades cargadas "+actividades)
    console.log("actividades cantidad "+actividades.length)
    actividades.forEach(function(a){
      console.log(cls);
      var cls = '.' + a;
      $(cls).show();
    });
  }

  var ocultarActividades = function ocultarActividades(){
    $('#btAdd').hide();
    $('#btRemove').hide();
  }

  $("#btAdd").on('click', function(){
    if(actividades.length < MAX_ACTIVIDAD){
      actividades.push("actividad_" + (actividades.length+1));
    if(actividades.length > 4){
		$.ajax({
			
			type: "GET",
			url: "/evaluador/actividad_obligatoria",
			data: {actividad:actividades.length,id:parseInt($('#evaluacion_actividad').text()),obligatorio:1 }, // Adjuntar los campos del formulario enviado.
			success: function(data)
			{
				

			}
		
		});
    }
      console.log(actividades);
      console.log(actividades.length);
      mostrarActividades();
      $('.accordion-body').collapse('hide');
    }
  });

  $("#btRemove").on('click', function(){
	  //Se incorpora para quitar actividades obligatorioas mayores a 4
	    if(actividades.length > 4){
			$.ajax({
				
				type: "GET",
				url: "/evaluador/actividad_obligatoria",
				data: {actividad:actividades.length,id:parseInt($('#evaluacion_actividad').text()),obligatorio:''}, // Adjuntar los campos del formulario enviado.
				success: function(data)
				{
					
				  
				
				}
			
			});
	    } 
    actividades.pop();
    console.log(actividades);
    mostrarActividades();
  });


  $(".categoria").on('click', function(){
    var categoria_codigo = $(this).attr('data-codigo');
    var cls = "." + categoria_codigo;
    $('.ocultable').hide();
    console.log("pregunta por el nombre actividad"+categoria_codigo)
    if(categoria_codigo == "ACD" || categoria_codigo == "ACE"){
      console.log("entro a mostrar actividades ");
      mostrarActividades();
    } else {
      ocultarActividades();
    }
    console.log(cls);
    $(cls).show();
  });


  /*
 * Description: Paso de datos
 * autoevaluación para controlador autoevaluacion/guardar_autoevaluacion
 * Autor: Jeyson Correa Martinez
 * Date: 2016-04-19
 */
  $('#prueba-multidimencional').on('click', function(){ 


    setTimeout(function(){    
 
    var ids = [];
    count =1 
    $('.autoevaluacion_r').each(function(key, element){
      ids.push($(element).attr('data'));             
    }); 
    arr =JSON.stringify(ids,null, 4)
    console.log(arr)
       document.location = "/autoevaluacion/index";
       
   },3000);
   
   //document.location = "/autoevaluacion/index";

  
  });

  /*
 * Description: Paso de datos
 * autoevaluación autoguardado
 * Autor: Jeyson Correa Martinez
 * Date: 2016-04-19
 */
  $('.autoevaluacion_r').on('change', function(){ 
  var url = "/autoevaluacion/guardar_autoevaluacion_item"; 
  console.log($(this).val() + '--' + parseInt($(this).attr('data_auto')) + '--' + parseInt($(this).attr('data')))
  $.ajax({      
      type: "POST",
      url: url,
      data: {pregunta: $(this).val(),autoevaluacion_id:parseInt($(this).attr('data_auto')),id:parseInt($(this).attr('data'))}, // Adjuntar los campos del formulario enviado.
      success: function(data)
      {       
      }
    
    });
  });


  <!--Aqui vamos -->
  if(document.getElementById("botonocultamuestra")==null){
    $('#btAdd').hide();
    $('#btRemove').hide();
  }

});
