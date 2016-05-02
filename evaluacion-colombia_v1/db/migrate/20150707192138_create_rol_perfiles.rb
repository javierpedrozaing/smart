class CreateRolPerfiles < ActiveRecord::Migration
  def change
    create_table :rol_perfiles do |t|
      t.integer :rol_id
      t.integer :perfil_id

      t.timestamps null: false
    end
    add_index :rol_perfiles, :rol_id
    add_index :rol_perfiles, :perfil_id
  end
end
