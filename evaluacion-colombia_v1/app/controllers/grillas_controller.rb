require 'csv'

class GrillasController < ApplicationController
  before_action :set_grilla, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_persona!  
  before_action :authorize_self 


  def authorize_self 
    authorize self 
  end
  
  # GET /grillas
  # GET /grillas.json
  def index
    # @grillas = Grilla.all.paginate(:page => params[:page], :per_page => 10)
    @grillas = Grilla.all
  end

  # GET /grillas/1
  # GET /grillas/1.json
  def show
  end

  # GET /grillas/new
  def new
    @grilla = Grilla.new
    @materia = Materia.all
    @seccion_educativa = SeccionesEducativa.all
  end

  # GET /grillas/1/edit
  def edit
    @materia = Materia.all
    @seccion_educativa = SeccionesEducativa.all
  end

  # POST /grillas
  # POST /grillas.json
  def create

    puts 'grilla_params'
    puts grilla_params
    @grilla = Grilla.new(grilla_params)

    ##Para importar el csv
    
    ####################
    
    respond_to do |format|
      if @grilla.save
        
        if(params[:import])
          csv = CSV.parse(params[:import][:csv], :headers => true)
          csv.each do |row|
          hash = row.to_hash    
          GrillaItem.create( grilla: @grilla,
                              cod_item: hash["COD_ITEM"],
                              categoria: Categoria.find_by(codigo: hash["CATEGORIA"]),
                              cod_dimension: hash["COD_DIMENSION"], 
                              cod_sub_dimension: hash["COD_SUB-DIMENSION"],
                              cod_afirmacion: hash["COD_AFIRMACIÓN"],
                              cod_evidencia: hash["COD_EVIDENCIA"],
                              item: hash["ITEM"],
                              escala: hash["ESCALA"],
                              orden_item: hash["ORDEN_ITEM"],
                              ejemplos: hash["EJEMPLOS"])
                         
          end
        end

        
        if params[:pregunta]

          for  i in 1...params[:pregunta].length + 1 #insercion de pregunta
           
            pregunta = Pregunta.new
            pregunta.grilla_id=Grilla.last.id 
            pregunta.pregunta=params[:pregunta]['pregunta_' + i.to_s]           
            pregunta.save
            params[:alternativa]
            for  j in 1...params[:alternativa].length + 1 #insercion de alternativas
              
              #validamos que no repita campos vacios
              if params[:alternativa]['alternativa_' + i.to_s + '_' + j.to_s].blank?!=true && 
                 params[:valor]['valor_' + i.to_s+ '_' + j.to_s].blank? !=true
                 
                alternativa = Alternativa.new
                alternativa.pregunta_id=Pregunta.last.id 
                alternativa.alternativa=params[:alternativa]['alternativa_' + i.to_s + '_' + j.to_s] 
                alternativa.valor_pregunta=params[:valor]['valor_' + i.to_s+ '_' + j.to_s]   
                alternativa.save
                          
                
              end
             end 
             if Alternativa.where(:pregunta_id=>Pregunta.last.id).count==0 #validamos que las preguntas sin alternativas
               
                array_sin_alternativa=[1,2,3,4] # creamos arreglo de 4 valores por defecto
                
                for y in 1...array_sin_alternativa.length + 1
               
                   alternativa = Alternativa.new
                   alternativa.pregunta_id=Pregunta.last.id 
                   alternativa.alternativa=y
                   alternativa.valor_pregunta=y   
                   alternativa.save
                 
                 end
             end
          end
        end
        
        format.html { redirect_to grillas_path, notice: 'Pauta se creo correctamente.' }
        format.json { render :show, status: :created, location: admin_grillas_path }
      else
        format.html { render :new }
        format.json { render json: @grilla.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grillas/1
  # PATCH/PUT /grillas/1.json
  def update

    if(params[:import])
      csv = CSV.parse(params[:import][:csv], :headers => true)
      csv.each do |row|
        hash = row.to_hash    
        GrillaItem.create( grilla: @grilla,
                              cod_item: hash["COD_ITEM"],
                              categoria: Categoria.find_by(codigo: hash["CATEGORIA"]),
                              cod_dimension: hash["COD_DIMENSION"], 
                              cod_sub_dimension: hash["COD_SUB-DIMENSION"],
                              cod_afirmacion: hash["COD_AFIRMACIÓN"],
                              cod_evidencia: hash["COD_EVIDENCIA"],
                              item: hash["ITEM"],
                              escala: hash["ESCALA"],
                              orden_item: hash["ORDEN_ITEM"],
                              ejemplos: hash["EJEMPLOS"])
                         
      end
    end

    respond_to do |format|
      if @grilla.update(grilla_params)
        format.html { redirect_to @grilla, notice: 'Pauta se ha actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @grilla }
      else
        format.html { render :edit }
        format.json { render json: @grilla.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grillas/1
  # DELETE /grillas/1.json
  def destroy
    @grilla.destroy
    respond_to do |format|
      format.html { redirect_to grillas_url, notice: 'Pauta was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

   # GET /grillas/1/edit
  def preview_grilla
    @grilla=Grilla.select('grillas.*, materias.materia materia').
                   joins(:asignatura).
                   where(:id=>params[:id])
                   
    @preguntas=Pregunta.select(:id,:pregunta).          
                        where(:grilla_id=>params[:id])  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grilla
      @grilla = Grilla.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grilla_params
      params.require(:grilla).permit(:materia_id, :seccion_educativa_id, :grilla, :pregunta, :alternativa, :cargo_id)
    end
end
