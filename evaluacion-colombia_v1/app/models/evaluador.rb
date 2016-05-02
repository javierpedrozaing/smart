class Evaluador < ActiveRecord::Base
  belongs_to :estado
  belongs_to :persona, class_name: "Persona", foreign_key: "persona_id"
  has_many :evaluaciones
  has_many :coordinador_evaluadores
  has_many :coordinadores, through: :coordinador_evaluadores
  belongs_to :cargo, foreign_key: "cargo_id"
  has_one :grados_academico, foreign_key: "grados_academico_id"
  #has_many :materias_evaluadores
  #has_many :materias, through: :materias_evaluadores
  has_many :evaluador_secciones
  belongs_to :nivelpar, class_name: "NivelPar", foreign_key: "nivelpar_id"
  has_many :secciones_educativas, through: :evaluador_secciones
  belongs_to :secretarias_educacion, foreign_key: :secretarias_educacion_id
  delegate :region, to: :secretarias_educacion, allow_nil: true
  belongs_to :departamento, class_name: "Departamento", foreign_key: "departamento_id"
  belongs_to :nivel
  belongs_to :materia
  # Retorna el :id de un evaluador para asignarlo a una evaluacion
  # de manera automatica
  #   Evaluador.asignar_evaluador # => :id
#def self.asignar_evaluador(departamento_ids,cargo_id,nivel_id,skip_evaluador = nil)
  
  def self.asignar_evaluador(region_ids,cargo_id,nivel_id,nivel_en_id,materia_id,skip_evaluador = nil)
    array = []
    Evaluador.uncached do
      r=NivelPar.find(nivel_id).rango
      #array = Evaluador.where(departamento_id: departamento_ids, cargo_id: cargo_id,nivel_id: nivel_id).where.not(id: skip_evaluador).map{|e| [e.id, e.evaluaciones.count, e.evaluaciones_pendientes+e.evaluaciones_en_proceso]}
      j = Evaluador.joins(departamento: :region).where(regiones: {id: region_ids}).where(cargo_id: cargo_id)
      aux_map = j.map{|e| [e.id, e.evaluaciones.count, e.evaluaciones_pendientes+e.evaluaciones_en_proceso]}
      aux_map =aux_map.select {|e| e.third < 2}
      ids=aux_map.map(&:first)
      j = j.where(id: ids)

        if j.blank?
        j=Evaluador.where(cargo_id: cargo_id)
      end
      j = j.includes(:nivelpar).where('nivel_pares.rango >= ?',r).references(:nivelpar)
      j = j.where.not(id: skip_evaluador)
      if j.blank?
        j=Evaluador.where(cargo_id: cargo_id)
        j = j.includes(:nivelpar).where('nivel_pares.rango >= ?',r).references(:nivelpar)
        j = j.where.not(id: skip_evaluador)
        if j.blank?
          return nil
        end
      end
      aux_pre = j
      aux_nivel_en = j.where(nivel_id: nivel_en_id)
      if !aux_nivel_en.blank?
        j=aux_nivel_en
      end
      aux_materia = j.where(materia_id: materia_id)
      if !aux_materia.blank?
        j=aux_materia
      end
      
      array = j.map{|e| [e.id, e.evaluaciones.count, e.evaluaciones_pendientes+e.evaluaciones_en_proceso]}
      #array = Evaluador.joins(departamento: :region).where(regiones: {id: region_ids}).where(cargo_id: cargo_id,nivel_id: nivel_id).where.not(id: skip_evaluador).map{|e| [e.id, e.evaluaciones.count, e.evaluaciones_pendientes+e.evaluaciones_en_proceso]}
      array = array.select {|e| e.third < 2}
      if array.blank?
        array =aux_pre.map{|e| [e.id, e.evaluaciones.count, e.evaluaciones_pendientes+e.evaluaciones_en_proceso]}
          array = array.select {|e| e.third < 2}
      end
        array = array.sort_by{|e| e.second}
    end
    
    
    return array.first.first if !array.first.nil?

=begin
    Evaluador.uncached do
      array = Evaluador.joins(departamento: :region).where(regiones: {id: region_ids}).where(cargo_id: cargo_id).where.not(id: skip_evaluador).map{|e| [e.id, e.evaluaciones.count, e.evaluaciones_pendientes+e.evaluaciones_en_proceso]}
      array = array.select {|e| e.third < 2}
      array = array.sort_by{|e| e.second}
    end
=end
    return nil if array.first.nil?

    return array.first.first
  end

  def evaluaciones_terminadas
    Evaluacion.where("evaluador_id = ? AND estado_evaluacion_id = 3", self.id).count
  end
  def evaluaciones_en_proceso
    Evaluacion.where("evaluador_id = ? AND estado_evaluacion_id = 2", self.id).count
  end
  
  def evaluaciones_pendientes
    Evaluacion.where("evaluador_id = ? AND estado_evaluacion_id = 1", self.id).count
  end
end
