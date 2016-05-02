class AddRegistroEnviadoToAutoevaluacionRespuestas < ActiveRecord::Migration
  def change
    add_column :autoevaluacion_respuestas, :registro_enviado, :integer, limit: 2
    add_column :autoevaluacion_respuestas, :registro_obligatorio, :integer, limit: 2
  end
end
