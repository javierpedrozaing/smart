class CreateProfesores < ActiveRecord::Migration
  def change
    create_table :profesores do |t|
      t.references :estado, index: true, foreign_key: true
      t.references :persona, index: true, foreign_key: true
      t.references :secretarias_educacion, index: true, foreign_key: true
      t.references :secciones_educativa, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
