class TutorialesController < ApplicationController
  before_action :set_tutorial, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_persona!

  # GET /tutoriales
  # GET /tutoriales.json
  def index
    authorize self
    @tutoriales = Tutorial.joins(:pagina,:perfil).all
  end

  # GET /tutoriales/1
  # GET /tutoriales/1.json
  def show
    authorize self
    puts 'prueba de ajax'
    puts params[:select]
    @tutorial = Tutorial.joins(:pagina,:perfil).find(params[:id]) 
    @perfiles = Perfil.select(:id,:perfil).joins(:roles).where('roles.id'=>9)                                 
              
    render :json =>  @perfiles
  end

  # GET /tutoriales/new
  def new
    authorize self
    @tutorial = Tutorial.new
    @roles    = Rol.where('roles.id'=>[7,8,9]) 
    @paginas  = Pagina.all
    @perfiles = Perfil.all
  end

  # GET /tutoriales/1/edit
  def edit
    authorize self
    @paginas= Pagina.all
    @perfiles= Perfil.all
  end

  # POST /tutoriales
  # POST /tutoriales.json
  def create
    authorize self
    puts "envio de parametros"
    puts tutorial_params
    @tutorial = Tutorial.new(tutorial_params)

    respond_to do |format|
      if @tutorial.save
        format.html { redirect_to tutoriales_path, notice: 'Tutorial se ha creado correctamente.' }
        format.json { render :show, status: :created, location: @tutorial }
      else
        format.html { render :new }
        format.json { render json: @tutorial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tutoriales/1
  # PATCH/PUT /tutoriales/1.json
  def update
    authorize self
    respond_to do |format|
      if @tutorial.update(tutorial_params)
        format.html { redirect_to tutoriales_path, notice: 'Tutorial se ha actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @tutorial }
      else
        format.html { render :edit }
        format.json { render json: @tutorial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutoriales/1
  # DELETE /tutoriales/1.json
  def destroy
    authorize self
    @tutorial.destroy
    respond_to do |format|
      format.html { redirect_to tutoriales_url, notice: 'Tutorial se ha eliminado correctamente.' }
      format.json { head :no_content }
    end
  end
  
  def select_ajax
    puts 'prueba de ajax'
    puts params[:select]
    
    @perfiles = Perfil.select(:id,:perfil).joins(:roles).where('roles.id'=>params[:select])                                 
              
    render :json =>  @perfiles
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tutorial
      @tutorial = Tutorial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tutorial_params
      params.require(:tutorial).permit(:tutorial, :youtube_id, :pagina_id, :perfil_id )
    end
end
