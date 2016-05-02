class HomeController < ApplicationController
  before_action :authenticate_persona!
  def index
      redirect_to persona_rol_index current_persona
   
  end

  private
    def persona_rol_index(persona)
      case persona.rol.rol
      when 'Super Usuario'
        usuarios_administradores_path
      when 'Administrador'
        usuarios_administradores_path
      when 'Jefe de Evaluadores'
        usuarios_evaluadores_path
      when 'Jefe de Camarógrafos'
        #usuarios_jefe_camarografos_path
        usuarios_camarografos_path
      when 'Jefe de Evaluaciones'
        usuarios_jefe_evaluacion_path
      when 'Evaluador'
        evaluador_path
      when 'Camarógrafo'
        observador_path
      when 'Profesor'
        profesor_path
      when 'Coordinador'
        coordinador_path
      when 'Revisor de videos'
        revisor_videos_path
      end
    end
end