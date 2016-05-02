class Departamento < ActiveRecord::Base
  has_many :municipios
  has_many :secretarias
  has_many :profesores
  has_many :evaluadores
  belongs_to :region
end
