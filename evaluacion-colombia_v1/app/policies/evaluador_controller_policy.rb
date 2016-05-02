class EvaluadorControllerPolicy < ApplicationPolicy
  def index?
    permisos = user.perfiles & ['listar_evaluadores', 'listar_evaluaciones_propias'] 
    permisos.any?
  end
  def realizadas?
    permisos = user.perfiles & ['listar_evaluadores', 'listar_evaluaciones_propias'] 
    permisos.any?
  end
  def pendientes?
    permisos = user.permisos & ['listar_evaluadores', 'listar_evaluaciones_propias'] 
    permisos.any?
  end
end
