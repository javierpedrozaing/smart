class ProfesorControllerPolicy < ApplicationPolicy
  def index?
    permisos = user.perfiles & ['aprobar_video'] 
    permisos.any?
  end
  def panel?
    permisos = user.perfiles & ['aprobar_video'] 
    permisos.any?
  end
end
