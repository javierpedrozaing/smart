class CreateItemes < ActiveRecord::Migration
  def change
    create_table :itemes do |t|
      t.integer :grupo_item_id
      t.integer     :codigo_icfes
      t.string      :item
      t.integer     :item_valor
    end
  end
end
