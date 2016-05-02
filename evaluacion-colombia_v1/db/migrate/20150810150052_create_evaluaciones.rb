class CreateEvaluaciones < ActiveRecord::Migration
  def change
    create_table :evaluaciones do |t|
      t.integer :evaluador_id
      t.integer :profesor_id
      t.integer :video_id
      t.string  :contenido_evaluacion
      t.integer :valor
      t.timestamps null: false
    end
  end
end
