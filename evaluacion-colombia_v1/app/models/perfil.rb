class Perfil < ActiveRecord::Base
	has_many :rol_perfiles
	has_many :roles, through: :rol_perfiles
	has_many :tutorial
end
