class AddCargoIdToCargo < ActiveRecord::Migration
  def change
    add_column :cargos, :cargo_id, :integer 
  end
end
