class CreateEvaluacionRespuestas < ActiveRecord::Migration
  def change
    create_table :evaluacion_respuestas do |t|
      t.references :evaluacion, index: true, foreign_key: true
      t.references :grilla_item, index: true, foreign_key: true
      t.string :valor

      t.timestamps null: false
    end
  end
end
