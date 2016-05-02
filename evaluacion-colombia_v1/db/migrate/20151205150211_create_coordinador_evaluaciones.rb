class CreateCoordinadorEvaluaciones < ActiveRecord::Migration
  def change
    create_table :coordinador_evaluaciones do |t|
      t.references :coordinador, null: false, index: true, foreign_key: true
      t.references :evaluacion, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
