class TestPregunta < ActiveRecord::Base
  belongs_to :test
  has_many :preguntas
end
