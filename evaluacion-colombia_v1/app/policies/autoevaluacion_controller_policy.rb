class AutoevaluacionControllerPolicy < ApplicationPolicy
   def index? 
      permisos = user.perfiles & ['aprobar_video'] 
      permisos.any?
    end
   def guardar_autoevaluacion? 
      permisos = user.perfiles & ['aprobar_video'] 
      permisos.any?
    end
    def guardar_autoevaluacion_item? 
      permisos = user.perfiles & ['aprobar_video'] 
      permisos.any?
    end
end
