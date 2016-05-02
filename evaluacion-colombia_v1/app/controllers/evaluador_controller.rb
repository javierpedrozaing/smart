class EvaluadorController < ApplicationController
	before_action :authenticate_persona!
	#after_action :permission_denied
	
	def index
	  puts "prueba de ip"
	  puts request.remote_ip
	 # puts request.env["REMOTE_ADDR"] ip local
	 #Validar ip para centros de evaluacion autorizados
	   if  HostPermitido.where(host: request.remote_ip).blank?
         reset_session
         redirect_to :authenticated_root, :flash => { error: 'No se encuentra en su lugar de trabajo.'}
     end     
         
	  authorize self
    @reportes = Reporte.where(persona_id: current_persona.id).pluck(:video_id)
    ##Topic.where('id NOT IN (?)', (actions.empty? ? '', actions)
    ##@pendientes = current_persona.evaluador.evaluaciones.where(estado_evaluacion_id: 1).where("video_id NOT IN (?)",@reportes).count
    @pendientes = current_persona.evaluador.evaluaciones.where(estado_evaluacion_id: 1).where.not(video_id: @reportes).count
    @terminadas = current_persona.evaluador.evaluaciones.where(estado_evaluacion_id: 3).count
    @en_proceso = Evaluacion.where(estado_evaluacion_id: 2).where(evaluador_id: current_persona.evaluador.id)
    
    @evaluaciones = Evaluacion.where.not(estado_evaluacion_id: 3).where(evaluador_id: current_persona.evaluador.id)

	 
       
   end
  def terminadas
    authorize self
    @evaluaciones = Evaluacion.where(estado_evaluacion_id: 3)
  end

  def evaluar
    #Validar ip para centros de evaluacion autorizados
    if  HostPermitido.where(host: request.remote_ip).blank?
         reset_session
         redirect_to :authenticated_root, :flash => { error: 'No se encuentra en su lugar de trabajo.'}
     end  
    coordinador = current_persona.coordinador
    if coordinador.nil?
      @evaluacion = current_persona.evaluador.evaluaciones.first
      if @evaluacion.blank? || @evaluacion.evaluador_id != current_persona.evaluador.id
        redirect_to evaluador_path, alert: "No tiene permisos para ver esta evaluación" and return
      end
      ##@evaluacion = current_persona.evaluador.evaluaciones.first
      @evaluacion = Evaluacion.where("evaluador_id = ? AND estado_evaluacion_id = 2", current_persona.evaluador.id).first
      
      @evaluacion = Evaluacion.where("evaluador_id = ? AND estado_evaluacion_id = 1", current_persona.evaluador.id).first if @evaluacion.nil?
    else
      @evaluacion = coordinador.evaluaciones.procesando.first
      @evaluacion = coordinador.evaluaciones.pendientes.first if @evaluacion.nil?
    end
    
    @evaluacion.estado_evaluacion_id = 2
    @evaluacion.save(validate: false)
    
    @video = Video.find(@evaluacion.video_id)
    persona_id=Profesor.find(@evaluacion.profesor_id).persona_id
    arrayArchivos     =ArchivosPersona.where(:persona_id=>persona_id).group(:tipo).maximum(:id) 
    @archivopersonas= ArchivosPersona.where(:id=>[arrayArchivos[1],arrayArchivos[2]]) #extraccion de los archivos del evaluado
    @evidenciaformes= EvidenciaForm.where(:profesor_id=>@evaluacion.profesor_id).
                       select(:grado, :modelo_educativo, :tiempo_laborado_institucion,:desarrollo_tematico,
                              :propositos_objetivos,:relacion_planes,:planeacion_pei,
                              :organizacion_contenidos,:planeacion_aspectos_criterios,:materiales_recursos,
                              :evaluacion_retroalimentacion_clase,:metodologias_estrategias_empleadas) # formulario de planeacion o evaluacion para modal
    
    #### quitamos @categorias = Categoria.all pa ver que pasa
    @categorias = Categoria.all
    respuestas = EvaluacionRespuesta.byEvaluacion(@evaluacion)

    @respuestas = []

    resp = Hash.new


    resp["ACD"] = respuestas.select { |x| x.grilla_item.categoria.codigo == "ACD" }
    resp["ACE"] = respuestas.select { |x| x.grilla_item.categoria.codigo == "ACE" }

    ###validacion existencia actividad en caso de que sea nil
    
    ####aqui le finalicemos

    #@todas_las_categorias = Categoria.all ####nos falta realizar busqueda por cargo
    @todas_las_categorias = Categoria.where(cargo_id: @video.profesor.cargo.id)
                    

    puts "hola probando categorias"
    puts @todas_las_categorias.nil?
    puts @todas_las_categorias.length
    puts "El cargo del profesor"
    puts @video.profesor.cargo.id
    


    ##AQUI LE METIMOS MANO eXTIO :)- AQUI LAS TRAEMOS TODAS LAS CATEGORIAS-->
    @respuestas_sinona = Hash.new
    @actividades = Hash.new
    @actividades["ACD"] = (0..9).map { |i| resp["ACD"].select { |x| x.numero_actividad == (i+1) } }
    @actividades["ACE"] = (0..9).map { |i| resp["ACE"].select { |x| x.numero_actividad == (i+1) } }
    
      
    @todas_las_categorias.each do |catego| 
    ###probando cambio una cosa por la otra
    @respuestas_sinona[catego.codigo] = respuestas.select { |x| x.grilla_item.categoria.codigo == catego.codigo }

    end 

puts @respuestas_sinona.nil?
puts @respuestas_sinona.length
  end

  def guardar_evaluacion
    #asdsadsadasasdsadasd
    params[:evaluacion][:evaluador_id] = nil if params[:evaluacion][:evaluador_id].blank? 
    
    @evaluacion = Evaluacion.where(
                                  id: set_evaluacion_params[:evaluacion_id],
                                  profesor_id: set_evaluacion_params[:profesor_id],
                                  evaluador_id: set_evaluacion_params[:evaluador_id],
                                  video_id: set_evaluacion_params[:video_id]).first
                                  
    #respuestas_obligatorias_sin_contestar = EvaluacionRespuesta.byEvaluacion(@evaluacion).where(numero_actividad:[nil,1,2,3,4] , valor: nil).count
    respuestas_obligatorias_sin_contestar = EvaluacionRespuesta.byEvaluacion(@evaluacion).where(valor: nil,actividad_obligatoria: '1').count
    
    if respuestas_obligatorias_sin_contestar > 0
      redirect_to evaluador_evaluar_path, alert: "Debe responder todos los items" and return
    end
    
    @evaluacion.estado_evaluacion_id = 3
    @evaluacion.valor = set_evaluacion_params[:valor]
    if @evaluacion.save
      @evaluaciones = Evaluacion.where(
                                  estado_evaluacion_id: 3,
                                  profesor_id: set_evaluacion_params[:profesor_id],
                                  video_id: set_evaluacion_params[:video_id]).where.not(valor: nil)
                                  
      if @evaluaciones.count == 2
        e1 = @evaluaciones.first
        e2 = @evaluaciones.second
        
        respuestas = EvaluacionRespuesta.joins('
            join evaluacion_respuestas as er on(evaluacion_respuestas.grilla_item_id = er.grilla_item_id)').select('
            evaluacion_respuestas.valor as v1, er.valor as v2').where('evaluacion_respuestas.evaluacion_id = ? AND er.evaluacion_id = ? AND evaluacion_respuestas.numero_actividad IS NULL and er.numero_actividad IS NULL', e1.id, e2.id)
            
        total_respuestas = respuestas.to_a.length
        total_discrepancias = respuestas.reduce(0){ |acc, x| x.v1 != x.v2 ? acc + 1 : acc }
        
        if 100.0*total_discrepancias/total_respuestas > 18.0
          coordinador = Coordinador.asignar_coordinador
          
          ### 
          Evaluacion.generar_evaluacion(@evaluacion.video_id, 1, true, Region.all.map{ |r| r.id }, coordinador)
        end
      end
      
      redirect_to coordinador_path, notice: "Evaluación guardada con éxito" and return if !current_persona.coordinador.nil?
      
      redirect_to evaluador_path, notice: "Evaluación guardada con éxito."
    else
      render :evaluar_profesor
    end
  end
 def actividad_obligatoria      
    EvaluacionRespuesta.where(evaluacion_id: params[:id], numero_actividad: params[:actividad]).update_all(actividad_obligatoria: params[:obligatorio])   
    redirect_to :authenticated_root, :flash => { error: 'Se esta procesando actividad.'}
 end
   
  private

  def set_evaluacion_params
    params.require(:evaluacion).permit(:profesor_id, :evaluador_id, :video_id, :valor,:evaluacion_id )
  end
  
  def tercera_evaluacion video_id
  end
end
