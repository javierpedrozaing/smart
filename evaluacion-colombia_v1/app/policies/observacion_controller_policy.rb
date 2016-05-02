class ObservacionControllerPolicy < ApplicationPolicy
  def index?
    permisos = user.perfiles & ['listar_observadores'] 
    permisos.any?
  end
  def show?
    permisos = user.perfiles & ['listar_observadores'] 
    permisos.any?
  end
end
