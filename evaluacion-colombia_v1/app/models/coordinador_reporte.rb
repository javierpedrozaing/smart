class CoordinadorReporte < ActiveRecord::Base
  belongs_to :evaluacion
  belongs_to :coordinador
  belongs_to :reporte
end
