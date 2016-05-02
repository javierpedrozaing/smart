class VideoEstadosController < ApplicationController
  before_action :set_video_estado, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_usuario!  

  # GET /video_estados
  # GET /video_estados.json
  def index
    @video_estados = VideoEstado.all
  end

  # GET /video_estados/1
  # GET /video_estados/1.json
  def show
  end

  # GET /video_estados/new
  def new
    @video_estado = VideoEstado.new
  end

  # GET /video_estados/1/edit
  def edit
  end

  # POST /video_estados
  # POST /video_estados.json
  def create
    @video_estado = VideoEstado.new(video_estado_params)

    respond_to do |format|
      if @video_estado.save
        format.html { redirect_to @video_estado, notice: 'Video estado se creo correctamente.' }
        format.json { render :show, status: :created, location: @video_estado }
      else
        format.html { render :new }
        format.json { render json: @video_estado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /video_estados/1
  # PATCH/PUT /video_estados/1.json
  def update
    respond_to do |format|
      if @video_estado.update(video_estado_params)
        format.html { redirect_to @video_estado, notice: 'Video estado se actualizo correctamente.' }
        format.json { render :show, status: :ok, location: @video_estado }
      else
        format.html { render :edit }
        format.json { render json: @video_estado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /video_estados/1
  # DELETE /video_estados/1.json
  def destroy
    @video_estado.destroy
    respond_to do |format|
      format.html { redirect_to video_estados_url, notice: 'Video estado se destruyo correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video_estado
      @video_estado = VideoEstado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_estado_params
      params.require(:video_estado).permit(:video_estado, :video_estado_id)
    end
end
