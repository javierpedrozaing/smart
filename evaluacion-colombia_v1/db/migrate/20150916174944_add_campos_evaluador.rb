class AddCamposEvaluador < ActiveRecord::Migration
  def change
    add_column :evaluadores, :cargo_id, :integer
    add_column :evaluadores, :grado_academico_id, :integer
    add_column :evaluadores, :secretarias_educacion_id, :integer
  end
end
