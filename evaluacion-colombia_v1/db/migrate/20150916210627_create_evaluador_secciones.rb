class CreateEvaluadorSecciones < ActiveRecord::Migration
  def change
    create_table :evaluador_secciones do |t|
      t.integer :evaluador_id
      t.integer :secciones_educativa_id
    end
  end
end
