class AddRegistradoToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :registrado, :boolean, :default => false
  end
end
