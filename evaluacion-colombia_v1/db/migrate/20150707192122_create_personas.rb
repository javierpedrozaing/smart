class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.string :nombre
      t.string :apellido_paterno
      t.string :apellido_materno
      t.integer :tipo_documento_id
      t.string :documento
      t.string :direccion
      t.string :telefono
      t.string :celular
      t.string :email

      t.timestamps null: false
    end
    
    add_index :personas, :email
    add_index :personas, :tipo_documento_id
    add_index :personas, :documento
  end
end
