class ObservadorControllerPolicy < ApplicationPolicy
  def index?
    permisos = user.perfiles & ['listar_videos_asignados']
    permisos.any?
  end

  def upload?
  end

  def show?
    
  end

  def persona_videos?       
  end
  
  def detalle_profesor?     
  end
  
end
