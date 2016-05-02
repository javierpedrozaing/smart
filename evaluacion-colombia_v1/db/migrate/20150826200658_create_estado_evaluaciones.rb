class CreateEstadoEvaluaciones < ActiveRecord::Migration
  def change
    create_table :estado_evaluaciones do |t|
      t.string :estado

      t.timestamps null: false
    end
  end
end
