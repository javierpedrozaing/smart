class CreateMateriasEvaluadores < ActiveRecord::Migration
  def change
    create_table :materias_evaluadores do |t|
      t.integer :evaluador_id
      t.integer :materia_id
    end
  end
end
