class CreateAutoevaluaciones < ActiveRecord::Migration
  def change
    create_table :autoevaluaciones do |t|
      t.references :profesor, index: {:unique=>true}, foreign_key: true
      t.references :periodo_grilla, index: {:unique=>true}, foreign_key: true

      t.timestamps null: false
    end
  end
end
