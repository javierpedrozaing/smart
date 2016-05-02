class CreatePortafolios < ActiveRecord::Migration
  def change
    create_table :portafolios do |t|
      t.text :texto
      t.timestamps null: false
    end
  end
end
