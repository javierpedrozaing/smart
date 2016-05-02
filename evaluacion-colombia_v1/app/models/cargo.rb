class Cargo < ActiveRecord::Base
  belongs_to :cargo 
  has_many :cargos, :foreign_key => "cargo_id"
  has_many :profesores
  has_many :evaluadores
  has_many :coordinadores
  has_one  :grilla
end