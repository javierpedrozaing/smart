class AddMateriaNivelCargoToProfesor < ActiveRecord::Migration
  def change
    add_column :profesores, :materia_id, :integer 
    add_column :profesores, :nivel_id, :integer 
    add_column :profesores, :cargo_id, :integer 
  end
end
