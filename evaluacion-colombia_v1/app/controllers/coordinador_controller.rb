class CoordinadorController < ApplicationController
  before_action :authenticate_persona!
  def index
       #Validar ip para centros de evaluacion autorizados
     if  HostPermitido.where(host: request.remote_ip).blank?
         reset_session
         redirect_to :authenticated_root, :flash => { error: 'No se encuentra en su lugar de trabajo.'}
     end 
=begin
    # Evaluadores
    @total_evaluadores = current_persona.coordinador.evaluadores.count
    
    # Evaluaciones que se estan desarrollando
    @total_procesando = Evaluacion.procesando.asignadas(current_persona.coordinador.evaluadores.map{ |x| x.id}).count
    @procesando = Evaluacion.procesando.asignadas(current_persona.coordinador.evaluadores.map{ |x| x.id})
    # Evaluaciones terminadas
    @total_terminadas = Evaluacion.terminadas.asignadas(current_persona.coordinador.evaluadores.map{ |x| x.id}).count
    @terminadas = Evaluacion.terminadas.asignadas(current_persona.coordinador.evaluadores.map{ |x| x.id})
    # Evaluaciones pendientes
    @total_pendientes = Evaluacion.pendientes.asignadas(current_persona.coordinador.evaluadores.map{ |x| x.id}).count
    @pendientes = Evaluacion.pendientes.asignadas(current_persona.coordinador.evaluadores.map{ |x| x.id})
=end

    coordinador = current_persona.coordinador

    @evaluadores = coordinador.evaluadores.map { |x| x.persona }
    
    @videos_reportados = CoordinadorReporte.includes(reporte: [:video, :tipos_reporte, :persona]).where(coordinador_id: coordinador.id, reportes: { revisado: false, tercer_evaluador: false }).to_a.group_by{ |cr| cr.reporte.video }

    @pendientes = coordinador.evaluaciones.pendientes.count
    @en_proceso = coordinador.evaluaciones.procesando.count
    @terminadas = coordinador.evaluaciones.terminadas.count
  end

  def evaluadores
    @total_evaluadores = current_persona.coordinador.evaluadores.count
    @evaluadores = current_persona.coordinador.evaluadores
  end
  
  def reasignar
    coordinador = current_persona.coordinador
    coordinador_reportes = CoordinadorReporte.includes(:reporte).where(coordinador_id: coordinador.id, reportes: { video_id: params[:video_id], revisado: false, tercer_evaluador: false })

    ##coordinador_reportes.each do |cr|
    ##  cr.reporte.revisado = true
    ##  cr.reporte.save
    ##end
    
    evaluacion_reportada = coordinador_reportes.first.evaluacion
    profesor = evaluacion_reportada.profesor
    ##ids de evaluadores a omitir en la reasignación
    skip_ev_ids = Evaluacion.where(video_id: evaluacion_reportada.video_id).pluck(:evaluador_id)
    evg = nil
    
    coordinador_reportes.group_by{ |cr| cr.evaluacion_id }.each do |evaluacion_id, cr|
      evaluacion = Evaluacion.find(evaluacion_id)
      evaluador = evaluacion.evaluador
      ##Revisar si dejar la evaluación vieja no genera ningun problema con la condición de una evaluación de par
      ##terminada, si genera, habría que ponerle un flag o algo a la evaluación, para ignorarla al moemento de checkear
      ##esa condición
      
      #Evaluacion.generar_evaluacion(@revision.video.id, 1,true, [@revision.video.profesor.departamento.region.id, nil])
      #Evaluacion.generar_evaluacion(@revision.video.id, 1,true, Region.all.to_a.map{ |r| r.id }.reject{ |r_id| r_id == @revision.video.profesor.departamento.region.id}.append(nil))
                  
      departamentos_id = evaluador.departamento.region.id == profesor.departamento.region.id ? [profesor.departamento.region.id, nil] : Region.all.to_a.map{ |r| r.id }.reject{ |r_id| r_id == profesor.departamento.region.id}.append(nil)
      evg=Evaluacion.generar_evaluacion(params[:video_id], 1, true, departamentos_id, nil,skip_ev_ids)

    end
    if !evg.nil?
      coordinador_reportes = CoordinadorReporte.includes(:reporte).where(coordinador_id: coordinador.id, reportes: { video_id: params[:video_id], revisado: false, tercer_evaluador: false })
  
      coordinador_reportes.each do |cr|
        cr.reporte.revisado = true
        cr.reporte.save
      end
      redirect_to coordinador_path, notice: "El video fue reasignado con éxito"
    else
      redirect_to coordinador_path, notice: "El video no fue reasignado con éxito ya que no se encontro un par evaluador apropiado para la evaluación, se creo la evaluación sin evaluador asociado"
    end
  end
end
