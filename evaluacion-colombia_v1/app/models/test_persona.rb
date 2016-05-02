class TestPersona < ActiveRecord::Base
  belongs_to :test
  has_many :test_instancias
  belongs_to :evaluado, class_name: "Persona"
  belongs_to :evaluador, class_name: "Persona"
end
