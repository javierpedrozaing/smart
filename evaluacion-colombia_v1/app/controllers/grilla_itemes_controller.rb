class GrillaItemesController < ApplicationController
  before_action :authenticate_persona!
  before_action :set_grilla_item, only: [:show, :edit, :update, :destroy]
  before_action :authorize_self

  def authorize_self 
    authorize self 
  end


  # GET /grilla_itemes
  # GET /grilla_itemes.json
  def index
    @grilla_itemes = GrillaItem.all
  end

  # GET /grilla_itemes/1
  # GET /grilla_itemes/1.json
  def show
  end

  # GET /grilla_itemes/new
  def new
    @grilla_item = GrillaItem.new
  end

  # GET /grilla_itemes/1/edit
  def edit
  end

  # POST /grilla_itemes
  # POST /grilla_itemes.json
  def create
    @grilla_item = GrillaItem.new(grilla_item_params)

    respond_to do |format|
      if @grilla_item.save
        format.html { redirect_to @grilla_item, notice: 'Pauta creada correctamente.' }
        format.json { render :show, status: :created, location: @grilla_item }
      else
        format.html { render :new }
        format.json { render json: @grilla_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grilla_itemes/1
  # PATCH/PUT /grilla_itemes/1.json
  def update
    respond_to do |format|
      if @grilla_item.update(grilla_item_params)
        format.html { redirect_to @grilla_item, notice: 'Pauta actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @grilla_item }
      else
        format.html { render :edit }
        format.json { render json: @grilla_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grilla_itemes/1
  # DELETE /grilla_itemes/1.json
  def destroy
    @grilla_item.destroy
    respond_to do |format|
      format.html { redirect_to grilla_itemes_url, notice: 'Grilla item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grilla_item
      @grilla_item = GrillaItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grilla_item_params
      params.require(:grilla_item).permit(:grilla_id, :cod_item, :categoria_id, :cod_dimension, :cod_sub_dimension, :cod_afirmacion, :cod_evidencia, :item, :escala, :orden_item, :ejemplos)
    end
end
