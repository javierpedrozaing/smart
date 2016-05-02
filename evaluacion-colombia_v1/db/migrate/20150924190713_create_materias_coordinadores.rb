class CreateMateriasCoordinadores < ActiveRecord::Migration
  def change
    create_table :materias_coordinadores do |t|
      t.integer :coordinador_id
      t.integer :materia_id

      t.timestamps null: false
    end
    add_index :materias_coordinadores, :coordinador_id
    add_index :materias_coordinadores, :materia_id
  end
end
