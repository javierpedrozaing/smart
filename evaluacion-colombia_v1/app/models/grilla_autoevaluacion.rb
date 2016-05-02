class GrillaAutoevaluacion < ActiveRecord::Base
  belongs_to :grilla
  belongs_to :escalas
  has_one    :autoevaluacion_respuesta
end
