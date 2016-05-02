class EvaluacionController < ApplicationController
  before_action :authenticate_persona!
  
         
  def index
    authorize self
    #consultar coordinadores 
    @consulta_general=Persona.personas
                              .joins(:coordinador)
                              .paginate(:page => params[:page], :per_page => 10) 
  end

  def show
    authorize self
    @persona= Persona.personas.find(params[:id])
     
    if @persona.rol=='Evaluador'       
         @profesor=Persona.personas.
                          joins(:profesor=>:evaluaciones).
                          where('evaluaciones.evaluador_id'=>
                                Evaluador.where(:persona_id=>params[:id]).first.id).
                          paginate(:page => params[:page], :per_page => 10)                          
     else         
          @evaluadores=Persona.joins(:coordinador_evaluadores=>:evaluador).
                       where('coordinador_evaluadores.coordinador_id'=>
                              Coordinador.where('coordinadores.persona_id'=>params[:id]).pluck(:id)).                                                      
                       paginate(:page => params[:page], :per_page => 10)                  
      end                
  end
  
  def evaluadores
    authorize self
    #consultar evaluadores   
    @consulta_general=Persona.personas.
                             joins(:evaluador).                               
                             paginate(:page => params[:page], :per_page => 10)
  end
end
