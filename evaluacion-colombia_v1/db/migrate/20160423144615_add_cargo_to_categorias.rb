class AddCargoToCategorias < ActiveRecord::Migration
  def change
    add_column :categorias, :cargo_id, :integer
  end
end
