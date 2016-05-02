class PostControllerPolicy < ApplicationPolicy
  def index?
  end
  def edit?
    permisos = current_persona.perfiles & ['editar_noticias'] 
    permisos.any?
  end
  def create?
    permisos = current_persona.perfiles & ['editar_noticias'] 
    permisos.any?
  end
  def delete
    permisos = current_persona.perfiles & ['editar_noticias'] 
    permisos.any?
  end
end