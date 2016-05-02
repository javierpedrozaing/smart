class CanalRegionalesController < ApplicationController
  before_action :authenticate_persona!
  before_action :set_canal_regional, only: [:show, :edit, :update, :destroy]
  # GET /canal_regionales
  # GET /canal_regionales.json
  def index
    @canal_regionales = CanalRegional.all
  end

  # GET /canal_regionales/1
  # GET /canal_regionales/1.json
  def show
  end

  # GET /canal_regionales/new
  def new
    @canal_regional = CanalRegional.new
  end

  # GET /canal_regionales/1/edit
  def edit
  end

  # POST /canal_regionales
  # POST /canal_regionales.json
  def create
    @canal_regional = CanalRegional.new(canal_regional_params)

    respond_to do |format|
      if @canal_regional.save
        format.html { redirect_to @canal_regional, notice: 'Canal regional was successfully created.' }
        format.json { render :show, status: :created, location: @canal_regional }
      else
        format.html { render :new }
        format.json { render json: @canal_regional.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /canal_regionales/1
  # PATCH/PUT /canal_regionales/1.json
  def update
    respond_to do |format|
      if @canal_regional.update(canal_regional_params)
        format.html { redirect_to @canal_regional, notice: 'Canal regional was successfully updated.' }
        format.json { render :show, status: :ok, location: @canal_regional }
      else
        format.html { render :edit }
        format.json { render json: @canal_regional.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /canal_regionales/1
  # DELETE /canal_regionales/1.json
  def destroy
    @canal_regional.destroy
    respond_to do |format|
      format.html { redirect_to canal_regionales_url, notice: 'Canal regional was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_canal_regional
      @canal_regional = CanalRegional.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def canal_regional_params
      params.require(:canal_regional).permit(:descripcion)
    end
end
