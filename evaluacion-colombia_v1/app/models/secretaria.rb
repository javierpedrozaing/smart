class Secretaria < ActiveRecord::Base
  belongs_to :departamento
  has_many :instituciones
end
