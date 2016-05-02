class CreateTipoGrabaciones < ActiveRecord::Migration
  def change
    create_table :tipo_grabaciones do |t|
      t.string :nombre

      t.timestamps null: false
    end
    add_index :tipo_grabaciones, :nombre
  end
end
