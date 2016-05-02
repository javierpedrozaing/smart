class RenameColumnGrillaAutoevaluacionEscalaId < ActiveRecord::Migration
  def change
    rename_column :grilla_autoevaluaciones ,:escalas_id ,:escala_id 
  end
end
