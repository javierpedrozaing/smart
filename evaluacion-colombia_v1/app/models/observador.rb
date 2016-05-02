class Observador < ActiveRecord::Base
  has_many :videos
  has_many :profesores, through: :videos
  belongs_to :estado
  belongs_to :persona
  belongs_to :canal_regional
  belongs_to :lider, class_name: "Persona", foreign_key: :lider_id
end
