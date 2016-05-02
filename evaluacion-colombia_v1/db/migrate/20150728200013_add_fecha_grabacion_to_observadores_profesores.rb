class AddFechaGrabacionToObservadoresProfesores < ActiveRecord::Migration
  def change
    add_column :observadores_profesores, :fecha_grabacion, :date
  end
end
