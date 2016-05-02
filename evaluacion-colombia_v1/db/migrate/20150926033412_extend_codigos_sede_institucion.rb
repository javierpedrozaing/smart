class ExtendCodigosSedeInstitucion < ActiveRecord::Migration
  def change
    change_column :instituciones, :codigo, :integer, :limit => 8
    change_column :sedes, :codigo, :integer, :limit => 8
  end
end
