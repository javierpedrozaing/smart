class AdministracionControllerPolicy < ApplicationPolicy 
  def index?
    permisos = user.perfiles & ['listar_profesores'] 
    permisos.any?      
  end
  def previsualizacion_video?
  end
  def reporte_estados?    
  end
end
