class AddJustificacionToAutoevaluacionRespuestas < ActiveRecord::Migration
  def change
    add_column :autoevaluacion_respuestas, :justificacion, :string, limit: 1000
  end
end
