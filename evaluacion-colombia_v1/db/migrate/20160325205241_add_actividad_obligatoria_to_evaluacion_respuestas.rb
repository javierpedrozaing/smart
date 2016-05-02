class AddActividadObligatoriaToEvaluacionRespuestas < ActiveRecord::Migration
  def change
    add_column :evaluacion_respuestas, :actividad_obligatoria, :string
  end
end
