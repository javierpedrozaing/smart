class CuentaController < ApplicationController
  before_action :set_persona, only: [:activar]
  layout 'cuenta'
  def login
    @persona = Persona.new
  end
  def tipo_usuario
    ##layout 'application'
    #puts 'tipo de usuario para el enlace'
    #perfiles =''
    #if Persona.profesores.where(:id=>current_persona.id).exists?

    #   perfiles='profesor'
    # elsif Persona.observadores.where(:id=>current_persona.id).exists?
    #    perfiles='camarografo'
    #end
    #@perfil=perfiles
    render layout: "application"
  end
  def new_registro
    # Formulario de busqueda de usuario con cedula e informacion de identidad
     #redirect_to :unauthenticated_root se vuelve habilitar para tipo de usuario cammarografo
  end
  def editar_cuenta_simple
    @persona = current_persona
    @profesor = current_persona.profesor
    
    if @profesor
      if @profesor.cargo
        if !Cargo.find(@profesor.cargo_id).cargo_id
        @cargo = @profesor.cargo_id
        else
          @cargo = Cargo.find(@profesor.cargo_id).cargo_id
          @subcargo = @profesor.cargo_id
        end
      end
      if @profesor.nivel
        if !Nivel.find(@profesor.nivel_id).nivel_id
          @nivel = @profesor.nivel_id
        else
          @nivel = Nivel.find(@profesor.nivel_id).nivel_id
          @subnivel = @profesor.nivel_id
        end
      end
      if @profesor.sede
        @sede = @profesor.sede
        @municipio = @profesor.sede.municipio_id
        @institucion = @profesor.sede.institucion_id
      else 
        if @profesor.municipio
          @municipio = @profesor.municipio_id
        end
        if @profesor.institucion
          @institucion = @profesor.institucion_id
        end
      end
    end
    

    render layout: "editar_cuenta"
  end

  def editar_cuenta_simple_actualizar
    

  end

  def editar_cuenta
    #redirect para evitar que entren por la url en periodos donde el perfil esta desactivado
    ##redirect_to :authenticated_root and return
    @persona = current_persona
    @profesor = current_persona.profesor
    
    if @profesor
      if @profesor.cargo
        if !Cargo.find(@profesor.cargo_id).cargo_id
        @cargo = @profesor.cargo_id
        else
          @cargo = Cargo.find(@profesor.cargo_id).cargo_id
          @subcargo = @profesor.cargo_id
        end
      end
      if @profesor.nivel
        if !Nivel.find(@profesor.nivel_id).nivel_id
          @nivel = @profesor.nivel_id
        else
          @nivel = Nivel.find(@profesor.nivel_id).nivel_id
          @subnivel = @profesor.nivel_id
        end
      end
      if @profesor.sede
        @sede = @profesor.sede
        @municipio = @profesor.sede.municipio_id
        @institucion = @profesor.sede.institucion_id
      else 
        if @profesor.municipio
          @municipio = @profesor.municipio_id
        end
        if @profesor.institucion
          @institucion = @profesor.institucion_id
        end
      end
    end
    

    render layout: "editar_cuenta"
  end
  def editar_profesor_dep_muni
    @persona = current_persona
    @profesor = current_persona.profesor
    render layout: "editar_cuenta"
  end
  def editar_profesor_dep_muni_actualizar
    @profesor= Profesor.find(profesor_params.first.second)
    if @profesor.update(profesor_params)
      @profesor.save
      @persona = @profesor.persona
      ##La otra opción de redirect seria
      ##redirect_to profesor_formulario_planeacion_path
      flash[:notice] = 'Su INFORMACIÓN ha sido actualizada con exito '
              ##redirect_to :authenticated_root
              redirect_to profesor_formulario_planeacion_path
    else
      flash[:notice] = 'Su INFORMACIÓN NO ha sido actualizada correctamente'
              redirect_to :authenticated_root
    end
  end
  def new_registro_profesor
    # Formulario de busqueda de profe con el pin de icfes
    
  end
  
    def new_registro_camarografo
    # Formulario de busqueda de profe con el pin de icfes
    puts "salio parametros"
    puts params
    
  end

  def cargar_profesor
    @profesor= Profesor.find(profesor_params.first.second)
    if @profesor.update(profesor_params)
      @profesor.save
      @persona = @profesor.persona
    else
      render "activar_profesor"
    end
  end

  def activar_profesor
    @persona = Persona.find(persona_params.first.second)
    if @persona.update(persona_params)
      @persona.registrado = true
      @persona.save
      UsuarioMailer.bienvenido_email(@persona).deliver_now
      flash[:notice] = 'Se ha activado la cuenta con email '+@persona.email
      redirect_to :authenticated_root
    else      
      render "cargar_profesor"
    end
  end
  def activar_admin
    sadsadasdasd
    @persona  = Persona.find(params[:persona][:id])  
  end
  def activar_camarografo
    puts 'prueba de salida del camarografo'
    
    pin_icfes = IcfesRegistro.where(icfes_params).first            
    if !pin_icfes.nil?
         @persona  = Persona.find(pin_icfes[:persona_id])     
     else
      #redirect_to :new_registro_profesor, :flash => {:error => "No existe ese PIN en el sistema"}
      redirect_to cuenta_camarografo_path, alert: "El NIP ingresado no se encuentra registrado. Por favor comuníquese con el productor encargado de su canal."
    end
  end
  
  def  activar_camarografo_email     
 
    @persona  = Persona.find(params[:persona][:id])  
    #encryted password is controller
    new_hashed_password = Persona.new(:password => params[:persona][:password_confirmation]).encrypted_password
     if @persona.update(:id=>@persona.id)
        @persona.registrado = true
        @persona.encrypted_password= new_hashed_password 
        @persona.save
        # Reset password devise is controller   
        # raw_token, hashed_token = Devise.token_generator.generate(Persona, :reset_password_token)
        UsuarioMailer.password_reset([@persona],new_hashed_password).deliver_now  #envio de mail  
        flash[:notice] = 'Un mensaje ha sido enviado a su correo electrónico confirmando la generación de su contraseña y el registro en la plataforma'
        redirect_to  :authenticated_root
      else      
        render "cargar_camarografo"
      end

  end
  def activar_admin_email
    @persona  = Persona.find(params[:persona][:id])  
   
    #encryted password is controller
    new_hashed_password = Persona.new(:password => params[:persona][:password_confirmation]).encrypted_password
     if @persona.update(:id=>@persona.id)
        @persona.registrado = true
        @persona.encrypted_password= new_hashed_password 
        @persona.save
        # Reset password devise is controller   
        # raw_token, hashed_token = Devise.token_generator.generate(Persona, :reset_password_token)
        UsuarioMailer.password_reset([@persona],new_hashed_password).deliver_now  #envio de mail  
        flash[:notice] = 'Un mensaje ha sido enviado a su correo electrónico confirmando la generación de su contraseña y el registro en la plataforma'
        redirect_to  :authenticated_root
      else      
        render "cargar_camarografo"
      end
  end
    

  def activar_registro_profesor
    # Formulario para activar usuario
    pin_icfes = IcfesRegistro.where(icfes_params).first
    if !pin_icfes.nil?
      @persona = pin_icfes.persona
      if @persona.registrado?
        redirect_to :unauthenticated_root, :flash => {:error => "La cuenta ya se encuentra activada. Favor ingresar con su Número de Documento y clave creada por usted." } 
      end
    else
      #redirect_to :new_registro_profesor, :flash => {:error => "No existe ese PIN en el sistema"}
      redirect_to cuenta_profesor_path, alert: "El NIP ingresado no se encuentra registrado. Favor comunicarse con MEN  al siguiente numero: 01800 910122."
    end
  end

  def activar_registro_persona
    #@registro_men = RegistroMen.where(documento: registro_params[:documento]).first se quita para habilitar camarografo
    @persona = Persona.where(registro_params).first
    #puts "First second"
    #puts registro_params.first.second
    #puts "DOCUMENTO: " + registro_params[:documento]
    #if !@persona.nil?
    #if !@registro_men.nil? 
      if !@persona.nil?
        if @persona.registrado?
          redirect_to :unauthenticated_root, :flash => {:error => "La cuenta ya se encuentra activada. Favor ingresar con su Número de Documento y clave creada por usted." } 
        else
          if @persona.rol.rol == "Camarógrafo" || @persona.rol.rol =="Evaluador" #"Profesor"
            redirect_to :cuenta_camarografo ,:Arraypersona => @persona #, :notice => "Bienvenido profesor"
          
          elsif @persona.rol.rol == "Admin Evaluados" || @persona.rol.rol == "Admin Evaluadores" || @persona.rol.rol == "Coordinador" || @persona.rol.rol =="Jefe de Camarógrafos"
            
            render "activar_admin"
          end
        end
      else
        redirect_to cuenta_registro_path, alert: "Su número o tipo de documento no se encuentra registrado. Por favor comuníquese con el productor encargado de su canal."
      end
    #else
     # redirect_to cuenta_registro_path, alert: "El número de documento ingresado no se encuentra registrado. Favor comunicarse con MEN  al siguiente numero: 01800 910122."
   # end
  end
  
  def redirect
    render layout: "403", :status => :forbidden  and return
  end
  
  def mailtest
    @user=Persona.find(1)
    #render :template => "layouts/mailer"
    render :template => "usuario_mailer/password_reset"
  end

  def editar_cuenta_persona
    @persona = Persona.find(persona_params.first.second)
    if @persona.update(persona_params)
       @persona.save
      flash[:notice] = 'Su INFORMACIÓN PERSONAL ha sido actualizada con exito '
              redirect_to action: "editar_cuenta"
    else 
      flash[:notice] = 'Su INFORMACIÓN PERSONAL no ha sido actualizada correctamente'
              redirect_to action: "editar_cuenta"
    end
  end

  def editar_cuenta_profesor
      @profesor= Profesor.find(profesor_params.first.second)
      if @profesor.update(profesor_params)
        @profesor.save
        @persona = @profesor.persona
        flash[:notice] = 'Su INFORMACIÓN LABORAL ha sido actualizada con exito '
                redirect_to action: "editar_cuenta"
      else
        flash[:notice] = 'Su INFORMACIÓN LABORAL no ha sido actualizada correctamente'
                redirect_to action: "editar_cuenta"
      end
  end

  def activar
       puts "salida de actualizacion"
       puts persona_params
    if @persona.update(persona_params)
        @persona.registrado = true
        @persona.save
        
        email_registro(@persona)
        
        flash[:notice] = 'Se ha activado la cuenta con email '+@persona.email
        redirect_to :authenticated_root
        
    else 
        flash[:notice] = 'No se ha activado la cuenta con email, porque ya existe '+@persona.email     
        redirect_to :authenticated_root
    end
  end

#Generacion de nueva contraseña  
  def reset_password_email
       persona =Persona.where(persona_params, :registro=>true)
    if persona.count > 0
        #pass = '12345678'    
        puts 'datos de reset password'
        puts persona[0].email       
        #Cambio de contraseña del usuario que la solicita 
        #persona.update(persona[0].id.to_i, :password=>pass,:password_confirmation=>pass)
        UsuarioMailer.password_reset(persona).deliver_now  #envio de mail  
        redirect_to :authenticated_root, :alert => 'Su contraseña sera enviada a su correo electrónico ' + persona[0].email
        
      else 
            
        redirect_to :authenticated_root , :alert =>  'No se ha podido enviar al email la información ' 
    end   
    
  end

  def ajax_municipios
    respond_to do |format|
          @municipios = Municipio.where("departamento_id = ?",params[:departamento_id]).order(:nombre)
          format.json { render :json => @municipios }
    end
  end

  def ajax_instituciones
    respond_to do |format|
          sedes_query = Sede.where(municipio_id: params[:municipio_id]).pluck(:institucion_id)
          #@instituciones = Institucion.where("municipio_id = ?",params[:municipio_id]).order(:nombre)
          @instituciones = Institucion.where(id: sedes_query).order(:nombre)
          format.json { render :json => @instituciones }
    end
  end

  def ajax_cargos
    respond_to do |format|
          @subcargos = Cargo.where("cargo_id = ?",params[:cargo_id])
          format.json { render :json => @subcargos }
    end
  end

  def ajax_niveles
    respond_to do |format|
          @subniveles = Nivel.where("nivel_id = ?",params[:nivel_id])
          format.json { render :json => @subniveles }
    end
  end

  def ajax_sedes
    respond_to do |format|
          @sedes = Sede.where("institucion_id = ?",params[:institucion_id]).order(:nombre)
          format.json { render :json => @sedes }
    end
  end
  
  #Ingreso de profesor activo via mail  
  def email_ingreso     
     @persona= Persona.profesores.find(params[:id])
     # Llamamos al   ActionMailer que creamos
     render usuario_mailer_bienvenida_usuario_path
        
  end 
  
  protected
    def set_persona
      @persona = Persona.find(params[:persona][:id])
    end

    def persona_params
      params.require(:persona).permit(:id, :nombre, :apellido_paterno, :apellido_materno, :tipo_documento_id, :documento, :direccion, :telefono, :celular, :email,:archivo, :consentimiento, :password, :password_confirmation)
    end

    def profesor_params
      params.require(:profesor).permit(:id, :cargo_id, :nivel_id, :materia_id, :tipo_grabacion_id, :institucion_id, :otra, :sede_id, :departamento_id, :municipio_id)
    end
    
    def icfes_params
      params.permit(:pin)
    end

    def registro_params
      params.permit(:tipo_documento_id, :documento)
    end 
    #creamos metodo de envio de email 
    def email_registro(persona)
       @persona1 = persona   
       # Llamamos al   ActionMailer que creamos
       UsuarioMailer.bienvenido_email(@persona1).deliver_now     
       
    end  


end
