class Nivel < ActiveRecord::Base
  belongs_to :nivel
  has_many :niveles
  has_many :profesores
  has_many :evaluadores
end
