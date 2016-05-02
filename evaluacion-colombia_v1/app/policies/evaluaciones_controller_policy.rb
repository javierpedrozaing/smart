class EvaluacionesControllerPolicy < ApplicationPolicy
  def index?
    permisos = user.perfiles & ['listar_evaluaciones'] 
    permisos.any?
  end
  def realizadas?
    permisos = user.perfiles & ['listar_evaluaciones'] 
    permisos.any?
  end
  def pendientes?
    permisos = user.perfiles & ['listar_evaluaciones'] 
    permisos.any?
  end
  def asignar_evaluador?
    permisos = user.perfiles & ['asignar_evaluador']
    permisos.any?
  end
end
