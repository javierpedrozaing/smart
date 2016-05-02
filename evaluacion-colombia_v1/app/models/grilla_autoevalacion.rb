class GrillaAutoevalacion < ActiveRecord::Base
  belongs_to :grilla
  belongs_to :escala
end
