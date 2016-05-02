class UsuariosController < ApplicationController
  before_action :authenticate_persona!
  
  def evaluadores
    authorize self
    permisos = current_persona.perfiles & ["listar_evaluadores_asignados"]
    if permisos.any?
      @evaluadores = current_persona.evaluadores
    else
      @evaluadores = Persona.evaluadores.all
    end
  end

  def profesores
    authorize self
    #@profesores = Persona.profesores.all
    if params[:page].blank?
      params[:page] = 1
    end
    @profesores = Persona.profesores.all.page(params[:page]).per(50)
    @registrados = Persona.profesores.where(registrado: true).count
    @no_registrados = Persona.profesores.where(registrado: false).count
  end

  def camarografos
    authorize self
    @camarografos = Persona.observadores.joins(:observador=>:canal_regional).joins(:observador=>:videos).select('DISTINCT personas.*,canal_regionales.canal').
                            where('observadores.id'=>Observador.joins(:videos).select('DISTINCT videos.observador_id'))
    
  end

  def coordinadores
    authorize self
    @coordinadores = Persona.coordinadores.all
  end

  def admin_evaluados
    authorize self
    @jefes_evaluacion = Persona.admin_evaluados.all
  end

  def jefe_camarografos
    authorize self
    @jefes_camarografos = Persona.jefes_observadores.all
  end

  def admin_evaluadores
    authorize self
    @jefes_evaluadores = Persona.admin_evaluadores.all
  end
  
  def revisor_videos
    authorize self
    @revisores_video = Persona.revisores.all
  end
  
  def administradores
    authorize self
    @administradores = Persona.administradores
  end
end
