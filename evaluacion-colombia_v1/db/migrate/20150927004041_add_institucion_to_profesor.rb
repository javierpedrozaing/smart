class AddInstitucionToProfesor < ActiveRecord::Migration
  def change
    add_column :profesores, :institucion_id, :integer 
  end
end
