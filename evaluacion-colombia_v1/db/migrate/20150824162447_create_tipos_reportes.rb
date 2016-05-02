class CreateTiposReportes < ActiveRecord::Migration
  def change
    create_table :tipos_reportes do |t|
      t.string :nombre
    end
  end
end
