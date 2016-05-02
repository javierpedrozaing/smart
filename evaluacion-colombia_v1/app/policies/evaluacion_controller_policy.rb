class EvaluacionControllerPolicy < ApplicationPolicy
  def index?
    permisos = user.perfiles & ['listar_coordinadores'] 
    permisos.any?  
  end
  def show?
    permisos = user.perfiles & ['listar_evaluadores'] 
    permisos.any?
  end
  def evaluadores?
    permisos = user.perfiles & ['listar_evaluadores'] 
    permisos.any?    
  end
end
