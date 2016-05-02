class Persona < ActiveRecord::Base  
  has_one :icfes_registro
  belongs_to :tipo_documento
  has_one :profesor
  has_one :observador
  has_one :coordinador
  has_one :evaluador
  has_one :revisor_video
  belongs_to :estado
  has_one :persona_rol
  has_one :rol, through: :persona_rol
  has_and_belongs_to_many :videos
  belongs_to :estado
  has_many :notificaciones, :foreign_key => :usuario_id

# => Gestion de usuario
#-----------------------------------------

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable,
         :authentication_keys => {documento: true, tipo_documento_id: true}

  #validates_confirmation_of :password
# => Listar todos los usuarios de un tipo
#------------------------------------------
  scope :profesores, -> { where(id: PersonaRol.profesores.pluck(:persona_id)).order(:nombre)}
  scope :observadores, -> { where(id: PersonaRol.observadores.pluck(:persona_id)).order(:nombre) }
  scope :evaluadores, -> { where(id: PersonaRol.evaluadores.pluck(:persona_id)).order(:nombre) }
  scope :coordinadores, -> { where(id: PersonaRol.coordinadores.pluck(:persona_id)).order(:nombre) }
  scope :admin_evaluados, -> { where(id: PersonaRol.admin_evaluados.pluck(:persona_id)) }
  scope :jefes_observadores, -> { where(id: PersonaRol.jefes_observadores.pluck(:persona_id)) }
  scope :admin_evaluadores, -> { where(id: PersonaRol.admin_evaluadores.pluck(:persona_id)) }
  scope :administradores, -> { where(id: PersonaRol.administradores.pluck(:persona_id)) }
  scope :revisores, -> { where(id: PersonaRol.revisores.pluck(:persona_id))}


# => Listar a las personas con video
#------------------------------------------
  scope :con_video, -> { where(id: PersonasVideo.all.map{|p| p.persona_id}) }
  scope :sin_video, -> { where.not(id: PersonasVideo.all.map{|p| p.persona_id}) }
  
  scope :personas,-> { select('personas.*,roles.rol, estados.estado')
                       .joins(:estado)
                       .joins(:persona_rol=>:rol)
                       .joins(:tipo_documento)}
                                         
    #consulta de videos para evaluacion en estado 5=Grabacion finalizada
  scope :videos_evaluacion,->  {self.con_video.joins(:videos).where('videos.video_estado_id'=>5).pluck(:id)}                                      
                  
  def nombre_completo
    return "#{self.nombre} #{self.apellido_paterno} #{self.apellido_materno}"
  end

  def hidden_email
    self.email.gsub(/.{0,4}@/, 'xxxx@')
  end
  
def notif_new_tooltip
  Notificacion.where("notificaciones.usuario_id= " + self.id.to_s + " or notificaciones.rol_id= " + Persona.joins(:rol).where(:id=>self.id).pluck('roles.id').first.to_s).where("created_at > ?", self.ultima_visita_notif).count
  #Notificacion.where(usuario_id: [self.id,Persona.joins(:rol).where(:id=>self.id).select('roles.id')]).where("created_at > ?", self.ultima_visita_notif).count  
end

def blog_new_tooltip
  Post.where("created_at > ?", self.ultima_visita_blog).count
end

  def perfiles
    self.rol.perfiles.map{ |x| x.codigo} 
  end
  def videos_por_revisar
    RevisorVideo.where(revisor_id: self.id).where(estado: 1).count
  end
  
  ##No borra reportes ni evaluaciones asociadas a las revisiones
  def reset_revisiones
    revisiones=RevisorVideo.where(revisor_id: self.id)
    
    revisiones.each do |rev|
      rev.estado = 1
      rev.save
    end
    
  end
    # => Valida el mail del usuario
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
validates :email, presence: true, 
                  format: { with: VALID_EMAIL_REGEX }, 
                  uniqueness: { case_sensitive: false } 

 #Extrae asociaciones
  def self.to_csv(persons,header,relacion)
      
      Rails.logger.info "Se genero excel desde consulta"
      column_names = header
      CSV.generate do |csv|
      csv << column_names
        
        persons.each do |item|
         if relacion == "profesorvscamarografo" 
            csv. << ['','','','','','','','','','','',                
                  item.nombre,item.apellido_paterno,item.apellido_materno,
                  item.tipo_documento_id, item.documento,
                  item.direccion,item.telefono,
                  item.celular,item.email,
                  '']
         else
             csv. << [item.nombre.encode(Encoding::UTF_8, Encoding::ISO_8859_1),
                 item.apellido_paterno.encode(Encoding::UTF_8, Encoding::ISO_8859_1),
                 item.tipo_documento_id, item.documento,
                 item.direccion,item.telefono,
                 item.celular,item.email,'','','','','','','','','']      
        end         
       end
     end
   end

  def self.send_reset_password_instructions(attributes={})
    recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    recoverable.send_reset_password_instructions if recoverable.persisted?
    recoverable
  end

  def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
    case_insensitive_keys.each { |k| attributes[k].try(:downcase!) }

    attributes = attributes.slice(*required_attributes)
    attributes.delete_if { |key, value| value.blank? }

    if attributes.size == required_attributes.size
      if attributes.has_key?(:documento)
        login = attributes.delete(:documento)
        record = where(attributes).where(["documento = :value", { :value => login }]).first
      else
        record = where(attributes).first
      end
    end

    unless record
      record = new

      required_attributes.each do |key|
        value = attributes[key]
        record.send("#{key}=", value)
        record.errors.add(key, value.present? ? error : :blank)
      end
    end
    record
  end

  def self.successfully_sent?(resource)
    notice = if Devise.paranoid
      resource.errors.clear
      #:send_paranoid_instructions
      "Hola"
    elsif resource.errors.empty?
      :send_instructions
    end

    if notice
      set_flash_message :notice, notice if is_flashing_format?
      true
    end
  end
end
