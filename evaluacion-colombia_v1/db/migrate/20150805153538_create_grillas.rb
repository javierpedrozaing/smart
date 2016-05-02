class CreateGrillas < ActiveRecord::Migration
  def change
    create_table :grillas do |t|
      t.references :materia, index: true, foreign_key: true
      t.integer :seccion_educativa_id, index: true
      t.string :grilla

      t.timestamps null: false
    end
  end
end
