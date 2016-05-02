class AddPicoPlacaToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :pico_placa, :boolean
  end
end
