class CreateGrillaAutoevaluaciones < ActiveRecord::Migration
  def change
    create_table :grilla_autoevaluaciones do |t|
      t.references :grilla, index: true, foreign_key: true
      t.string :codigo_item, limit: 10
      t.integer :posicion
      t.references :escalas, index: true, foreign_key: true
      t.string :instruccion, limit: 1000
      t.string :rv, limit: 255

      t.timestamps null: false
    end
  end
end
