class AddRegionToDepartamento < ActiveRecord::Migration
  def change
    add_column :departamentos, :region_id, :integer
    add_index :departamentos, :region_id
  end
end
