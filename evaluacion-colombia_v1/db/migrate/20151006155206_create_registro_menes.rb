class CreateRegistroMenes < ActiveRecord::Migration
  def change
    create_table :registro_menes do |t|
      t.integer :tipo_documento_id
      t.string :documento

      t.timestamps null: false
    end
  end
end
