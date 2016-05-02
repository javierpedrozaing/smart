class Institucion < ActiveRecord::Base
  belongs_to :municipio
  belongs_to :secretaria
  has_many :sedes
end
