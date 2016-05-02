class CreateValoracionItemes < ActiveRecord::Migration
  def change
    create_table :valoracion_itemes do |t|
      t.integer :item_id
      t.integer :valoracion_id
      t.string :valoracion
    end
  end
end
