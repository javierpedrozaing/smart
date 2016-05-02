class PaginaJustificacion < ActiveRecord::Base
	#crea una pagina en esta tabla sino existe,para almacenar su justificacion
	def self.crear_pagina_justificacion autoevaluacion_id, suma_pagina, justificacion
       #Buscamos si ya se ha creado la pagina, sino la crea
       #self.joins(:autoevaluacion_respuesta). 
       if !autoevaluacion_id.blank?  
	   	  if self.where(autoevaluacion_id:  autoevaluacion_id, pagina:suma_pagina ).count == 0
	   	    puts 'entro a insertar uno 1 ot' 
	        #AutoevaluacionRespuesta.where(autoevaluacion_id:autoevaluacion_id).where('valor is not null').limit(5)  
	         self.create(autoevaluacion_id:  autoevaluacion_id,pagina: suma_pagina,justificacion: justificacion) 
	       end     
        end
  end
end
