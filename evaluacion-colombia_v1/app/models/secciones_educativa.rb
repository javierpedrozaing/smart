class SeccionesEducativa < ActiveRecord::Base
has_one :profesor
has_many :evaluador_secciones
has_many :evaluadores, through: :evaluador_secciones
end
