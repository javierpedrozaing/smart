class GrupoItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :pregunta
end
