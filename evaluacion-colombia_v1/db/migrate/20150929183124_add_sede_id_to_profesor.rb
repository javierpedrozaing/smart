class AddSedeIdToProfesor < ActiveRecord::Migration
  def change
    add_column :profesores, :sede_id, :int
    add_index :profesores, :sede_id
  end
end
