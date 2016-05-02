class Municipio < ActiveRecord::Base
  belongs_to :departamento
  has_many :instituciones
  has_many :profesores
end
