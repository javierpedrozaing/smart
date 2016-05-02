class ArchivosController < ApplicationController
  before_action :authenticate_persona!
  before_action :file_params, only: [:upload_file]

  def upload_file
    cantidad_evaluaciones = Evaluacion.where(video_id: current_persona.profesor.video.id).count
    if cantidad_evaluaciones != 0
      redirect_to profesor_panel_path, alert: "El video ya está siendo evaluado!" and return
    end
    #puts params.inspect
    archivo = ArchivosPersona.new(file_params)
    archivo.persona_id = current_persona.id
    if archivo.save
      flash.notice = 'El archivo fue subido correctamente.'
      if current_persona.rol.rol = "Profesor"
        render json: { url: profesor_panel_path }, status: :ok
      else
        render json: { url: '/'}, status: :ok
      end

    else
      flash.alert = 'Error al cargar el archivo.'
      render json: { url: profesor_panel_path }, status: :ok
    end
  end
  
  def download
    @archivo = ArchivosPersona.find(params[:id])
    redirect_to @archivo.archivo.expiring_url(5400)
  end
  
  def download_certificado_no_carga
    html = render_to_string(:action => :show, layout: "")
  end

  def show_certificado_no_carga    
    @date = Funciones::Utilidades.format_time_spanish Time.now
    render layout: false
  end
  
  def generar_certificado_no_carga 
    @persona = Persona.where(:id=>params[:id])   
    @date = Funciones::Utilidades.format_time_spanish Time.now + 86400 #adelantamos un dia 86400

    render layout: false
  end
  private

  def file_params
    params.require(:archivos_persona).permit(:archivo, :tipo, :persona_id)
  end

  def planeacion_mime_types
    
  end

  def evidencias_mime_types
    
  end
end
