var ready = function() {

  function getExtension(filename) {
      var parts = filename.split('.');
      return parts[parts.length - 1];
  }

  function isVideo(filename) {
    var ext = getExtension(filename);
    console.log(ext.toLowerCase());
    //alert(ext);
    switch (ext.toLowerCase()) {
    case 'mp4':
        // etc
        return true;
    case 'flv':
      return true;
    }
    return false;
  }

  function bodyAppend(tagName, innerHTML) {
      var elm;
  
      elm = document.getElementById(tagName);
      elm.innerHTML = innerHTML;
  }

  function validate_form() {
    var errors = [];
    var file = $('#video_attach');
    if (!isVideo(file.val())) {
      errors[errors.length] = "El formato del video debe ser MP4 o FLV";
    }
    if (file[0].files[0].size > 367001600) {
      errors[errors.length] = "El peso del video es mayor a 350MB.";
    }
    // success at this point
    // indicate success with alert for now
    bodyAppend('errors',"");
    if (errors.length > 0) {
      bodyAppend('errors',errors.join("\n"));
      disable_submit(true);
      return false;
    }
    disable_submit(false);
    return true;
  }

  function disable_submit(bool) {
    $('#video_submit').prop('disabled',bool);
  }

  var options = { 
    beforeSubmit: function() {
      return validate_form();
    },
    beforeSend: function() 
    {
      $("#progress").show();
      //clear everything
      $("#bar").width('0%');
      $("#message").html("");
      $("#percent").html("0%");
    },
    uploadProgress: function(event, position, total, percentComplete) 
    {
      $("#bar").width(percentComplete+'%');
      $("#percent").html(percentComplete+'%');
 
    },
    success: function() 
    {
      $("#bar").width('100% ...');
      $("#percent").html('100% ...');
 
    },
    complete: function(response) 
    {
      console.log(response);
      window.location.href = response.responseJSON.url;
      
        //$("#message").html("<font color='green'>"+response.responseText+"</font>");
    },
    error: function()
    {
      $("#message").html("<font color='red'> ERROR: No se pudo subir el archivo.</font>");
 
    }
 
  };
 
  $("#form_video_save").ajaxForm(options);

  $("#video_attach").change(function() {
    validate_form();
  });
}

$(document).ready(ready);
$(document).on('page:load', ready);