class CoordinadorEvaluador < ActiveRecord::Base
  belongs_to :evaluador
  belongs_to :coordinador
end
