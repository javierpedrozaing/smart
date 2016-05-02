class Notificacion < ActiveRecord::Base
  belongs_to :notificacion_tipo, :foreign_key => :tipo_notif_id
  belongs_to :persona, :foreign_key => :usuario_id
end
