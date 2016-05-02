class RemoveIndexAutoevaluacionRespuesta < ActiveRecord::Migration
  def change    
    remove_index :autoevaluacion_respuestas, :column =>:autoevaluacion_id
  end
end
