class ObservacionController < ApplicationController
  before_action :authenticate_persona!,only: [:show]
  #after_action :permission_denied
 
  
  def index
       authorize self
       @consulta_general=Persona.personas.observadores.select("personas.* ,canal_regionales.canal ").
                                 joins(:observador=>:canal_regional).order(:documento).
                                 paginate(:page => params[:page], :per_page => 10)   
                                  
     if params[:id]=="con_video"       
       @consulta_video = Persona.observadores.select("personas.*,tipo_documentos.documento tipo ,observadores_profesores.fecha_grabacion ,'Grabación finalizada' video_estado").distinct
                                 .joins(:tipo_documento)
                                 .joins(:profesor=>:observadores)
                                 .joins(:videos).con_video                                  
              
        render :json => @consulta_video
        
     elsif params[:id]=="sin_video"        
       @consulta_video = Persona.observadores.select("personas.*,tipo_documentos.documento tipo ,observadores_profesores.fecha_grabacion,'Proceso grabación' video_estado ").distinct
                                .joins(:tipo_documento)
                                .joins(:profesor=>:observadores).sin_video                                
       
        render :json => @consulta_video       
    end     
  end
  def show
     authorize self
     @persona=Persona.find(params[:id])     
     @profesor=Persona.personas
                          .joins(:profesor=>:observadores)
                          .where('observadores_profesores.observador_id'=>
                            Observador.where(:persona_id=>params[:id]).first.id)
                          .paginate(:page => params[:page], :per_page => 10)
  end      
  

    def observacion_params
      params.require(:observacion).permit(:nombre, :apellido_paterno, :apellido_materno, :tipo_documento_id, :documento, :direccion, :telefono, :celular, :email,:canal,:tipo_documento_profesor, :documento_profesor)
    end 

 
end
