class CreatePersonaRoles < ActiveRecord::Migration
  def change
    create_table :persona_roles do |t|
      t.integer :persona_id
      t.integer :rol_id

      t.timestamps null: false
    end
    add_index :persona_roles, :persona_id
    add_index :persona_roles, :rol_id
  end
end
