class AddClaseClaseCssNotifTipo < ActiveRecord::Migration
  def change
    add_column :notificacion_tipos, :clase, :string 
    add_column :notificacion_tipos, :clase_css, :string
  end
end
