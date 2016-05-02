class AddMateriaToEvaluador < ActiveRecord::Migration
  def change
    add_column :evaluadores, :materia_id, :integer
    add_index :evaluadores, :materia_id
  end
end
