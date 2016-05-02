class CreateNotificacionTipos < ActiveRecord::Migration
  def change
    create_table :notificacion_tipos do |t|
      t.string :texto

      t.timestamps null: false
    end
  end
end
