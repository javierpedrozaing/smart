class Pagina < ActiveRecord::Base
  has_many :tutoriales
  
  def pagina_completa
    return "#{self.controller}/#{self.action}"
  end
end

