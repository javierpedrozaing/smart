class CreateSedes < ActiveRecord::Migration
  def change
    create_table :sedes do |t|
      t.string :nombre
      t.integer :codigo
      t.integer :institucion_id
      t.integer :municipio_id

      t.timestamps null: false
    end
    add_index :sedes, :nombre
    add_index :sedes, :institucion_id
  end
end
