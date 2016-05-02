class SecretariasEducacionesController < ApplicationController
  before_action :set_secretarias_educacion, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_persona!
  # GET /secretarias_educaciones
  # GET /secretarias_educaciones.json
  def index
    @secretarias_educaciones = SecretariasEducacion.all
  end

  # GET /secretarias_educaciones/1
  # GET /secretarias_educaciones/1.json
  def show
  end

  # GET /secretarias_educaciones/new
  def new
    @secretarias_educacion = SecretariasEducacion.new
  end

  # GET /secretarias_educaciones/1/edit
  def edit
  end

  # POST /secretarias_educaciones
  # POST /secretarias_educaciones.json
  def create
    @secretarias_educacion = SecretariasEducacion.new(secretarias_educacion_params)

    respond_to do |format|
      if @secretarias_educacion.save
        format.html { redirect_to @secretarias_educacion, notice: 'Secretarias educacion se creo correctamente.' }
        format.json { render :show, status: :created, location: @secretarias_educacion }
      else
        format.html { render :new }
        format.json { render json: @secretarias_educacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /secretarias_educaciones/1
  # PATCH/PUT /secretarias_educaciones/1.json
  def update
    respond_to do |format|
      if @secretarias_educacion.update(secretarias_educacion_params)
        format.html { redirect_to @secretarias_educacion, notice: 'Secretarias educacion se actualizo correctamente.' }
        format.json { render :show, status: :ok, location: @secretarias_educacion }
      else
        format.html { render :edit }
        format.json { render json: @secretarias_educacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secretarias_educaciones/1
  # DELETE /secretarias_educaciones/1.json
  def destroy
    @secretarias_educacion.destroy
    respond_to do |format|
      format.html { redirect_to secretarias_educaciones_url, notice: 'Secretarias educacion se destruyo correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_secretarias_educacion
      @secretarias_educacion = SecretariasEducacion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def secretarias_educacion_params
      params.require(:secretarias_educacion).permit(:descripcion)
    end
end
