class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :profesor_id
      t.integer :observador_id
      t.boolean :identidad_verificada
      t.integer :reporte_id
    end
  end
end
