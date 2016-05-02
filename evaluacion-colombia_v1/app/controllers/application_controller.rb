class ApplicationController < ActionController::Base  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :resource_name, :resource, :devise_mapping, :check_perfiles
  # Globally rescue Authorization Errors in controller.
  # Returning 403 Forbidden if permission is denied in pundit
  rescue_from Pundit::NotAuthorizedError, with: :permission_denied


  def resource_name
    :persona
  end
 
  def resource
    @resource ||= Persona.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:persona]
  end

  def check_perfiles(arr_cod_perfiles)
    permisos = current_persona.perfiles & arr_cod_perfiles
    permisos.any?
  end

  def after_sign_in_path_for(resource)
      case resource.rol.rol
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
      when 'Admin Evaluadores'
        estadisticas_admin_evaluadores_path
      when 'Admin Evaluados'
        estadisticas_admin_evaluados_path
      end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:tipo_documento_id, :documento, :username, :email, :password, :remember_me) }
  end

  def pundit_user
    current_persona
  end

  def permission_denied
     puts "error 403" 
    puts request.env["HTTP_REFERER"]
   if request.env["HTTP_REFERER"] == "http://jeyson.evaluacion-colombia.ogr.cl/" #request.fullpath url_for(:only_path => false)
      sign_out current_persona #borramos la cuenta de usuario ya que no tiene perfil para esta labor
      self.response_body = nil 
      puts "salida pantalla 403"
      render layout: "403", :status => :forbidden  and return
   else
    flash[:alert] = "Usted no tiene permisos adecuados para ver esta página, si usted piensa que debería tenerlos por favor informe en el chat."
    self.response_body = nil # This should resolve the redirect root.
    redirect_to(request.referrer || :authenticated_root)
    #render layout: "403", :status => :forbidden  and return
   end
  end

  def permit_videos
    Rails.application.config.permit_videos
  end

end
