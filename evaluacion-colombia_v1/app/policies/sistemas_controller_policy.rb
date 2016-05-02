class SistemasControllerPolicy < ApplicationPolicy
  def index?
    permisos = user.perfiles & ['listar_administradores'] 
    permisos.any?
  end
  def logs?
  end
  def icfes?
  end
end
