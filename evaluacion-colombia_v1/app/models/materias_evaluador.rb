class MateriasEvaluador < ActiveRecord::Base
  belongs_to :evaluador
  belongs_to :materia
end