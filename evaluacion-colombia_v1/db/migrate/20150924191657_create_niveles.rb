class CreateNiveles < ActiveRecord::Migration
  def change
    create_table :niveles do |t|
      t.string :nombre
      t.integer :nivel_id

      t.timestamps null: false
    end
    add_index :niveles, :nivel_id
  end
end
