class CoordinadorEvaluacion < ActiveRecord::Base
  belongs_to :coordinador
  belongs_to :evaluacion
end
