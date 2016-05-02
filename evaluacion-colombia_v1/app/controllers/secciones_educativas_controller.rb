class SeccionesEducativasController < ApplicationController
  before_action :set_secciones_educativa, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_persona!
  # GET /secciones_educativas
  # GET /secciones_educativas.json
  def index
    @secciones_educativas = SeccionesEducativa.all
  end

  # GET /secciones_educativas/1
  # GET /secciones_educativas/1.json
  def show
  end

  # GET /secciones_educativas/new
  def new
    @secciones_educativa = SeccionesEducativa.new
  end

  # GET /secciones_educativas/1/edit
  def edit
  end

  # POST /secciones_educativas
  # POST /secciones_educativas.json
  def create
    @secciones_educativa = SeccionesEducativa.new(secciones_educativa_params)

    respond_to do |format|
      if @secciones_educativa.save
        format.html { redirect_to @secciones_educativa, notice: 'Secciones educativa se creo correctamente.' }
        format.json { render :show, status: :created, location: @secciones_educativa }
      else
        format.html { render :new }
        format.json { render json: @secciones_educativa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /secciones_educativas/1
  # PATCH/PUT /secciones_educativas/1.json
  def update
    respond_to do |format|
      if @secciones_educativa.update(secciones_educativa_params)
        format.html { redirect_to @secciones_educativa, notice: 'Secciones educativa se actualizo correctamente.' }
        format.json { render :show, status: :ok, location: @secciones_educativa }
      else
        format.html { render :edit }
        format.json { render json: @secciones_educativa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secciones_educativas/1
  # DELETE /secciones_educativas/1.json
  def destroy
    @secciones_educativa.destroy
    respond_to do |format|
      format.html { redirect_to secciones_educativas_url, notice: 'Secciones educativa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_secciones_educativa
      @secciones_educativa = SeccionesEducativa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def secciones_educativa_params
      params.require(:secciones_educativa).permit(:descripcion)
    end
end
