class EstadisticasController < ApplicationController
  before_action :authenticate_persona!
  require 'csv'

  def admin_evaluadores
    @evaluador = Evaluador.first
    @evaluadores = Evaluador.all
    @total = Evaluacion.count
    @en_proceso = Evaluacion.where("estado_evaluacion_id = 2").count
    @terminadas = Evaluacion.where("estado_evaluacion_id = 3").count
    @reportes = Reporte.all
    #@total = Evaluacion.where("evaluador_id = ?", @evaluador.id).count
    #@terminadas = Evaluacion.where("evaluador_id = ? AND estado_evaluacion_id = 3", @evaluador.id).count
  end
  
  
  #Tipo documento
  #documento
  #nip
  #nombre
  #apellidos
  #codigo_cargo
  #nombre_cargo
  #codigo_sub_cargo
  #nombre_sub_cargo
  #codigo_nivel
  #nombre_nivel
  #codigo_sub_nivel
  #nombre_sub_nivel
  #codigo_area
  #nombre_area
  #departamento
  #municipio
  #codigo_sede
  #nombre_sede
  #codigo_institucion
  #nombre_institucion
  #Secretaria
  #tipo_grabacion
  #direccion
  #telefono
  #celular
  #correo_electronico
  #Fecha_inscripción
  #Fecha_actualización
  def admin_evaluados_csv
      ##@profesores = Profesor.all.limit(100)
      ##aux = Profesor.all
      aux = Profesor.includes(:persona).all
      ##@profesores = Profesor.includes(:persona).all
      output = Array.new
      aux.each do |prof|
          if prof.persona && prof.estado 
            ##output.push([prof.persona.documento, prof.estado.estado])
            p=prof.persona
            output.push([p.tipo_documento.documento, p.documento,p.nombre,p.apellido_paterno.nil? ? "NULL": p.apellido_paterno,p.apellido_materno.nil? ? "NULL": p.apellido_materno,prof.materia.nil? ? "NULL": prof.materia_id,prof.materia.nil? ? "NULL": prof.materia.materia,prof.sede.nil? ? "NULL": prof.sede.codigo,prof.sede.nil? ? "NULL": prof.sede.nombre,prof.institucion.nil? ? "NULL": prof.institucion.codigo,prof.institucion.nil? ? "NULL": prof.institucion.nombre, prof.tipo_grabacion_id.nil? ? "NULL": prof.tipo_grabacion_id, p.direccion.nil? ? "NULL": p.direccion,p.telefono.nil? ? "NULL": p.telefono,p.celular.nil? ? "NULL": p.celular,p.email.nil? ? "NULL": p.email,p.created_at.strftime("%F"),p.updated_at.strftime("%F"),prof.estado.estado])
          end
        end
        ##puts output.first(100)
        @profesores = output
      
    respond_to do |format|
        format.html
        format.csv do
          headers["Cache-Control"] ||= "no-cache"
          headers['Content-Disposition'] = "attachment; filename=\"Evaluados-data.csv\""
          headers['Content-Type'] ||= 'text/csv'
        end
      end
  end
  def admin_evaluados
    #vid_ids=Evaluacion.where("estado_evaluacion_id  ").distinct.pluck("video_id")
    #Video.find(vid_ids)
    ##videos_en_cola = Videos.all.map{|v| }
    ##videos_revisados
    
    @videos_cargados = Video.where(:conversion_status => "COMPLETED").
                       where.not(:id=>[22296,22297,22316,22325,22298,22299,22300,22301,22302,22304,22308,22309,22310,22312,
                                       22314,22315,22317,22318,22319,22320,22322,22323,22324,22313,22306,22307,22305,22303,  
                                       22311,22321,22220,22222,22224,22230,22231,22233,22236,22238,22244,22245,22249,22252,
                                       22255,22256,22259,22261,22221,22260,22235,22257,22229,22239,22264,22226,22237,22223,  
                                       22228,22234,22327,22328,22329,22330,22331,22263,22262,22227,22232,22253,22258,22243,  
                                       22251,22246,22250,22248,22242,22254,22240,22225,22241,22247]).count
    ##videos_evaluados
    ##.valor
    ##A=Evaluacion.where(video_id: v.id, estado_evaluacion_id: [1,2]).count
    ##B=Evaluacion.where(video_id: v.id).count
    ##C=Reporte.where(video_id: v.id).count y revisado =false
    ##if A==B && C==0
    ##videos_evaluados +1
    ##en un for each de videos
    
    ##A=Evaluacion.where(video_id: v.id, estado_evaluacion_id: [1,2]).count
    ##C=Reporte.where(video_id: v.id).count y revisado =false
    ##if A==0 && C==0
    @evaluaciones_finalizadas = Evaluacion.where("estado_evaluacion_id = 3").count
    #@videos_reportados = Video.where.not(reporte_id: nil).count
    @videos_reportados = Reporte.all.select("count(DISTINCT video_id) as total")
  end
  def jefe_camarografos                
    @canales = CanalRegional.all
  end
   def jefe_camarografos_totales
      canal=params[:id]
      @total_faltantes= [Video.joins(:observador).where('observadores.canal_regional_id'=>canal,:conversion_status=>nil).where.not(
                                      :id=>[22296,22297,22316,22325,22298,22299,22300,22301,22302,22304,22308,22309,22310,22312,
                                       22314,22315,22317,22318,22319,22320,22322,22323,22324,22313,22306,22307,22305,22303,  
                                       22311,22321,22220,22222,22224,22230,22231,22233,22236,22238,22244,22245,22249,22252,
                                       22255,22256,22259,22261,22221,22260,22235,22257,22229,22239,22264,22226,22237,22223,  
                                       22228,22234,22327,22328,22329,22330,22331,22263,22262,22227,22232,22253,22258,22243,  
                                       22251,22246,22250,22248,22242,22254,22240,22225,22241,22247]).count,
                         RevisorVideo.joins(:video).where(:video_id=>Video.joins(:observador).where('observadores.canal_regional_id'=>canal,:conversion_status => "COMPLETED"),:estado=>3).count,
                         Video.joins(:observador).where('observadores.canal_regional_id'=>canal,:conversion_status => "COMPLETED").where.not(
                                      :id=>[22296,22297,22316,22325,22298,22299,22300,22301,22302,22304,22308,22309,22310,22312,
                                       22314,22315,22317,22318,22319,22320,22322,22323,22324,22313,22306,22307,22305,22303,  
                                       22311,22321,22220,22222,22224,22230,22231,22233,22236,22238,22244,22245,22249,22252,
                                       22255,22256,22259,22261,22221,22260,22235,22257,22229,22239,22264,22226,22237,22223,  
                                       22228,22234,22327,22328,22329,22330,22331,22263,22262,22227,22232,22253,22258,22243,  
                                       22251,22246,22250,22248,22242,22254,22240,22225,22241,22247]).count]
 
                          
       respond_to do |format|
       format.js {}
    end                       
  end
end
