class CreateEvaluadores < ActiveRecord::Migration
  def change
    create_table :evaluadores do |t|
      t.references :estado, index: true, foreign_key: true
      t.references :persona, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
