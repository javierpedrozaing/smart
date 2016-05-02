class AddNotificacionesPersona < ActiveRecord::Migration
  def change
    add_column :personas, :ultima_visita_notif, :datetime 
    add_column :personas, :ultima_visita_blog, :datetime
  end
end
