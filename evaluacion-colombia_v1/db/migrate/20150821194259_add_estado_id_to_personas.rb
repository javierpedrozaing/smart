class AddEstadoIdToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :estado_id, :integer
  end
end
