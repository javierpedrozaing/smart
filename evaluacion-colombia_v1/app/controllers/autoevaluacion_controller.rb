class AutoevaluacionController < ApplicationController
  #before_action :set_autoevaluacion, only: [:guardar_autoevaluacion, :guardar_autoevaluacion_item ]
  before_action :authenticate_persona!
  before_action :authorize_self 

    def authorize_self 
      authorize self 
    end
    def index       
      #Variables para gestion de la grilla      
      grilla_id         = Grilla.find_by(cargo_id: current_persona.profesor.cargo_id,tipo_grilla: 'AUTO')
      profesor_id       = current_persona.profesor.id
      @contador         = 1;  
      @limite           = 20;       
          
      #Consultamos el id del periodo
      periodo_grilla_id = PeriodoGrilla.find_by(grilla_id: grilla_id)
      #creacion de una auto evaluacion
      if !periodo_grilla_id.blank?
        Autoevaluacion.generar_autoevaluacion(profesor_id,periodo_grilla_id)
      else
        redirect_to :back, :flash => { error: 'No hay un periodo de grilla creado.'}
      end   
       autoevaluacion_id    = Autoevaluacion.find_by(profesor_id: profesor_id)  
       #creacion de una autoevaluacion respuesta      
       AutoevaluacionRespuesta.crear_items_autoevaluacion grilla_id, profesor_id, autoevaluacion_id

       
       pagina              =  PaginaJustificacion.where(autoevaluacion_id: autoevaluacion_id.id ).maximum(:pagina) ; 
       @pagina=  (pagina == nil)? 1  :  pagina
         #Buscamos el numero de pagina inicial de la grilla
       if PaginaJustificacion.where(autoevaluacion_id: autoevaluacion_id.id, pagina: @pagina).blank?  
       puts 'auto evaluacion'
       puts autoevaluacion_id.id        
          PaginaJustificacion.crear_pagina_justificacion  autoevaluacion_id.id, @pagina, nil    
       end 
       pagina_id           =  PaginaJustificacion.where(autoevaluacion_id: autoevaluacion_id.id ).maximum(:id)

      #Creacion de arreglo para la constrccion de preguntas en la vista
      @respuestas_sinona   =  Hash.new
      @respuestas_sinona   =  AutoevaluacionRespuesta.joins(:autoevaluacion).joins(:grilla_autoevaluacion).
                              where(pagina: nil ,autoevaluacion_id: autoevaluacion_id)
      @EvaluacionRespuesta =  AutoevaluacionRespuesta.new 
      @Titulo              =  GrillaAutoevaluacion.where(id: 
                              AutoevaluacionRespuesta.where(autoevaluacion_id: autoevaluacion_id).
                              pluck(:grilla_autoevaluacion_id)).pluck(:instruccion)    
       
      @pagina_justificacion = PaginaJustificacion.where(id: pagina_id)


    end
    
    def guardar_autoevaluacion        
       autoevaluacion_id = params["autoevaluacion_respuesta"]["autoevaluacion"]  
       params["autoevaluacion_respuesta"].each{ |n, i| 
       if n!="registro_obligatorio"
         pagina_justificacion=PaginaJustificacion.where(autoevaluacion_id: autoevaluacion_id).maximum(:pagina)
         AutoevaluacionRespuesta.where(id: n).update_all(pagina: pagina_justificacion)        
       end 
       }
    
       pagina      =  PaginaJustificacion.where(autoevaluacion_id: autoevaluacion_id).maximum(:pagina) ;  
       PaginaJustificacion.crear_pagina_justificacion  autoevaluacion_id, (pagina + 1), nil 

       redirect_to autoevaluacion_index_path     
    end

   def guardar_autoevaluacion_item      
       puts 'salida de parametros'
       puts params['pregunta']
     if !params['pregunta'].blank?
       if params['pregunta'].length == 1         
         AutoevaluacionRespuesta.where(autoevaluacion_id:  params['autoevaluacion_id'], id: params['id']).update_all(valor: params['pregunta'])
       else
         if params['id'].to_f != 0
           puts 'paso actualiza justificacion'
           PaginaJustificacion.where(autoevaluacion_id:  params['autoevaluacion_id'], id: params['id']).update_all(justificacion: params['pregunta'])
         end
       end
     end
      
       redirect_to autoevaluacion_index_path     
    end 


      
      
end
