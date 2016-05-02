class AddRevisadoToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :revisado, :boolean, :default => false
  end
end
