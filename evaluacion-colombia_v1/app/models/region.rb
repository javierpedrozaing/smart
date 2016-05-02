class Region < ActiveRecord::Base
  has_many :secretarias_educaciones
  has_many :departamentos
end
