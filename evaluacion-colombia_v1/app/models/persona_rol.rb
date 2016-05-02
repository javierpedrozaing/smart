class PersonaRol < ActiveRecord::Base
  belongs_to :persona
  belongs_to :rol

  scope :profesores, -> { where(rol_id: Rol.profesor.ids) }
  scope :observadores, -> { where(rol_id: Rol.observador.ids) }
  scope :evaluadores, -> { where(rol_id: Rol.evaluador.ids) }
  scope :coordinadores, -> { where(rol_id: Rol.coordinador.ids) }
  scope :admin_evaluados, -> { where(rol_id: Rol.admin_evaluados.ids) }
  scope :jefes_observadores, -> { where(rol_id: Rol.jefe_observadores.ids) }
  scope :admin_evaluadores, -> { where(rol_id: Rol.admin_evaluadores.ids) }
  scope :administradores, -> { where(rol_id: Rol.administrador.ids) }
  scope :revisores, -> { where(rol_id: Rol.revisor.ids) }
end