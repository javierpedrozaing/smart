class CreateHostPermitidos < ActiveRecord::Migration
  def change
    create_table :host_permitidos do |t|
      t.string :host, limit: 20
      t.string :descripcion

      t.timestamps null: false
    end
    add_index :host_permitidos, :host, unique: true
  end
end
