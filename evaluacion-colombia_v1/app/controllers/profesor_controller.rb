class ProfesorController < ApplicationController
  before_action :authenticate_persona!
  before_action :get_video_object, only: [:video, :validar_video, :validar_video_modal]


  def video
    @valid = ValidateVideo.new
  end

  def validar_video
    @valid = ValidateVideo.new
    if params[:validate_video].nil?
      redirect_to profesor_video_path, alert: 'Debe seleccionar una opción de validación.'
    else
      @valid = ValidateVideo.new(set_parameters)
      @video.identidad_verificada = @valid.presencia
      if @valid.presencia 
        2.times do
          Evaluacion.generar_evaluacion(@video.profesor_id, @video.id, true)
        end
      end
      if @video.save
        redirect_to profesor_path, notice: "Validación guardada con éxito."
      else
        redirect_to profesor_video_path, alert: 'No se pudo validar el video, dado que el video no existe.'
      end
    end
  end

  def validar_video_modal
    if @video.identidad_verificada == true
      redirect_to profesor_panel_path, alert: 'Su video ya habia sido enviado para evaluación.' and return
    end
    
    @valid = ValidateVideoModal.new
    if params[:validate_video_modal].nil?
      redirect_to profesor_panel_path, alert: 'Debe seleccionar una opción en cada pregunta.'
      return
    end
    @valid = ValidateVideoModal.new(params[:validate_video_modal])
    if @valid.presencia == "false"
      @video.identidad_verificada = false
      persona=Persona.where(:documento=>current_persona.documento).first
      Persona.update(persona.id,pico_placa:false)
      @video.save
      ##Generar reporte
    end
    if !check_video_modal(@valid.presencia, @valid.practica, @valid.consentimiento , @valid.manual)
      redirect_to profesor_panel_path, alert: 'Debe seleccionar "Sí" en los 4 campos para que su video sea enviado a evaluación.'
      return
    else
      @video.identidad_verificada = @valid.presencia
      ##El revisor de video ya no existe en el flujo, CORRECCION VOLVIO AL FLUJO
      ##RevisorVideo.create_entry(EstadoRevisionVideo.PENDIENTE, @video.id)
      ##git commit
      #@revisor = RevisorVideo.new
        #@revisor.estado = EstadoRevisionVideo.PENDIENTE
        #@revisor.video_id = @video.id
        #@revisor.revisor_id = Persona.revisores.first.id
        #@revisor.save
       #Jeyson Correa M Cargue de archivos validos segun perfil 
      case current_persona.profesor.cargo.id 
           when 1    #Cargo Docente      
            archivos_validos_cargo = [1, 2]            
           when 2    #Cargo Directivo    
            archivos_validos_cargo = [1, 2, 3]
           when 3    #Cargo Directivos sindicales    
             archivos_validos_cargo = [1,3]
           when 4    #Cargo Docente de aula    
             archivos_validos_cargo = [1, 2] 
           when 5    #Cargo Docente orientador    
             archivos_validos_cargo = [1, 2, 3]  
           when 6    #Cargo Docente Tutor del PTA    
             archivos_validos_cargo = [1,3]   
           when 7    #Cargo Rector    
              archivos_validos_cargo = [1, 2, 3] 
           when 8    #Cargo Directivo rural
              archivos_validos_cargo = [1, 2, 3]               
           when 9    #Cargo Coordinador    
              archivos_validos_cargo = [1, 2, 3]
           else   #Cargo Docente o docente de aula      
              archivos_validos_cargo = [1, 2] 
      end   
      #fin cargue de archivos validos segun perfil
      cantidad_archivos = ArchivosPersona.where(persona_id: current_persona.id, tipo: archivos_validos_cargo).count
      evidencia_form = current_persona.profesor.evidencia_form
      
      if cantidad_archivos < archivos_validos_cargo.count || (evidencia_form.blank? && current_persona.profesor.cargo.id == 4)
        redirect_to profesor_panel_path, alert: 'Debe subir los archivos necesarios y completar el formulario de planeación.' and return
      elsif @video.save
        #redirect_to profesor_panel_path, notice: "Su formulario de validación  fue guardado con éxito."
        ##Se crean las evaluaciones pertinentes
          ##Evaluacion.generar_evaluacion(@video.profesor_id, @video.id, true)
        
        RevisorVideo.create_entry(EstadoRevisionVideo.PENDIENTE, @video.id)
        #busca id de la persona que finaliza el proceso de cargue y envia a evaluar
        persona=Persona.where(:documento=>current_persona.documento).first
        Persona.update(persona.id,pico_placa:false)
        ##Se crean despues de que el revisor de video valida
        ##Evaluacion.generar_evaluacion(@video.id, 1,true, [current_persona.profesor.departamento_id, nil])
        ##Evaluacion.generar_evaluacion(@video.id, 1,true, Departamento.all.to_a.map{ |d| d.id }.reject{ |d_id| d_id == current_persona.profesor.departamento_id}.append(nil))
          
        redirect_to profesor_path, notice: "Su video ha sido enviado para revisión."
        return
      else
        redirect_to profesor_panel_path, alert: 'No se pudo validar el video, dado que el video no existe.'
        return
      end
    end
  end

  def panel
    @planeacion_file = ArchivosPersona.where(persona_id: current_persona.id, tipo: 1)
    @evidencias_file = ArchivosPersona.where(persona_id: current_persona.id, tipo: 2)
    @planeacion_cargo_file = ArchivosPersona.where(persona_id: current_persona.id, tipo: 3)# Formulario de planeacion cargo
    @video = current_persona.profesor.video
    if current_persona.profesor.cargo_id == 0 || current_persona.profesor.cargo_id.nil? #sino posee cargo muestra mensaje
      flash[:notice] = "Usted no posee un cargo asociado, favor comuniquese con ICFES"      
    end
    #Se cambia pico placa para solo el boton de cargue de video
    @pico_placa =  Persona.where(:documento=>current_persona.documento).pluck(:pico_placa)
    # Ver para la subida de las evaluaciones
    @valid = ValidateVideoModal.new
    ##current_persona.profesor.video.conversion_status == 'COMPLETED'
    if !current_persona.profesor.video.blank?
    @identidad = current_persona.profesor.video.identidad_verificada
    if current_persona.profesor.video
      @cantidad_evaluaciones = Evaluacion.where(video_id: current_persona.profesor.video.id).count
    else
      @cantidad_evaluaciones = 0
    end
    @preview30 = current_persona.profesor.video.conversion_status
    if !@video.attach_file_name.blank? && @preview30 != 'COMPLETED'
      flash[:notice] = "El video se está procesando. Favor recargar la página en unos minutos."
    end
   end
  end

  def formulario_planeacion
    cantidad_evaluaciones = Evaluacion.where(video_id: current_persona.profesor.video.id).count
    ##if cantidad_evaluaciones != 0
      ##redirect_to profesor_panel_path, alert: "El video ya está siendo evaluado!" and return
    ##end
    
    @evidencia_form = current_persona.profesor.evidencia_form
   
    if @evidencia_form.blank?
      @evidencia_form = EvidenciaForm.new
    end
  end
  
  def guardar_formulario_planeacion
    ##asdsadsadsadsadsad
    ##@evidencia_form = EvidenciaForm.new(params['evidencia_form'])
    @evidencia_form = current_persona.profesor.evidencia_form
    if @evidencia_form.blank?
      #@evidencia_form = EvidenciaForm.new
      @evidencia_form = EvidenciaForm.new(formulario_planeacion_params)
    else
      @evidencia_form.update_attributes(formulario_planeacion_params)
    end
    #@evidencia_form = EvidenciaForm.new(formulario_planeacion_params)
    if current_persona.profesor
      @evidencia_form.profesor_id= current_persona.profesor.id
    end
    respond_to do |format|
      if @evidencia_form.save
        format.html { redirect_to profesor_panel_path, notice: 'Su formulario ha sido guardado exitosamente.' }
        #format.html { redirect_to @portafolio, notice: 'Portafolio was successfully created.' }
        #format.json { render :show, status: :created, location: @portafolio }
      else
        format.html { render "_formulario_planeacion_evidencias" }
        ##render "cargar_profesor"
        ##format.html { , alert: 'El formulario no fue guarado ya que contiene errores.' }
        #format.html { redirect_to profesor_formulario_planeacion_path, alert: 'El formulario no fue guarado ya que contiene errores.' }
        #format.html { render :new }
        #format.json { render json: @portafolio.errors, status: :unprocessable_entity }
      end
    end
  end
  def portafolio_form
    #authorize  self
    @portafolio = Portafolio.new
  end
  
  def portafolio_create
    #authorize  self
    @portafolio = Portafolio.new(portafolio_params)
    #@post.usuario_id = current_persona.id
    respond_to do |format|
      if @portafolio.save
        format.html { redirect_to profesor_path, notice: 'Portafolio was successfully created.' }
        #format.html { redirect_to @portafolio, notice: 'Portafolio was successfully created.' }
        #format.json { render :show, status: :created, location: @portafolio }
      else
        format.html { redirect_to profesor_path, notice: 'Portafolio was not successfully created.' }
        #format.html { render :new }
        #format.json { render json: @portafolio.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def index 
    #Se cambia  Boton pico placa para bloqueo en panel para el boton de carga
    #@pico_placa =  Persona.where(:documento=>current_persona.documento).pluck(:pico_placa)
    aux_prof =  Persona.where(:documento=>current_persona.documento).first.profesor
    if !aux_prof.video.nil? 
      @identidad = aux_prof.video.identidad_verificada
    end
    
  end  
  
  def download_file
    puts 'parametros de salida'
    puts params[:format]
      @filename ="#{Rails.root}/public/system/plantillas_cargos/#{params[:format]}.pdf"
     send_file(@filename ,
      :type => 'application/pdf/docx/html/htm/doc',
      :disposition => 'attachment')
    
  end

  private

    def get_video_object
      @video = current_persona.profesor.video
    end
    def formulario_planeacion_params
      params.require(:evidencia_form).permit!
      ##params.require(:evidencia_form).permit(:id, :nombre, :apellido_paterno, :apellido_materno, :tipo_documento_id, :documento, :direccion, :telefono, :celular, :email,:archivo, :consentimiento, :password, :password_confirmation)
    end
    def set_parameters
      params.require(:validate_video).permit(:presencia)
    end
    def set_parameters_modal
      params.require(:validate_video_modal).permit(:presencia, :practica, :consentimiento, :manual)
    end

    def check_video_modal presencia, practica, consentimiento, manual
      if presencia.blank? || practica.blank? || consentimiento.blank? || manual.blank?
        return false
      end
      if presencia == "false" || practica == "false" || consentimiento == "false" || manual == "false"
        return false
      end
      return true
    end
end
