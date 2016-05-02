class RenameColumn < ActiveRecord::Migration
  def change
    #rename_column :grillas ,:materia_id ,:cargo_id 
    remove_index  :grillas, :column =>:seccion_educativa_id 
    rename_column :grillas ,:seccion_educativa_id ,:tipo_grilla     
  end
end
