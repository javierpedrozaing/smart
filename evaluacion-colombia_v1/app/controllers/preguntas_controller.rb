class PreguntasController < ApplicationController
  before_action :set_pregunta, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_persona!  
  
  # GET /preguntas
  # GET /preguntas.json
  def index
    @preguntas = Pregunta.all
    #Pregunta.select(' DISTINCT preguntas.*, alternativas.alternativa, alternativas.valor_pregunta').
                          #joins(:alternativa)                    
  end

  # GET /preguntas/1
  # GET /preguntas/1.json
  def show
   @preguntas_alternativas = Alternativa.where(:pregunta_id=>params[:id]) 
  end

  # GET /preguntas/new
  def new
    @pregunta = Pregunta.new
    @grilla = Grilla.all
  end

  # GET /preguntas/1/edit
  def edit
    @grilla = Grilla.all
  end

  # POST /preguntas
  # POST /preguntas.json
  def create
    @pregunta = Pregunta.new(pregunta_params)

   respond_to do |format|
      if @pregunta.save
        
        for  i in 1...params[:alternativa].length + 1

          alternativa = Alternativa.new
          alternativa.pregunta_id=Pregunta.last.id 
          alternativa.alternativa=params[:alternativa]['alternativa_' + i.to_s] 
          alternativa.valor_pregunta=params[:valor]['valor_' + i.to_s]   
          alternativa.save
       

        end

        format.html { redirect_to admin_preguntas_path, notice: 'Pregunta insertada correctamente.' }
        format.json { render :show, status: :created, location: @pregunta }
      else
        format.html { render :new }
        format.json { render json: @pregunta.errors, status: :unprocessable_entity }
      end
    end
    
  
   
  end

  # PATCH/PUT /preguntas/1
  # PATCH/PUT /preguntas/1.json
  def update
    respond_to do |format|
      if @pregunta.update(pregunta_params)
        format.html { redirect_to @pregunta, notice: 'Pregunta se actualizo correctamente.' }
        format.json { render :show, status: :ok, location: @pregunta }
      else
        format.html { render :edit }
        format.json { render json: @pregunta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preguntas/1
  # DELETE /preguntas/1.json
  def destroy
    @pregunta.destroy
    respond_to do |format|
      format.html { redirect_to admin_preguntas_url, notice: 'Pregunta se destruyo correctamente' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pregunta
      @pregunta = Pregunta.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pregunta_params
      params.require(:pregunta).permit(:pregunta, :grilla_id,:alternativa)
    end


end

