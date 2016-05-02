class EvaluadorSeccion < ActiveRecord::Base
  belongs_to :evaluador
  belongs_to :secciones_educativa
end