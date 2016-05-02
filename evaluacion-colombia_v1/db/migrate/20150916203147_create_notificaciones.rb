class CreateNotificaciones < ActiveRecord::Migration
  def change
    create_table :notificaciones do |t|
      t.string :texto
      t.boolean :visible
      t.integer :usuario_id
      t.integer :tipo_notif_id

      t.timestamps null: false
    end
  end
end
