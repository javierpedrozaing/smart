class CreatePersonasVideos < ActiveRecord::Migration
  def change
    create_table :personas_videos, id: false do |t|
      t.integer :persona_id
      t.integer :video_id
    end
  end
end
