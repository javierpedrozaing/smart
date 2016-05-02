class RemoveJustificacionFromAutoevaluacionRespuestas < ActiveRecord::Migration
  def change          	     
     remove_column :autoevaluacion_respuestas , :justificacion, :string   
  end
end
