class Sede < ActiveRecord::Base
  belongs_to :institucion
  has_many :profesores
end
