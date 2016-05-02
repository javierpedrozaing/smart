class GradosAcademico < ActiveRecord::Base
  has_many :evaluadores
  has_many :coordinadores
  has_many :profesores
end
