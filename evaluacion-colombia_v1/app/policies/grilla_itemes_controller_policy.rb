class GrillaItemesControllerPolicy < ApplicationPolicy
  def index?
    permisos = user.perfiles & ['listar_grilla'] 
    permisos.any?
  end

  def show?
    permisos = user.perfiles & ['ver_grilla'] 
    permisos.any?
  end

  def new?
    permisos = user.perfiles & ['nueva_grilla'] 
    permisos.any?
  end

  def edit?
    permisos = user.perfiles & ['editar_grilla'] 
    permisos.any?
  end

  def create?
    permisos = user.perfiles & ['crear_grilla'] 
    permisos.any?
  end

  def update?
    permisos = user.perfiles & ['actualizar_grilla'] 
    permisos.any?
  end

  def destroy?
    permisos = user.perfiles & ['destruir_grilla'] 
    permisos.any?
  end
end