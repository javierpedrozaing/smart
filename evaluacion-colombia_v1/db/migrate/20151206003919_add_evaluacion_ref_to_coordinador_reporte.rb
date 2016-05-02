class AddEvaluacionRefToCoordinadorReporte < ActiveRecord::Migration
  def change
    add_reference :coordinador_reportes, :evaluacion, index: true, foreign_key: true
  end
end
