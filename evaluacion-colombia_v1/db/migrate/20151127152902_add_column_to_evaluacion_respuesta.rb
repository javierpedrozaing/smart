class AddColumnToEvaluacionRespuesta < ActiveRecord::Migration
  def change
    add_column :evaluacion_respuestas, :numero_actividad, :integer
  end
end
