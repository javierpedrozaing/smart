class UsuariosControllerPolicy < ApplicationPolicy
def evaluadores?
    permisos = user.perfiles & ['listar_evaluadores', 'listar_evaluadores_asignados'] 
    permisos.any?
  end
  def profesores?
    permisos = user.perfiles & ['listar_profesores'] 
    permisos.any?
  end
  def camarografos?
    permisos = user.perfiles & ['listar_observadores'] 
    permisos.any?
  end
  def coordinadores?
    permisos = user.perfiles & ['listar_jefes']
    permisos.any?
  end

  def admin_evaluados?
    permisos = user.perfiles & ['listar_jefes']
    permisos.any?
  end

  def jefe_camarografos?
    permisos = user.perfiles & ['listar_jefes']
    permisos.any?
  end

  def admin_evaluadores?
    permisos = user.perfiles & ['listar_jefes']
    permisos.any?
  end

  def revisor_videos?
    permisos = user.perfiles & ['listar_jefes']
    permisos.any?
  end

  def administradores?
    permisos = user.perfiles & ['listar_administradores']
    permisos.any?
  end
end
