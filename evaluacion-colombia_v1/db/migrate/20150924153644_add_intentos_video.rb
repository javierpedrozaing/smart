class AddIntentosVideo < ActiveRecord::Migration
  def change
    add_column :videos, :intentos, :integer, default: 0
  end
end
