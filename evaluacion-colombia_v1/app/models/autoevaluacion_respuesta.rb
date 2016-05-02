class AutoevaluacionRespuesta < ActiveRecord::Base
  belongs_to :autoevaluacion
  belongs_to :grilla_autoevaluacion

  def self.crear_items_autoevaluacion grilla_id, profesor_id, autoevaluacion_id
     
      if self.joins(:autoevaluacion).where('autoevaluaciones.profesor_id'=> profesor_id).count <= GrillaAutoevaluacion.where(grilla_id: grilla_id).count
         #Recorremos arreglo para crear items de la evaluacion del evaluado
         Grilla.itemsOrdenadosAutoevalaucion(grilla_id).each {|n| 
        
           #puts 'salio item?' + autoevaluacion_id.id.to_s  + '--' + n['id'].to_s
          if !autoevaluacion_id.blank? 
            if self.where(autoevaluacion_id: autoevaluacion_id.id,grilla_autoevaluacion_id: n['id']).blank?
              self.create( autoevaluacion_id: autoevaluacion_id.id, grilla_autoevaluacion_id: n['id'])
            end
          end
         }         
         
      end
      
  end
end
