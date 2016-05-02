class CreateAutoevaluacionRespuestas < ActiveRecord::Migration
  def change
    create_table :autoevaluacion_respuestas do |t|
      t.references :autoevaluacion, index: {:unique=>true}, foreign_key: true
      t.references :grilla_autoevaluacion, index: true, foreign_key: true
      t.string :valor

      t.timestamps null: false
    end
  end
end
