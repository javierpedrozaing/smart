class RemoveIndex < ActiveRecord::Migration
  def change
    remove_index :autoevaluaciones, :column =>:periodo_grilla_id
   
  end
end
