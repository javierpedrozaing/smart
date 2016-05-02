class AlterEvaluaciones < ActiveRecord::Migration
  def change
    change_column :evaluaciones, :video_id, :integer, :null => true
    change_column :evaluaciones, :evaluador_id, :integer, :null => true
    add_column :evaluaciones, :estado_evaluacion_id, :integer, :index => true, :default => 1
  end
end
