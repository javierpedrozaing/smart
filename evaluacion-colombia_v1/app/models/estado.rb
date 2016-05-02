class Estado < ActiveRecord::Base
	has_many :personas
	has_many :profesor
	has_many :evaluador
	has_many :coordinador
	
	scope :activo, -> { where(estado: "Activo") }
	scope :inactivo, -> { where(estado: "Inactivo") }
	end
