var ready = function() {

  var options_planeacion = { 
    beforeSubmit: function() {
      return validate_planeacion(1);
      //alert("Enviando archivo");
    },
    complete: function(response) 
    {
      //window.location.href = response.responseJSON.url;
      window.location.href = response.responseJSON.url;
        //$("#message").html("<font color='green'>"+response.responseText+"</font>");
    },
    error: function()
    {
      alert("Error.")
    }
 
  };
  
  var options_evidencias = { 
    beforeSubmit: function() {
      return validate_evidencias(1);
      //alert("Enviando archivo");
    },
    complete: function(response) 
    {
      //window.location.href = response.responseJSON.url;
      window.location.href = response.responseJSON.url;
        //$("#message").html("<font color='green'>"+response.responseText+"</font>");
    },
    error: function()
    {
      alert("Error.")
    }
 
  };
  
  var options_planeacion_cargo = { 
		    beforeSubmit: function() {
		      return validate_planecion_cargo(1);
		      //alert("Enviando archivo");
		    },
		    complete: function(response) 
		    {
		      //window.location.href = response.responseJSON.url;
		      window.location.href = response.responseJSON.url;
		        //$("#message").html("<font color='green'>"+response.responseText+"</font>");
		    },
		    error: function()
		    {
		      alert("Error.")
		    }
		 
		  };

  function getExtension(filename) {
    var parts = filename.split('.');
    return parts[parts.length - 1];
  }

  function isPlaneacion(filename) {
    var ext = getExtension(filename);
    switch (ext.toLowerCase()) {
    case 'pdf':
      return true;
    case 'doc':
      return true;
    case 'docx':
      return true;
    }
    return false;
  }

  function validate_planeacion(val) {
    var errors = [];
    var file = $('#planeacion-input');
    if (!isPlaneacion(file.val())) {
      errors[errors.length] = "El formato del archivo debe ser .pdf, .doc o .docx";
    }

    console.log("hola");
    if (file[0].files[0].size > 1048576) {
      errors[errors.length] = "El peso del archivo es mayor a 1MB.";
    }
    bodyAppend('errors',"");
    if (errors.length > 0) {
      bodyAppend('errors', errors.join("<br>"))
      //alert(errors.join("\n"));
      return false;
    }
    bodyAppend('good', "El archivo es válido");
    if (val == 1) {
      bodyAppend('good', "Enviando Archivo");
    }

    //alert("Enviando archivo");
    return true;
  }

  function validate_evidencias(val) {
    var errors = [];
    var file = $('#evidencia-input');
    if (!isEvidencia(file.val())) {
    	console.log($('#cargo_id').attr('data-id') + 'salida de dato')
     switch($('#cargo_id').attr('data-id')) {//Validacion de mensaje por cargo
        case '1':
        	errors[errors.length] = "El formato del archivo debe ser .pdf, .doc, .docx o .mp3";
            break;
        case '2':
        	errors[errors.length] = "El formato del archivo debe ser .pdf, .doc, .docx";
            break;

        case '4':
        	errors[errors.length] = "El formato del archivo debe ser .pdf, .doc, .docx o .mp3";
            break; 
        case '5':
        	errors[errors.length] = "El formato del archivo debe ser .pdf, .doc, .docx o .mp3";
            break;
        case '7':
        	errors[errors.length] = "El formato del archivo debe ser .pdf, .doc, .docx";
            break;
        case '8':
        	errors[errors.length] = "El formato del archivo debe ser .pdf, .doc, .docx";
            break; 
        case '9':
        	errors[errors.length] = "El formato del archivo debe ser .pdf, .doc, .docx";
            break;     
      
     }  	

    }
    
    switch($('#cargo_id').attr('data-id')) {//Validacion de mensaje por cargo
    case '1':
    	 if (file[0].files[0].size > 5242880) {
            errors[errors.length] = "El peso del archivo es mayor a 5MB.";
            }
        break;
    case '2':
        if (file[0].files[0].size > 1048576) {
            errors[errors.length] = "El peso del archivo es mayor a 1MB.";
          }
        break;

    case '4':
   	    if (file[0].files[0].size > 5242880) {
          errors[errors.length] = "El peso del archivo es mayor a 5MB.";
         }
        break; 
    case '5':
   	    if (file[0].files[0].size > 5242880) {
          errors[errors.length] = "El peso del archivo es mayor a 5MB.";
         }
        break;
    case '7':
        if (file[0].files[0].size > 1048576) {
            errors[errors.length] = "El peso del archivo es mayor a 1MB.";
          }
        break;
    case '8':
        if (file[0].files[0].size > 1048576) {
            errors[errors.length] = "El peso del archivo es mayor a 1MB.";
          }
        break; 
    case '9':
        if (file[0].files[0].size > 1048576) {
            errors[errors.length] = "El peso del archivo es mayor a 1MB.";
          }
        break;     
  
  }  

   // if (file[0].files[0].size > 5242880) {
    //  errors[errors.length] = "El peso del archivo es mayor a 5MB.";
    //}
    bodyAppend('errors',"");
    if (errors.length > 0) {
      bodyAppend('errors', errors.join("<br>"))
      //alert(errors.join("\n"));
      return false;
    }
    bodyAppend('good', "El archivo es válido");
    if (val == 1 ) {
      bodyAppend('good', "Enviando Archivo");
    }    
    //alert("Enviando archivo");
    return true;
  }
  
  function validate_planecion_cargo(val) {
      var errors = [];
      var file = $('#planeacion-input-cargo');
      if (!isEvidencia(file.val())) {
        errors[errors.length] = "El formato del archivo debe ser .pdf, .doc, .docx";
      }
      
      if (file[0].files[0].size > 5242880) {
        errors[errors.length] = "El peso del archivo es mayor a 5MB.";
      }
      bodyAppend('errors',"");
      if (errors.length > 0) {
        bodyAppend('errors', errors.join("<br>"))
        //alert(errors.join("\n"));
        return false;
      }
      bodyAppend('good', "El archivo es válido");
      if (val == 1 ) {
        bodyAppend('good', "Enviando Archivo");
      }    
      //alert("Enviando archivo");
      return true;
    } 

  function isEvidencia(filename) {
    var ext = getExtension(filename);
    switch (ext.toLowerCase()) {
    case 'pdf':
      return true;
    case 'doc':
      return true;
    case 'docx':
      return true;
    case 'mp3':    
    switch($('#cargo_id').attr('data-id')) {//Validacion de mensaje por cargo
        case '1':
        	 return true;
            break;
        case '2':
        	return false;
            break;

        case '4':
        	 return true;
            break; 
        case '5':
        	 return true;
            break;
        case '7':
        	return false;
            break;
        case '8':
        	return false;
            break; 
        case '9':
        	return false;
            break;     
      
     }  	
    }
    return false;
  }

  function bodyAppend(tagName, innerHTML) {
      var elm;
  
      elm = document.getElementById(tagName);
      elm.innerHTML = innerHTML;
  }
 
  $("#planeacion-input-cargo").change(function() {
	  validate_planecion_cargo(0);
  });
  
  $("#evidencia-input").change(function() {
	  validate_evidencias(0);
   });

  $("#planeacion-input").change(function() {
    validate_planeacion(0);
  });

  $("#form-planeacion").ajaxForm(options_planeacion);
  $("#form-evidencia").ajaxForm(options_evidencias);
  $("#form-planeacion-cargo").ajaxForm(options_planeacion_cargo);
  
  $('#enviar-planeacion').click( function() {
    $('#form-planeacion').submit();
    return false;
  });
  
  $('#enviar-planeacion-cargo').click( function() {
	    $('#form-planeacion-cargo').submit();
	    return false;
	  });

  $('#enviar-evidencia').click( function() {
    $('#form-evidencia').submit();
    return false;
  });
}

$(document).ready(ready);
$(document).on('page:load', ready);