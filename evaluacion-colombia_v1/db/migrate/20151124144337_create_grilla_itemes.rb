class CreateGrillaItemes < ActiveRecord::Migration
  def change
    create_table :grilla_itemes do |t|
      t.references :grilla, index: true, foreign_key: true
      t.string :cod_item
      t.references :categoria, index: true, foreign_key: true
      t.string :cod_dimension
      t.string :cod_sub_dimension
      t.string :cod_afirmacion
      t.string :cod_evidencia
      t.string :item
      t.string :escala
      t.integer :orden_item
      t.string :ejemplos

      t.timestamps null: false
    end
  end
end
