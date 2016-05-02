  class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy, :reportar_video, :download]
  #before_action :set_profesores, only: [:new, :create, :edit, :update, :show]
  #before_action :set_observador, only: [:new, :create, :edit, :update, :show]
  before_action :authenticate_persona!, :except => [:update_state]
  skip_before_action :verify_authenticity_token, only: :update_state
  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1
  # GET /videos/1.JSON
  def show
    @video = Video.find(params[:id])
    @profesor = @video.profesor
    @observador = @video.observador
    delete_key = @video.attach_file_name
  end

  # GET /videos/new
  def new
    params.permit(:id)
    @video = Profesor.find(params[:profesor_id]).video
    @profesor_selected = ""
    if current_persona.rol.rol == "Profesor"
      @profesor_selected = current_persona.profesor.id
    else
      @profesor_selected = params[:profesor_id]
    end
  end

  # GET /videos/1/edit
  def edit
    cantidad_evaluaciones = Evaluacion.where(video_id: params[:id]).count
    if cantidad_evaluaciones != 0
      redirect_to profesor_panel_path, alert: "El video ya está siendo evaluado!" and return
    end
    
    @profesor_selected = @video.profesor_id
    #@observador = @video.observador_id
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.where(video_params).first
    #@profesor_selected = @video.personas.first.id
    @profesor_selected = params[:profesor_id]
    saved = @video.save
    puts 'entro cuando cargue un video'
    if saved
      pipeline_id = '1439848270326-bs22oc'
      input_key = URI(@video.attach.url).path
      input_key = input_key[1..input_key.length]
      region = 'us-west-1'
      transcoder_client = AWS::ElasticTranscoder::Client.new(region: region)
      Funciones.get_options pipeline_id, input_key
      job = transcoder_client.create_job(options)
      job_id = job[:job][:id]
      @video.transcoder_job_id = job_id
      @video.save
      p job
    end
    respond_to do |format|
      if saved
        generar_evaluaciones(@video.profesor.id, @video.id)
        format.html { redirect_to video_path(@video.id), notice: 'Video fue creado con éxito.' }
        format.json { render :show, status: :created, location: @video }
      else
        #format.html { render :new }
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    cantidad_evaluaciones = Evaluacion.where(video_id: params[:id]).count
    if cantidad_evaluaciones != 0
      render json: ["El video ya está siendo evaluado!"], status: :unprocessable_entity and return
    end
    
    delete_key = @video.attach_file_name
    @video.transcoder_job_id = nil
    @video.conversion_status = nil
    @video.identidad_verificada = nil
    @video.save
    saved = @video.update_attributes(video_params)
    puts "VIDEO PARAMS"
    puts video_params
    puts "##############################################################################"
    @video.errors.inspect
    puts "##############################################################################"
    respond_to do |format|
      if saved

        Video.initiate_video_conversion @video, !delete_key.blank?
        
        if @video.conversion_status == "COMPLETED"
          flash.notice = 'El video fue subido correctamente.'
        end
        if @video.conversion_status == "ERROR"
          flash.alert = 'Hubo un error al procesar el video.'
        end
        if current_persona.rol.rol == "Profesor"

          format.json { render json: { url: profesor_panel_path}, status: :ok }
        end
        if current_persona.rol.rol == "Camarógrafo"
          format.json { render json: { url: observador_path}, status: :ok }
        end
      else
        #format.html { render :new }
        @video.intentos = @video.intentos + 1
        @video.save(validate: false)
        #format.html { redirect_to new_video_path(profesor_id: @video.profesor_id), alert: 'Debe seleccionar un archivo' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
        #render json: { error: @video.errors.full_messages.join(',')}, :status => 400
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video fue eliminado correctamente.' }
      format.json { head :no_content }
    end
    end

  def reportar
    @reporte = Reporte.new
    @video_id = Video.find(params[:id]).id
  end

  def procesar_reporte
    puts 'esto esta llegando'
    coordinador = current_persona.coordinador
    @evaluacion = nil
    if coordinador.nil?
      @evaluacion = current_persona.evaluador.evaluaciones.procesando.first
      if @evaluacion.blank? || @evaluacion.evaluador_id != current_persona.evaluador.id
        redirect_to evaluador_path, alert: "No tiene permisos para ver esta evaluación" and return
      end
      
      if @evaluacion.video_id != params[:reporte][:video_id].to_i
        redirect_to evaluador_path, alert: "No tiene permisos para reportar este video" and return
      end
      #se comentarea porque al darle dos veces clic sin selecionar ningun item cierra la evaluacion
      #@evaluacion.estado_evaluacion_id = 3
      #@evaluacion.save(validate: false)
   
      ##@evaluacion = current_persona.evaluador.evaluaciones.first
      #@evaluacion = Evaluacion.where("evaluador_id = ? AND estado_evaluacion_id IN (2,1)", current_persona.evaluador.id).first
    end
    
    
    
    @reporte = Reporte.new(reporte_params)
    @video_id = params[:reporte][:video_id].to_i
    puts 'esta guardando el reporte'
   
    save_uno = crear_reporte(current_persona.id, params[:reporte][:video_id], params[:reporte][:reporte_imagen], params[:reporte][:reporte_audio], params[:reporte][:causa], @evaluacion)
   
    path = coordinador.nil? ? evaluador_path : coordinador_path
    #p "--------------------------------------------------------------"
    respond_to do |format|
      if save_uno
       #se coloca aqui porque al dejarlo donde estaba al darle dos veces clic sin selecionar ningun item cierra la evaluacion 
       @evaluacion.estado_evaluacion_id = 3
       @evaluacion.save(validate: false)
        format.html { redirect_to path, notice: 'Reporte fue creado con éxito.' }
      else
        format.html { redirect_to reportar_video_path(id: @video_id), alert: "Debe seleeccionar una opción de reporte." }
      end
    end
  end
  
def procesar_reporte_revisor
  @reporte = Reporte.new(reporte_params)
  @video_id = params[:reporte][:video_id].to_i

  save_uno = crear_reporte_revisor(current_persona.id, params[:reporte][:video_id], params[:reporte][:reporte_imagen], params[:reporte][:reporte_audio], params[:reporte][:causa])
  ##save_uno = true
    #p "--------------------------------------------------------------"
  respond_to do |format|
    if save_uno
      revision=RevisorVideo.find(params[:reporte][:revision_id].to_i)
      revision.estado=3
      revision.save
      format.html { redirect_to revisor_videos_path, notice: 'Reporte fue creado con éxito.' }
    else
      format.html { redirect_to reportar_video_path(id: @video_id), alert: "Debe seleeccionar una opción de reporte." }
    end
  end
end

  def download
    redirect_to @video.attach.expiring_url(5400)
  end

  def update_state
    Funciones::Amazon.update_video_state(request)
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def check_status
    render json: { url: '/', video_id: params[:video_id]}, status: :ok
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end
    def crear_reporte_revisor(persona_id, video_id, tipo_reporte_uno, tipo_reporte_dos, causa)
      save_uno = false
      if tipo_reporte_uno != "0"
        repo = Reporte.new(reporte_params)
        repo.persona_id = persona_id
        repo.video_id = video_id
        repo.tipos_reporte_id = 1
        repo.revisado = true
        repo.tercer_evaluador = false
        repo.causa = causa
        repo.save
        
        ##CoordinadorReporte.create(coordinador_id: coordinador.id, reporte_id: repo.id, evaluacion_id: evaluacion.id) if !evaluacion.nil?
        save_uno = true
      end
      
      if tipo_reporte_dos != "0"
        aux = Reporte.new(reporte_params)
        aux.persona_id = persona_id
        aux.video_id = video_id
        aux.tipos_reporte_id = 2
        aux.revisado = true
        aux.tercer_evaluador = false
        aux.causa = causa
        aux.save
        
        ##CoordinadorReporte.create(coordinador_id: coordinador.id, reporte_id: aux.id, evaluacion_id: evaluacion.id) if !evaluacion.nil?
        save_uno = true
      end
       
      save_uno
    end
    def crear_reporte(persona_id, video_id, tipo_reporte_uno, tipo_reporte_dos, causa, evaluacion)
      if !evaluacion.nil?
        evaluacion_par = Evaluacion.where(
                                  valor: nil,
                                  estado_evaluacion_id: 3,
                                  video_id: video_id).where.not(id: evaluacion.id).first
      
        if !evaluacion_par.nil?
          coordinador = Coordinador.asignar_coordinador_reporte
        else
          coordinador = Coordinador.asignar_coordinador_reporte
        end
        
        revisado = false
        tercer_evaluador = false
      else
        revisado = false
        tercer_evaluador = true
        
        coordinador = current_persona.coordinador
        
        coordinador_reportes = CoordinadorReporte.includes(:reporte).where(coordinador_id: coordinador.id, reportes: { video_id: video_id, revisado: false, tercer_evaluador: false })
        
        coordinador_reportes.each do |cr|
          cr.reporte.revisado = true
          cr.reporte.save
        end
      end

      save_uno = false
   
      if tipo_reporte_uno != "0"
        repo = Reporte.new(reporte_params)
        repo.persona_id = persona_id
        repo.video_id = video_id
        repo.tipos_reporte_id = 1
        repo.revisado = revisado
        repo.tercer_evaluador = tercer_evaluador
        repo.causa = causa.to_s #Se incorpora por solicitud de icfes de reportar tambien con texto
        repo.save
        
        CoordinadorReporte.create(coordinador_id: coordinador.id, reporte_id: repo.id, evaluacion_id: evaluacion.id) if !evaluacion.nil?
        save_uno = true
      end
      
      if tipo_reporte_dos != "0"
        aux = Reporte.new(reporte_params)
        aux.persona_id = persona_id
        aux.video_id = video_id
        aux.tipos_reporte_id = 2
        aux.revisado = revisado
        aux.tercer_evaluador = tercer_evaluador
        aux.causa = causa #Se incorpora por solicitud de icfes de reportar tambien con texto
        aux.save
        
        CoordinadorReporte.create(coordinador_id: coordinador.id, reporte_id: aux.id, evaluacion_id: evaluacion.id) if !evaluacion.nil?
        save_uno = true
      end
       
      save_uno
    end

    def set_profesores
      @profesores = Persona.profesores.map {|x| x.profesor}
    end

    def set_observador
      @observador = current_persona.observador
    end

    def generar_evaluaciones profesor_id, video_id
      2.times do
        Evaluacion.generar_evaluacion(profesor_id, video_id, true)
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:attach, :profesor_id, :observador_id)
    end

    def reporte_params
      params.require(:reporte).permit(:video_id, :reporte_imagen, :reporte_audio)
    end

    def create_or_update file_name
    if file_name.blank?
      "/videos/create"
    else
      "/videos/update"
    end
  end
end
