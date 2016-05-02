class UsuarioMailer < ApplicationMailer
  default from: 'no-responder@icfes.gov.co'
          #return_path: 'system@ogr.cl'
  skip_before_filter :verify_authenticity_token        
          
  def bienvenida_usuario(persona)
    @persona = persona
    mail(to: @persona.email, subject: "Inicio de cuenta en plataforma de Evaluación Docente")
  end
  
  def bienvenido_email(user)
    @user = user    
    #@url  = 'http://puntajenacional.co'
    puts "correo"
    puts @user.email
   if Rails.env.development? 
      @url_servido="http://jeyson.evaluacion-colombia.ogr.cl/"
    else
      @url_servido="http://plataformaecdf.icfes.gov.co/"
      
   end
    mail(to: @user.email, subject: 'Activar cuenta en plataforma de Evaluación Docente')
  end
  
  def password_reset(user,raw_token)
    @user = user[0]  
    @raw_token=raw_token
    puts "reseteo clave"
    #@user.ensure_authentication_token!   
    #@user.update(:id=>@user.id)
    #@user.reset_password_token = @token
    #@user.save  
    
    
    
   if Rails.env.development? 
      @url_servidor="http://jeyson.evaluacion-colombia.ogr.cl/"
    else
      @url_servidor="http://plataformaecdf.icfes.gov.co/"
      
   end
    mail(to: @user.email, subject: 'Nueva Contraseña Generada Evaluacion-Docente')
  end
end
