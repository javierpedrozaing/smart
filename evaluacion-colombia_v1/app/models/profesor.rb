class Profesor < ActiveRecord::Base

  belongs_to :estado
  belongs_to :persona
  belongs_to :secretarias_educacion
  belongs_to :secciones_educativa
  has_and_belongs_to_many :observadores, foreign_key: "observador_id"
  has_many :evaluaciones
  has_one :video
  belongs_to :materia
  belongs_to :nivel
  belongs_to :cargo
  belongs_to :institucion
  belongs_to :TipoGrabacion
  belongs_to :sede
  belongs_to :departamento
  belongs_to :municipio
  has_one :evidencia_form
  has_one :autoevaluacion
  
end
