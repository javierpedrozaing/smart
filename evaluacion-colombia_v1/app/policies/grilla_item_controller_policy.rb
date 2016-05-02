class GrillaItemesControllerPolicy < ApplicationPolicy
  def index?
    permisos = user.perfiles & ['listar_grilla'] 
    persmisos.any?
  end

  def show?
    permisos = user.perfiles & ['ver_grilla'] 
    persmisos.any?
  end

  def new?
    permisos = user.perfiles & ['nueva_grilla'] 
    persmisos.any?
  end

  def edit?
    permisos = user.perfiles & ['editar_grilla'] 
    persmisos.any?
  end

  def create?
    permisos = user.perfiles & ['crear_grilla'] 
    persmisos.any?
  end

  def update?
    permisos = user.perfiles & ['actualizar_grilla'] 
    persmisos.any?
  end

  def destroy?
    permisos = user.perfiles & ['destruir_grilla'] 
    persmisos.any?
  end
end