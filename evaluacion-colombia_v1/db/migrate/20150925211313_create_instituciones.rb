class CreateInstituciones < ActiveRecord::Migration
  def change
    create_table :instituciones do |t|
      t.string :nombre
      t.integer :codigo
      t.integer :municipio_id
      t.integer :secretaria_id
      t.string :sector
      t.string :zona

      t.timestamps null: false
    end
    add_index :instituciones, :municipio_id
    add_index :instituciones, :secretaria_id
    add_index :instituciones, :sector
    add_index :instituciones, :zona
  end
end
