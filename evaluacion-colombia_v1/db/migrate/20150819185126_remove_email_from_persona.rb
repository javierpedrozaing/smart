class RemoveEmailFromPersona < ActiveRecord::Migration
  def change
  	remove_column :personas, :email
  end
end
