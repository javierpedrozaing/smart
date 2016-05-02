class ChangeValidadoToRevisado < ActiveRecord::Migration
  def change
    rename_column :reportes, :validado, :revisado
  end
end
