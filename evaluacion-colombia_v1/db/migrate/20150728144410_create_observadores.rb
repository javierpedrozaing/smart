class CreateObservadores < ActiveRecord::Migration
  def change
    create_table :observadores do |t|
      t.references :estado, index: true, foreign_key: true
      t.references :persona, index: true, foreign_key: true
      t.references :canal_regional, index: true, foreign_key: true
      

      t.timestamps null: false
    end
  end
end
