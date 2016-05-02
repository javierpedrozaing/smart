class AdministracionController < ApplicationController
  before_action :authenticate_persona!
  #after_action :permission_denied
  def index        
        authorize self 
        @consulta_general=Persona.personas.select("personas.*,secretarias_educaciones.secretaria secretaria_educacion,secciones_educativas.seccion seccion").
                                joins(:profesor=>:secretarias_educacion).
                                joins(:profesor=>:secciones_educativa).                            
                                paginate(:page => params[:page], :per_page => 10)                      
  end 
  
  def previsualizacion_video
  end
  
  def reporte_estados
     if  params[:id]=="reporte_Sin_Evaluar"
        @Criterio="Pendiente evaluación"
     
      elsif  params[:id]=="reporte_Con_Una_Evaluacion"
        @Criterio="Evaluado Uno"
      
      elsif  params[:id]=="reporte_Tercer_evaluadorr"
        @Criterio="Evaluado Tres"
      
      elsif  params[:id]=="reporte_Finalizada"
        @Criterio="Evaluación finalizada" 
            
        #Para perfil de camarografo     
      elsif  params[:id]=="reporte_En_Plataforma"
      
        @Criterio="Grabación Finalizada"
        
      elsif  params[:id]=="reporte_Pendientes"
      
        @Criterio="Pendientes Grabar"
                 
      end
   end
  def revisor_index
    ##@evaluaciones = Evaluacion.where.not(estado_evaluacion_id: 3).where(evaluador_id: current_persona.evaluador.id)
    
    ##@revision = RevisorVideo.where(revisor_id: current_persona.id).where.not(estado: 2).first
    @revision = RevisorVideo.includes(:video).where(revisor_id: current_persona.id).where(estado: 1).where('videos.observador_id = ?',0).references(:video).first
    @revision_camarografo = RevisorVideo.includes(:video).where(revisor_id: current_persona.id).where(estado: 1).where.not('videos.observador_id = ?',0).references(:video).first
    
    @auto_aprobados = RevisorVideo.includes(:video).where(revisor_id: current_persona.id).where(estado: 2).where('videos.observador_id = ?',0).references(:video).count
    @auto_reportados = RevisorVideo.includes(:video).where(revisor_id: current_persona.id).where(estado: 3).where('videos.observador_id = ?',0).references(:video).count
    @auto_revisados = @auto_aprobados+@auto_reportados
    @auto_por_revisar = RevisorVideo.includes(:video).where(revisor_id: current_persona.id).where(estado: 1).where('videos.observador_id = ?',0).references(:video).count
    @auto_total =  RevisorVideo.includes(:video).where(revisor_id: current_persona.id).where('videos.observador_id = ?',0).references(:video).count
    
    @cama_aprobados = RevisorVideo.includes(:video).where(revisor_id: current_persona.id).where(estado: 2).where.not('videos.observador_id = ?',0).references(:video).count
    @cama_reportados = RevisorVideo.includes(:video).where(revisor_id: current_persona.id).where(estado: 3).where.not('videos.observador_id = ?',0).references(:video).count
    @cama_revisados = @cama_aprobados+@cama_reportados
    @cama_por_revisar = RevisorVideo.includes(:video).where(revisor_id: current_persona.id).where(estado: 1).where.not('videos.observador_id = ?',0).references(:video).count
    @cama_total =  RevisorVideo.includes(:video).where(revisor_id: current_persona.id).where.not('videos.observador_id = ?',0).references(:video).count

    if @revision
      @video = Video.find(@revision.video_id)
    end
    
    if @revision_camarografo
      @video_camarografo = Video.find(@revision_camarografo.video_id)
    end
    
  end
  def revisor_guardar
    ##@revision =RevisorVideo.find(1)
    @revision =RevisorVideo.find(params[:revisor_video][:revision_id])
    ##@revision =RevisorVideo.find(params[:revision_id])
    @revision.estado = 2 
    if @revision.save
          ##2.times do
            ##Evaluacion.generar_evaluacion(@revision.video.profesor_id, @revision.video.id, true)
          ##end
          ##comentados para hacer pruebas sin generar evaluaciones
          ##Evaluacion.generar_evaluacion(@revision.video.id, 1,true, [@revision.video.profesor.departamento_id, nil])
          ##Evaluacion.generar_evaluacion(@revision.video.id, 1,true, Departamento.all.to_a.map{ |d| d.id }.reject{ |d_id| d_id == @revision.video.profesor.departamento_id}.append(nil))
          ##Evaluacion.generar_evaluacion(params[:video_id], 1, true, departamentos_id, nil,evaluador.id)
        
        ####---------------------------este es el codigo que permite que el id de la grilla sea dinamico
         grilla_cargo = Grilla.find_by cargo_id: @revision.video.profesor.cargo.id

         logger.debug "Grilla del profesor del video:"
         logger.debug grilla_cargo.nil?
         
         if (grilla_cargo.nil?)
            #mensaje indicando que no hay grilla para el cargo
            @revision.estado = 1
            @revision.save
            redirect_to revisor_videos_path, alert: "No hay una grilla configurada para el cargo asociado al video." and return true
          else
             evaluador1 = Evaluacion.generar_evaluacion(@revision.video.id, grilla_cargo.id,true, [@revision.video.profesor.departamento.region.id, nil])
             if evaluador1.nil?
               evaluador2 = Evaluacion.generar_evaluacion(@revision.video.id, grilla_cargo.id,true, Region.all.to_a.map{ |r| r.id }.reject{ |r_id| r_id == @revision.video.profesor.departamento.region.id}.append(nil))
             else
               evaluador2 = Evaluacion.generar_evaluacion(@revision.video.id, grilla_cargo.id,true, Region.all.to_a.map{ |r| r.id }.reject{ |r_id| r_id == @revision.video.profesor.departamento.region.id}.append(nil),nil,ev1)
             end
          end
         ###-------------------------------------------------------------------------------------------------

        ###  ev1 = Evaluacion.generar_evaluacion(@revision.video.id, 1,true, [@revision.video.profesor.departamento.region.id, nil])
        ### if ev1.nil?
        ###   ev2 = Evaluacion.generar_evaluacion(@revision.video.id, 1,true, Region.all.to_a.map{ |r| r.id }.reject{ |r_id| r_id == @revision.video.profesor.departamento.region.id}.append(nil))
        ### else
        ###   ev2 = Evaluacion.generar_evaluacion(@revision.video.id, 1,true, Region.all.to_a.map{ |r| r.id }.reject{ |r_id| r_id == @revision.video.profesor.departamento.region.id}.append(nil),nil,ev1)
        ### end
            ##ev2 = Evaluacion.generar_evaluacion(@revision.video.id, 8,true, Region.all.to_a.map{ |r| r.id }.reject{ |r_id| r_id == @revision.video.profesor.departamento.region.id}.append(nil))
          if(evaluador1.nil? || evaluador2.nil?)
            @notif = Notificacion.new()
            @notif.texto = "El evaluado con documento: "+@revision.video.profesor.persona.documento+ " tiene evaluaciones sin un evaluador asociado, no se encontro evaluador que cumpliera los criterios de asignación"
            @notif.visible = true
            ##Tipo de notificacion_general
            @notif.tipo_notif_id = 4
            @notif.rol_id = 2
            @notif.save
            redirect_to revisor_videos_path, notice: "Revision guardada con éxito pero no se encontro un par evaluador apropiado para la evaluación."
          else
            redirect_to revisor_videos_path, notice: "Revision guardada con éxito."
          end
          
          
        else
      redirect_to revisor_videos_path, alert: "Hubo un error al guardar su revision."
        end
  end
  def revisor_reset
    current_persona.reset_revisiones
    redirect_to :back, :flash => { notice: 'Sus revisiones ahora estan en estado pendiente.'}
  end
  def borrar_usuario_camarografo_task
    @msg=""
    ##ids=[343,344]
    ids= [36738,36745,36751,36737,36757,36766,36739,36740,36741,36742,36743,36749,36750,36753,36755,36756,36758,36759,36760,36761,36763,36764,36765,36754,36747,36748,36746,36744,36752,36762,36767]
      ids.each do |pid|
        @msg+= "Borrando camarografo\n"
        p = Persona.find(pid) rescue nil
  
        PersonaRol.where(persona_id: pid).delete_all
        ##Video.where(observador_id: Persona.find(354).observador.id).delete_all
        if !p.nil?
          if !p.observador.nil?
            Video.where(observador_id: Persona.find(pid).observador.id).each do |v|
              v.observador_id=nil
              v.save
            end
          end
        end
        Persona.find(pid).delete if !p.nil?
        ##Deberia ser solo una fila de observador asi que podria usarse .where().first.delete
        Observador.where(persona_id: pid).delete_all
      end
      @msg+="Ejecuto el codigo del task!"
  end
  def borrar_usuario_profesor_task
    ##ids= [356]
    @msg=""
    ids= [36701,1,36654,36628,36629,36633,36637,36641,36644,36646,36650,36652,36655,36659,36667,36669,36671,36673,36675,36632,36634,36636,36640,36642,36648,36649,36651,36660,36663,36670,36672,36674,36664,36638,36666,36653,36680,36681,36682,36684,36686,36688,36690,36692,36695,36696,36698,36700,36702,36706,36656,36676,36665,36631,36627,36658,36647,36678,36679,36683,36693,36694,36703,36705,36685,36697,36643,36691,36699,36668,36662,36645,36639,36657,36661,36687,36704,36630,36635,36689,2]
      ids.each do |pid|
        @msg+= "Borrando profesor"
        p = Persona.find(pid) rescue nil
  
        PersonaRol.where(persona_id: pid).delete_all
        ##Video.where(observador_id: Persona.find(354).observador.id).delete_all
        if !p.nil?
          if !p.profesor.nil?
            ##Video.where(profesor_id: p.profesor.id).delete_all
            videos=Video.where(profesor_id: p.profesor.id)
            videos.each do |v|
              Evaluacion.where(video_id: v.id).delete_all
            end
            videos.delete_all
          end
        end
        Persona.find(pid).delete if !p.nil?
        Profesor.where(persona_id: pid).delete_all
        Reporte.where(persona_id: pid).delete_all
      end
     @msg+="Ejecuto el codigo del task!"
  end
  def borrar_evaluacion_respuesta
    EvaluacionRespuesta.all.delete_all
    @msg="Ejecuto borrar_evaluacion_respuesta"
  end
  ##Sirve para devolver los usuarios videos que estaban en evaluacion al proceso de revisor
  def videos_eval_rev
    @msg=""
    rev_id = Persona.revisores.first.id
    ##videos=Video.last(2)
    videos=Video.where(identidad_verificada: true,conversion_status: "COMPLETED")
    videos.each do |v|
      @msg += "itero en el each"
      RevisorVideo.create(video_id: v.id, revisor_id: rev_id, aprobado: nil, estado: 1)
      Evaluacion.where(video_id: v.id).delete_all
    end
    @msg+="Ejecuto videos_eval_rev"
  end
  def profesores
  end

  def prueba_archivo
    puts "hola"
    @archivo = ArchivosPersona.first
  end
  
  private
  
  def post_params
    params.require(:post).permit(:Archivo)
  end
  def revision_params
    params.require(:revision).permit(:revision_id)
  end
  


end
