class CreateMunicipios < ActiveRecord::Migration
  def change
    create_table :municipios do |t|
      t.string :nombre
      t.integer :departamento_id

      t.timestamps null: false
    end
    add_index :municipios, :nombre
    add_index :municipios, :departamento_id
  end
end
