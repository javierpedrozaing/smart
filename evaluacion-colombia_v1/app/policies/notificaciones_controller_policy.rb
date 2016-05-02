class PostControllerPolicy < ApplicationPolicy
  def index?
  end
  def enviar?
    permisos = current_persona.perfiles & ['editar_noticias'] 
    permisos.any?
  end
  def create?
    permisos = current_persona.perfiles & ['editar_noticias'] 
    permisos.any?
  end

end