class CreateRevisorVideos < ActiveRecord::Migration
  def change
    create_table :revisor_videos do |t|
      t.integer :video_id
      t.integer :revisor_id
      t.boolean :aprobado

      t.timestamps null: false
    end
  end
end
