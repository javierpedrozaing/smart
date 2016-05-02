class CreateCoordinadorEvaluadores < ActiveRecord::Migration
  def change
    create_table :coordinador_evaluadores do |t|
      t.integer :evaluador_id
      t.integer :coordinador_id

      t.timestamps null: false
    end
    add_index :coordinador_evaluadores, :evaluador_id
    add_index :coordinador_evaluadores, :coordinador_id
  end
end
