class CreateObservadoresProfesores < ActiveRecord::Migration
  def change
    create_table :observadores_profesores, id: false  do |t|     
      t.integer :profesor_id
      t.integer :observador_id
    end
    add_index :observadores_profesores, :profesor_id
    add_index :observadores_profesores, :observador_id
  end
end
