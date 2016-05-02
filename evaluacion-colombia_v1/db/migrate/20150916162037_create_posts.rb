class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :titulo
      t.text :cuerpo
      t.boolean :visible
      t.integer :usuario_id
      t.string :imagen
      t.string :descripcion

      t.timestamps null: false
    end
  end
end
