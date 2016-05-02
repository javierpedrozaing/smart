class IcfesRegistrosController < ApplicationController
  before_action :authenticate_persona!
  before_action :set_icfes_registro, only: [:show, :edit, :update, :destroy]

  # GET /icfes_registros
  # GET /icfes_registros.json
  def index
    @icfes_registros = IcfesRegistro.all
  end

  # GET /icfes_registros/1
  # GET /icfes_registros/1.json
  def show
  end

  # GET /icfes_registros/new
  def new
    @icfes_registro = IcfesRegistro.new
  end

  # GET /icfes_registros/1/edit
  def edit
  end

  # POST /icfes_registros
  # POST /icfes_registros.json
  def create
    @icfes_registro = IcfesRegistro.new(icfes_registro_params)

    respond_to do |format|
      if @icfes_registro.save
        format.html { redirect_to @icfes_registro, notice: 'Icfes registro fue creado con éxito.' }
        format.json { render :show, status: :created, location: @icfes_registro }
      else
        format.html { render :new }
        format.json { render json: @icfes_registro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /icfes_registros/1
  # PATCH/PUT /icfes_registros/1.json
  def update
    respond_to do |format|
      if @icfes_registro.update(icfes_registro_params)
        format.html { redirect_to @icfes_registro, notice: 'Icfes registro fue actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @icfes_registro }
      else
        format.html { render :edit }
        format.json { render json: @icfes_registro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /icfes_registros/1
  # DELETE /icfes_registros/1.json
  def destroy
    @icfes_registro.destroy
    respond_to do |format|
      format.html { redirect_to icfes_registros_url, notice: 'Icfes registro fue eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_icfes_registro
      @icfes_registro = IcfesRegistro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def icfes_registro_params
      params.require(:icfes_registro).permit(:pin, :persona_id)
    end
end
