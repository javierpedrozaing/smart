class AddRolIdToNotificaciones < ActiveRecord::Migration
  def change
    add_column :notificaciones, :rol_id, :integer
  end
end
