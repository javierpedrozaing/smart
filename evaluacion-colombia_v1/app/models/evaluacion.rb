class Evaluacion < ActiveRecord::Base
  belongs_to :evaluador
  belongs_to :profesor
  belongs_to :estado_evaluacion
  has_one :video, foreign_key: :video_id
  has_many :evaluacion_respuesta

  
  #evaluaciones por evaluador trae infomación personas
  scope :evaluaciones, -> {self.joins(:evaluador=>:persona)}

  scope :sin_evaluador, -> {where(evaluador_id: nil)}
  scope :con_evaluador, -> {where.not(evaluador_id: nil)}

  scope :terminadas, -> { where(estado_evaluacion_id: EstadoEvaluacion.terminada.ids) }
  scope :pendientes, -> { where(estado_evaluacion_id: EstadoEvaluacion.pendiente.ids) }
  scope :procesando, -> { where(estado_evaluacion_id: EstadoEvaluacion.procesando.ids) }
  
  scope :sin_completar, -> { where(estado_evaluacion_id: EstadoEvaluacion.sin_completar.ids) }
  scope :asignadas, -> (arr_evaluadores_id) { where(evaluador_id: arr_evaluadores_id) }

  attr_accessor :skip_valor
  
  validates :valor, presence: {message: 'Debe elegir un valor.'}, unless: :skip_valor

  # Una evaluación se crea desde una grilla, luego con la grilla se genera
  # una lista de respuestas y dichas respuestas se asocian a la evaluación
  #def self.generar_evaluacion video_id, grilla_id, skip_valor, departamento_ids, coordinador = nil, skip_evaluador = nil
  def self.generar_evaluacion video_id, grilla_id, skip_valor, region_ids, coordinador = nil, skip_evaluador = nil
    eval = Evaluacion.new(skip_valor: skip_valor)
    video = Video.find(video_id)
    grilla = Grilla.find(grilla_id)
    
    # eval.profesor_id = profesor_id
    eval.profesor_id = video.profesor_id
    eval.video_id = video_id
    ultimo_nivel=video.profesor.evidencia_form.ultimo_nivel_educativo
    
    #ULTIMO NIVEL EDUCATIVO
    nivel_id = NivelPar.where(nombre: ultimo_nivel).pluck(:id).first
    
    #NIVEL DE ENSEÑANZA
    nivel_en_id = video.profesor.nivel_id
    
    #AREA
    materia_id = video.profesor.materia_id
    
    if skip_evaluador.nil?
      #p.evidencia_form.ultimo_nivel_educativo
      #eval.evaluador_id = Evaluador.asignar_evaluador(departamento_ids,video.profesor.cargo_id,video.profesor.nivel_id) if coordinador.nil?
      #eval.evaluador_id = Evaluador.asignar_evaluador(region_ids,video.profesor.cargo_id,video.profesor.nivel_id) if coordinador.nil?
      #este fue el que momentarie jason eval.evaluador_id = Evaluador.asignar_evaluador(region_ids,video.profesor.cargo_id,nivel_id,nivel_en_id,materia_id) if coordinador.nil?
      eval.evaluador_id =nil#la incorpore jeyson
    else
      eval.evaluador_id =nil#la incorpore jeyson
      #este fue el que momentarie jason eval.evaluador_id = Evaluador.asignar_evaluador(region_ids,video.profesor.cargo_id,nivel_id,nivel_en_id,materia_id,skip_evaluador) if coordinador.nil?
    end
    
    eval.orden = 0
    if eval.save
      CoordinadorEvaluacion.create(evaluacion_id: eval.id, coordinador_id: coordinador.id) if !coordinador.nil?
      
      items = Grilla.itemsOrdenados(grilla_id)
      # grilla.grilla_item.each do | item |
      items.each do |item|
        EvaluacionRespuesta.create( evaluacion: eval, grilla_item: item) unless item.categoria.codigo == "ACD" or item.categoria.codigo == "ACE"
      end
      # En el caso de las actividades se crean 10 respuestas, una por actividad
      10.times do |i|
        items.each do |item|
          if item.categoria.codigo == "ACD"
            EvaluacionRespuesta.create( evaluacion: eval, grilla_item: item, numero_actividad: i+1)
          end
        end
      end
      10.times do |i|
        items.each do |item|
          if item.categoria.codigo == "ACE"
            EvaluacionRespuesta.create( evaluacion: eval, grilla_item: item, numero_actividad: i+1)
          end
        end
      end
       #crea los campos obigatorios para contestar la grilla se incorpora a final de marzo del 2016 para cubrir requerimiento de actividades obligatorias
        EvaluacionRespuesta.where(evaluacion_id: eval.id, numero_actividad:[nil,1,2,3,4]).update_all(actividad_obligatoria:1)
      if eval.evaluador_id.nil?
        return nil
      else
        return eval.evaluador_id
      end
    end
     
  end
end
