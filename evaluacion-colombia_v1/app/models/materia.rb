class Materia < ActiveRecord::Base
  belongs_to :secciones_educativas
  has_many :materias_evaluadores
  #has_many :evaluadores, through: :materias_evaluadores
  has_many :evaluadores
  has_many :coordinadores, through: :materias_coordinadores
  has_many :profesores
end
