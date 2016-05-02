class AddEstadoToRevisorVideo < ActiveRecord::Migration
  def change
    add_column :revisor_videos, :estado, :integer 
  end
end
