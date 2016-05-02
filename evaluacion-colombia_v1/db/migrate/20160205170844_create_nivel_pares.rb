class CreateNivelPares < ActiveRecord::Migration
  def change
    create_table :nivel_pares do |t|
      t.string :nombre
      t.integer :rango

      t.timestamps null: false
    end
  end
end
