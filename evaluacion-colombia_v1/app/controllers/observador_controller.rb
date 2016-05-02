class ObservadorController < ApplicationController
  before_action :authenticate_persona!
  #after_action :permission_denied

  def index
    authorize self
    @personas = current_persona.observador.profesores.map{ |x| x.persona }
    puts "@personas: "<<@personas.to_json
    #@profesores = Video.where(observador_id: current_persona.observador.id).map{ |x| x.profesor.persona }
    @con_video = Video.all
    #Video.update_progreso_conversion_videos
  end

  def upload
  end

  def show
    @observador_id = current_persona.id
  end

  def persona_videos
    [@persona_video1, @persona_video2]    
  end
  
   def detalle_profesor
      @persona=Persona.find(params[:id])
    end
    def enviar_video_modal
      redirect_to observador_path, notice: "El vídeo fue enviado con éxito."
    end
end
