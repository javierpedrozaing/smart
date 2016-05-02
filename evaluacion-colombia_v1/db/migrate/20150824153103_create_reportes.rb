class CreateReportes < ActiveRecord::Migration
  def change
    create_table :reportes do |t|
      t.integer :persona_id
      t.integer :video_id
      t.integer :tipos_reporte_id
      t.timestamps null: false
    end
  end
end
