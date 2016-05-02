class Permiso < ActiveRecord::Base
  belongs_to :perfiles
  belongs_to :estados
end
