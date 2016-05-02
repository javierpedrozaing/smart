class CreateVideoEstados < ActiveRecord::Migration
  def change
    create_table :video_estados do |t|
      t.string :video_estado
      t.integer :video_estado_id

      t.timestamps null: false
    end
  end
end
