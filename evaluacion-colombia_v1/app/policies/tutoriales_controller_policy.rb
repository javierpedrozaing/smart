class TutorialesControllerPolicy < ApplicationPolicy
  def index?
    permisos = user.perfiles & ['listar_administradores'] 
    permisos.any?
  end
   def show?
    permisos = user.perfiles & ['listar_administradores'] 
    permisos.any?     
   end
   def new?
    permisos = user.perfiles & ['listar_administradores'] 
    permisos.any?     
   end
   def edit?
    permisos = user.perfiles & ['listar_administradores'] 
    permisos.any?
   end
   def create?
    permisos = user.perfiles & ['listar_administradores'] 
    permisos.any?
   end
   def update?
    permisos = user.perfiles & ['listar_administradores'] 
    permisos.any?     
   end
   def destroy?
    permisos = user.perfiles & ['listar_administradores'] 
    permisos.any?
     
   end
end
