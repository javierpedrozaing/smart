class CreateEstadoRevisionVideos < ActiveRecord::Migration
  def change
    create_table :estado_revision_videos do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
