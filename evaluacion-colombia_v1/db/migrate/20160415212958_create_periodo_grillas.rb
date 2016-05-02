class CreatePeriodoGrillas < ActiveRecord::Migration
  def change
    create_table :periodo_grillas do |t|
      t.integer :periodo
      t.references :grilla, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
