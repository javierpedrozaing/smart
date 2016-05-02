class AddTipoGrabacionToProfesor < ActiveRecord::Migration
  def change
    add_column :profesores, :tipo_grabacion_id, :integer 
  end
end
