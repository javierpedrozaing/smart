class CreateIcfesRegistros < ActiveRecord::Migration
  def change
    create_table :icfes_registros do |t|
      t.string :pin
      t.integer :persona_id

      t.timestamps null: false
    end
    add_index :icfes_registros, :pin
    add_index :icfes_registros, :persona_id
  end
end
