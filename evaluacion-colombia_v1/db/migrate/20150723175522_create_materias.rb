class CreateMaterias < ActiveRecord::Migration
  def change
    create_table :materias do |t|
      t.integer :secciones_educativas_id, index: true
      t.string :materia

      t.timestamps null: false
    end
  end
end
