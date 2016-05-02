class AddDepartamentoMunicipioToProfesor < ActiveRecord::Migration
  def change
    add_column :profesores, :departamento_id, :int
    add_index :profesores, :departamento_id
    add_column :profesores, :municipio_id, :int
    add_index :profesores, :municipio_id
  end
end
