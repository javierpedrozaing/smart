class CreateItemSaltos < ActiveRecord::Migration
  def change
    create_table :item_saltos do |t|
      t.integer :item_id
      t.integer :pregunta_id
    end
  end
end
