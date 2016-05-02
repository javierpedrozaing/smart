class AddLiderObservador < ActiveRecord::Migration
  def change
    add_column :observadores, :lider_id, :integer
  end
end
