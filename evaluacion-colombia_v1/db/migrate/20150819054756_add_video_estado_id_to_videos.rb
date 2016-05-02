class AddVideoEstadoIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :video_estado_id, :integer, index: true
  end
end
