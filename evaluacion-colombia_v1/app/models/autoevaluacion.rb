class Autoevaluacion < ActiveRecord::Base
  belongs_to :profesor
  belongs_to :periodo_grilla
  has_one    :autoevaluacion_respuesta
  
  def self.generar_autoevaluacion profesor_id,  periodo_grilla_id 
    #Buscamos si el docente ya tiene una evaluación
   if  self.find_by(profesor_id: profesor_id).blank?   
     self.create(profesor_id: profesor_id, periodo_grilla_id: periodo_grilla_id) 
    end    
  end
end
