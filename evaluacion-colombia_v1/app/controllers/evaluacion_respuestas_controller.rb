class EvaluacionRespuestasController < ApplicationController
  before_action :set_evaluacion_respuesta, only: [:show, :edit, :update, :destroy]

  # GET /evaluacion_respuestas
  # GET /evaluacion_respuestas.json
  def index
    @evaluacion_respuestas = EvaluacionRespuesta.all
  end

  # GET /evaluacion_respuestas/1
  # GET /evaluacion_respuestas/1.json
  def show
  end

  # GET /evaluacion_respuestas/new
  def new
    @evaluacion_respuesta = EvaluacionRespuesta.new
  end

  # GET /evaluacion_respuestas/1/edit
  def edit
  end

  # POST /evaluacion_respuestas
  # POST /evaluacion_respuestas.json
  def create
    @evaluacion_respuesta = EvaluacionRespuesta.new(evaluacion_respuesta_params)

    respond_to do |format|
      if @evaluacion_respuesta.save
        format.html { redirect_to @evaluacion_respuesta, notice: 'Evaluacion respuesta was successfully created.' }
        format.json { render :show, status: :created, location: @evaluacion_respuesta }
      else
        format.html { render :new }
        format.json { render json: @evaluacion_respuesta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /evaluacion_respuestas/1
  # PATCH/PUT /evaluacion_respuestas/1.json
  def update
    respond_to do |format|
      if @evaluacion_respuesta.update(evaluacion_respuesta_params)
        format.html { redirect_to @evaluacion_respuesta, notice: 'Evaluacion respuesta was successfully updated.' }
        format.json { render :show, status: :ok, location: @evaluacion_respuesta }
      else
        format.html { render :edit }
        format.json { render json: @evaluacion_respuesta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluacion_respuestas/1
  # DELETE /evaluacion_respuestas/1.json
  def destroy
    @evaluacion_respuesta.destroy
    respond_to do |format|
      format.html { redirect_to evaluacion_respuestas_url, notice: 'Evaluacion respuesta was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluacion_respuesta
      @evaluacion_respuesta = EvaluacionRespuesta.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evaluacion_respuesta_params
      params[:evaluacion_respuesta].permit(:valor)
    end
end
