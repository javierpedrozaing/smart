class Rol < ActiveRecord::Base
  has_many :persona_roles
  has_many :personas, through: :persona_roles
  has_many :rol_perfiles
  has_many :perfiles, through: :rol_perfiles

  scope :profesor, -> { where(rol: "Profesor") }
  scope :observador, -> { where(rol: "Camarógrafo") }
  scope :evaluador, -> { where(rol: "Evaluador") }
  scope :coordinador, -> { where(rol: "Coordinador") }
  scope :admin_evaluados, -> { where(rol: "Admin Evaluados") }
  scope :jefe_observadores, -> { where(rol: "Jefe de Camarógrafos") }
  scope :admin_evaluadores, -> { where(rol: "Admin Evaluadores") }
  scope :administrador, -> { where(rol: "Administrador") }
  scope :revisor, -> { where(rol: "Revisor de videos") }
end
