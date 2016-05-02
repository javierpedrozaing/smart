class GrupoItemesController < ApplicationController
  before_action :set_grupo_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_persona!

  # GET /grupo_itemes
  # GET /grupo_itemes.json
  def index
    @grupo_itemes = GrupoItem.all
  end

  # GET /grupo_itemes/1
  # GET /grupo_itemes/1.json
  def show
  end

  # GET /grupo_itemes/new
  def new
    @grupo_item = GrupoItem.new
  end

  # GET /grupo_itemes/1/edit
  def edit
  end

  # POST /grupo_itemes
  # POST /grupo_itemes.json
  def create
    @grupo_item = GrupoItem.new(grupo_item_params)

    respond_to do |format|
      if @grupo_item.save
        format.html { redirect_to @grupo_item, notice: 'Grupo item fue creado con éxito.' }
        format.json { render :show, status: :created, location: @grupo_item }
      else
        format.html { render :new }
        format.json { render json: @grupo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grupo_itemes/1
  # PATCH/PUT /grupo_itemes/1.json
  def update
    respond_to do |format|
      if @grupo_item.update(grupo_item_params)
        format.html { redirect_to @grupo_item, notice: 'Grupo item fue actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @grupo_item }
      else
        format.html { render :edit }
        format.json { render json: @grupo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grupo_itemes/1
  # DELETE /grupo_itemes/1.json
  def destroy
    @grupo_item.destroy
    respond_to do |format|
      format.html { redirect_to grupo_itemes_url, notice: 'Grupo item fue eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grupo_item
      @grupo_item = GrupoItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grupo_item_params
      params[:grupo_item]
    end
end
