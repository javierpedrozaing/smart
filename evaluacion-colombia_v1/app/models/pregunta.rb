class Pregunta < ActiveRecord::Base
  belongs_to :grilla
  has_many :grupo_itemes
end
