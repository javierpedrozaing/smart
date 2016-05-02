class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nombre
      t.integer :persona_id

      t.timestamps null: false
    end
    add_index :usuarios, :persona_id
  end
end
