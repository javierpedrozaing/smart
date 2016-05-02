/*
var ready = function() {
  var bar = $('.bar_video');
  var percent = $('.percent_video');
  var status = $('#status');
     
  $('#form_video_save').ajaxForm({
      delegation: true,
      beforeSend: function() {
          status.empty();
          var percentVal = '0%';
          bar.width(percentVal)
          percent.html(percentVal);
      },
      uploadProgress: function(event, position, total, percentComplete) {
          var percentVal = percentComplete + '%';
          bar.width(percentVal)
          percent.html(percentVal);
      console.log(percentVal, position, total);
      },
      success: function() {
          var percentVal = '100%';
          bar.width(percentVal)
          percent.html(percentVal);
      },
    complete: function(xhr) {
      //status.html(xhr.responseText);
      console.log(xhr.responseJSON.url);
      window.location.replace(xhr.responseJSON.url);
    }
  });
};
$(document).ready(ready);
$(document).on('page:load', ready);

*/