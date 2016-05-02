class CreateValorEscalas < ActiveRecord::Migration
  def change
    create_table :valor_escalas do |t|
      t.references :escalas, index: {:unique=>true}, foreign_key: true
      t.string :valor, limit: 30
      t.string :letra, limit: 1
      t.integer :orden

      t.timestamps null: false
    end
    add_index :valor_escalas, :valor, unique: true
  end
end
