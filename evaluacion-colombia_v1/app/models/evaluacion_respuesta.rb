class EvaluacionRespuesta < ActiveRecord::Base
  belongs_to :evaluacion
  belongs_to :grilla_item

  validates :evaluacion_id, :presence => true
  validates :grilla_item, :presence => true


  def self.byEvaluacion(evaluacion)
    EvaluacionRespuesta.where(evaluacion_id: evaluacion.id)
  end
end
