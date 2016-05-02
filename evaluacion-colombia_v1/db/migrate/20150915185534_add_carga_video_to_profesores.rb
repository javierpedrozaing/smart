class AddCargaVideoToProfesores < ActiveRecord::Migration
  def change
    add_column :profesores, :carga_video, :boolean
  end
end
