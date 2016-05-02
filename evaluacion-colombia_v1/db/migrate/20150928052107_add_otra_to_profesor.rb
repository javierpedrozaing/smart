class AddOtraToProfesor < ActiveRecord::Migration
  def change
    add_column :profesores, :otra, :string
  end
end
