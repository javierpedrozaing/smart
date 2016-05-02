class TipoDocumento < ActiveRecord::Base
	has_many :personas
end
