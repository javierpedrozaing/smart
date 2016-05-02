class AddFechaGrabacionToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :fecha_grabacion, :string
  end
end
