class TestInstancia < ActiveRecord::Base
  belongs_to :test_persona
  has_many :respuesta_itemes
end
