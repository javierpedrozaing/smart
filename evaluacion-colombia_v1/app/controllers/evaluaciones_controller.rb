class EvaluacionesController < ApplicationController
  before_action :authenticate_persona!
  before_action :set_evaluacion, only: [:asignar_evaluador]

  def index
    authorize self 
    evaluaciones = Evaluacion.all
    @evaluaciones = filter_asignacion evaluaciones
  end

  def realizadas
    authorize self
    evaluaciones = Evaluacion.terminadas
    @evaluaciones = filter_asignacion evaluaciones
  end

  def pendientes
    authorize self
    evaluaciones = Evaluacion.pendientes
    @evaluaciones = filter_asignacion evaluaciones
  end

  def procesando
    evaluaciones = Evaluacion.procesando
    @evaluaciones = filter_asignacion evaluaciones
  end

  def asignar_evaluador
    authorize self
    evaluador = Persona.find(params[:evaluador_id])
    @evaluacion.evaluador = evaluador
    if @evaluacion.save
      render json: @evaluacion
    else
      render json: @evaluacion.errors, status: :unprocessable_entity
    end
  end

  private
    def filter_asignacion(evaluaciones)
      perfiles = current_persona.perfiles & ["listar_evaluaciones_asignadas"]
      if perfiles.any?
        asignadas evaluaciones, current_persona.evaluadores.map{ |x| x.id }
      else
        evaluaciones
      end
    end
    def asignadas(evaluaciones, arr_evaluadores_id)
      evaluaciones.asignadas(arr_evaluadores_id)
    end

    def set_evaluacion
      @evaluacion = Evaluacion.find(params[:id])
    end

end