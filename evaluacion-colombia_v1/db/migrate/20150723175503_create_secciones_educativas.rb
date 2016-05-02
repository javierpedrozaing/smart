class CreateSeccionesEducativas < ActiveRecord::Migration
  def change
    create_table :secciones_educativas do |t|
      t.string :seccion

      t.timestamps null: false
    end
  end
end
