class NotificacionesController < ApplicationController
  def index
    #@Notifs = Notificacion.all
      if current_persona
      #Notificaciones por usuario 
        @Notifs = Persona.find(current_persona.id).
                          notificaciones.
                          joins(:notificacion_tipo).
                          select('notificaciones.texto titulo_noti, 
                                 notificaciones.id,notificacion_tipos.texto 
                                 titulo_tipo,notificacion_tipos.clase,
                                 notificacion_tipos.clase_css').order('notificaciones.created_at DESC')
                                 
       #Notificaciones por rol  
       ##puts 'Notificaciones por rol'
       rol= Persona.joins(:rol).where(:id=>current_persona.id).pluck('roles.id')
       ##puts  rol                        
        @Notifs_rol = Notificacion.joins(:notificacion_tipo).where("notificaciones.rol_id"=>rol ).select('notificaciones.texto titulo_noti, notificaciones.id,notificacion_tipos.texto titulo_tipo,notificacion_tipos.clase,notificacion_tipos.clase_css').order(created_at: :DESC)
        ##@Notifs_rol = [1..9]                                                  
        @persona = Persona.find(current_persona.id)
        @persona.ultima_visita_notif = DateTime.current
        @persona.save
        #@Notifs = Notificacion.where("usuario_id = #{current_persona.id}")
        #@Notifs = Notificacion.find_by usuario_id: current_persona.id
        #puts @Notifs
        #format.html { redirect_to administracion_path, notice: 'Persona se ha creado correctamente.' }
        #format.json { render :show, status: :created, location: @persona }
      else
        #format.html { render :new }
        #format.json { render json: @persona.errors, status: :unprocessable_entity }
      end
  end
  
  def enviar
    @notif = Notificacion.new
    @roles = Rol.all
  end
  
  def create
    #@notif = Notificacion.new()
    #@notif.texto = params[:notificacion][:texto]
    #@notif.visible = true
    #@notif.tipo_notif_id = 1
    #@notif.usuario_id = 1
    @roles= params[:notificacion_roles]
    #PersonaRol.where("rol_id=1")
    #jason hasta aqui
    @usuarios=PersonaRol.where(rol_id: @roles).select(:persona_id).distinct

    if params[:tipo_notif_id] == '4'
       @roles.each do |rol| 
          @notif = Notificacion.new()
          @notif.texto = params[:notificacion][:texto]
          @notif.visible = true
          @notif.tipo_notif_id = params[:tipo_notif_id]
          @notif.rol_id = rol      
          @notif.save
       end
     else
        @usuarios.each do |usuario|
          @notif = Notificacion.new()
          @notif.texto = params[:notificacion][:texto]
          @notif.visible = true
          @notif.tipo_notif_id = params[:tipo_notif_id]
          @notif.usuario_id = usuario.persona_id
          @notif.save
          puts "Notificación id="+@notif.id.to_s+" enviada al usuario id="+usuario.to_s
        end
      end 
      flash[:notice] = 'Se envio su mensaje con exito '
      redirect_to :authenticated_root
    #puts "Notificaciones"
    #puts notif_params
    #@post.usuario_id = current_persona.id
    end



end
