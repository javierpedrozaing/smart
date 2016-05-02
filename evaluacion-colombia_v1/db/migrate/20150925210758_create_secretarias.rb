class CreateSecretarias < ActiveRecord::Migration
  def change
    create_table :secretarias do |t|
      t.string :nombre
      t.integer :departamento_id

      t.timestamps null: false
    end
    add_index :secretarias, :nombre
    add_index :secretarias, :departamento_id
  end
end
