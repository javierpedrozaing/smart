class Coordinador < ActiveRecord::Base
  belongs_to :estado
  belongs_to :persona
  belongs_to :grado_academico
  has_many :coordinador_evaluadores
  has_many :coordinador_evaluaciones
  has_many :coordinador_reportes
  has_many :evaluadores, through: :coordinador_evaluadores
  has_many :evaluaciones, through: :coordinador_evaluaciones
  has_many :materias_coordinadores
  has_many :materias, through: :materias_coordinadores
  
  def self.asignar_coordinador
    Coordinador.includes(:coordinador_evaluaciones).select('coordinadores.*, count(*) as cantidad_evaluaciones').group(:id).order("cantidad_evaluaciones asc").first
  end
  
  def self.asignar_coordinador_reporte
    Coordinador.includes(:coordinador_reportes).select('coordinadores.*, count(*) as cantidad_reportes').group(:id).order("cantidad_reportes asc").first
  end
end
