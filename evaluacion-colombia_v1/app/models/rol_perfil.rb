class RolPerfil < ActiveRecord::Base
	belongs_to :rol
	belongs_to :perfil
end
