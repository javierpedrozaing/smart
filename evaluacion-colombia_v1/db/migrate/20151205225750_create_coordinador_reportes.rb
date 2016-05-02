class CreateCoordinadorReportes < ActiveRecord::Migration
  def change
    create_table :coordinador_reportes do |t|
      t.references :coordinador, index: true, null: false, foreign_key: true
      t.references :reporte, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
