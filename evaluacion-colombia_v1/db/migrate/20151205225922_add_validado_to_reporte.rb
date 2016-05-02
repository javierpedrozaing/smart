class AddValidadoToReporte < ActiveRecord::Migration
  def change
    add_column :reportes, :validado, :boolean
    change_column :reportes, :validado, :boolean, null: false
    add_column :reportes, :tercer_evaluador, :boolean
    change_column :reportes, :tercer_evaluador, :boolean, null: false
  end
end
