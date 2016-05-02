class PersonasController < ApplicationController
  before_action :authenticate_persona!
  before_action :set_persona, only: [:show, :edit, :update, :destroy]
  require 'csv'
  # GET /personas
  # GET /personas.json
  #comentario para actualizar el git
  
  def index
    authorize self 
    @personas = Persona.all
  end

  # GET /personas/1
  # GET /personas/1.json
  def show
    #authorize :persona, :show? 
    #@persona=Persona.personas.find(params[:id])
  end

  # GET /personas/new
  def new
    authorize self 
    @persona = Persona.new
  end

  # GET /personas/1/edit
  def edit
   #authorize :persona, :edit? 
   @tipo_documento=TipoDocumento.all 
   @estados = Estado.all.distinct(:estado)
   #@path_redirection = ruta_perfiles(params[:id]);#llamamos a la url segun perfil 
  end

  # POST /personas
  # POST /personas.json
  def create
    authorize self 
    @persona = Persona.new(persona_params)
    respond_to do |format|
      if @persona.save
        format.html { redirect_to administracion_path, notice: 'Persona se ha creado correctamente.' }
        format.json { render :show, status: :created, location: @persona }
      else
        format.html { render :new }
        format.json { render json: @persona.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personas/1
  # PATCH/PUT /personas/1.json
  def update
    #authorize :persona, :update? 
    #@path_redirection = ruta_perfiles(@persona); #llamamos a la url segun perfil
    respond_to do |format|
      if @persona.update(persona_params)
        format.html { redirect_to :back, notice: 'Persona se ha actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @persona }
      else
        format.html { render :edit }
        format.json { render json: @persona.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personas/1
  # DELETE /personas/1.json
  def destroy
    authorize self
    @persona.destroy
    respond_to do |format|
      format.html { redirect_to personas_url, notice: 'Persona fue destruido con éxito.' }
      format.json { head :no_content }
    end
  end 

  def cargar_camarografos_profesores
    if !params[:archivo]
      redirect_to :back, :flash => { error: 'No ha ingresado una base csv.'}
    else
      archivo_csv = CSV.parse(params[:archivo].read.encode(Encoding::UTF_8, Encoding::UTF_8), headers: true)
      relacion_izq = { :tipo_usuario => "observadores", :modificador_usuario => "camarografo" }
      relacion_der = { :tipo_usuario => "profesores", :modificador_usuario => "profesor" }
      relacion = "observador-profesor"
      # Función creada a partir de un refactoring, a partir de la relacion y las partes izquierda y 
      # derechas definidas en el archivo crea los usuarios, o los relaciona en caso de que 
      # no hayan sido previamente relacionados.
      
      # Retorna los arrays con los errores y la cantidad de usuarios agregados y los errores que se han lanzado por la causa del error.
      errores_izq, errores_der, errores_asignacion, usuarios_izq_agregados, usuarios_der_agregados, asignados_agregados = agregar_relacion archivo_csv, relacion_izq, relacion_der, relacion
    
      flash_msgs = {}
      notice_msg = "Se agregaron #{asignados_agregados} citas para grabar vídeos entre camarógrafos ;"
      notice_msg += "Se agregaron #{usuarios_izq_agregados} camarógrafos;"
      notice_msg += "Se agregaron #{usuarios_der_agregados} profesores;"
      flash_msgs = { notice: notice_msg }

      flash_msgs = build_flash_error_msg flash_msgs, [errores_izq, errores_der, errores_asignacion]
      redirect_to :back, :flash => flash_msgs
    end
  end

  def cargar_coordinadores_evaluadores
    if !params[:archivo]
      redirect_to :back, :flash => { error: 'No ha ingresado una base csv.'}
    else
      archivo_csv = CSV.parse(params[:archivo].read.encode(Encoding::UTF_8, Encoding::UTF_8), headers: true)
      relacion_izq = { :tipo_usuario => "evaluadores", :modificador_usuario => "evaluador" }
      relacion_der = { :tipo_usuario => "coordinadores", :modificador_usuario => "coordinador" }
      relacion = "evaluador-coordinador"
      # Función creada a partir de un refactoring, a partir de la relacion y las partes izquierda y 
      # derechas definidas en el archivo crea los usuarios, o los relaciona en caso de que 
      # no hayan sido previamente relacionados.
      
      # Retorna los arrays con los errores y la cantidad de usuarios agregados y los errores que se han lanzado por la causa del error.
      errores_izq, errores_der, errores_asignacion, usuarios_izq_agregados, usuarios_der_agregados, asignados_agregados = agregar_relacion archivo_csv, relacion_izq, relacion_der, relacion
    
      flash_msgs = {}
      notice_msg = "Se agregaron #{asignados_agregados} relaciones entre evaluadores y coordinadores;"
      notice_msg += "Se agregaron #{usuarios_izq_agregados} evaluadores;"
      notice_msg += "Se agregaron #{usuarios_der_agregados} coordinadores;"
      flash_msgs = { notice: notice_msg }

      flash_msgs = build_flash_error_msg flash_msgs, [errores_izq, errores_der, errores_asignacion]
      redirect_to :back, :flash => flash_msgs
    end
  end
 
  def cargar_archivo
    tipo_usuario = params[:tipo_usuario] # Capturamos la variable del perfil a realizar la carga
    if !params[:archivo]
      redirect_to :back, :flash => { error: 'No ha ingresado una base csv.'}
    else
      errores = {}
      personas_agregadas = 0
      csv = CSV.parse(params[:archivo].read.encode(Encoding::UTF_8, Encoding::UTF_8), headers: true) 
      csv.each_with_index do |persona_row, row_index|
        puts "esto es una prueba nombre"
        puts persona_row
        personas_agregadas, errores, error = agregar_persona persona_row, row_index, tipo_usuario, personas_agregadas, errores
      end
      flash_msgs = { notice: "Se agregaron #{personas_agregadas} nuevos evaluadores" }
      flash_msgs = build_flash_error_msg flash_msgs, [errores]
      redirect_to :back, :flash => flash_msgs
    end
  end
  
  def cargar_evaluadores_coordinadores
    if !params[:archivo]
      redirect_to :back, :flash => { error: 'No ha ingresado una base csv.'}
    else
      errores = {}
      personas_agregadas = 0
      csv = CSV.parse(params[:archivo].read.encode(Encoding::UTF_8, Encoding::UTF_8), headers: true) 
      csv.each_with_index do |persona_row, row_index|
        puts "esto es una prueba coordinador evaluador"
        puts persona_row
        coordinador = Coordinador.joins(:persona).where(documento: persona_row["documento coordinador"]).first
        evaluador = Evaluador.joins(:persona).where(documento: persona_row["documento evaluador"]).first
        
        ce = CoordinadorEvaluador.where(coordinador_id: coordinador.id, evaluador_id: evaluador.id).first
        CoordinadorEvaluador.create(coordinador_id: coordinador.id, evaluador_id: evaluador.id) if ce.nil?        
      end
      flash_msgs = { notice: "Se asociaron #{personas_agregadas} nuevos evaluadores" }
      flash_msgs = build_flash_error_msg flash_msgs, [errores]
      redirect_to :back, :flash => flash_msgs
    end
  end

  def cargar_archivo_men
    if !params[:archivo]
      redirect_to :back, :flash => { error: 'No ha ingresado una base men csv.'}
    else
      errores = {}
      documentos_agregados = 0
      csv = CSV.parse(params[:archivo].read.encode(Encoding::UTF_8, Encoding::UTF_8), headers: true) 
      documento = TipoDocumento.find(2)
      csv.each_with_index do |registro_row, row_index|
        #Crear el registro_men del documento
        registro_doc_men = RegistroMen.create({tipo_documento_id: documento, documento: registro_row["NRO_DOCUMENTO"]})
        registro_doc_men.save
        documentos_agregados+=1
      end
      flash_msgs = { notice: "Se agregaron #{documentos_agregados} nuevos documentos validos por el MEN" }
         #flash_msgs = build_flash_error_msg flash_msgs, [errores]
         redirect_to :back, :flash => flash_msgs
    end
  end

  def cargar_archivo_pines
    if !params[:archivo]
      redirect_to :back, :flash => { error: 'No ha ingresado una base csv.'}
    else
      errores = {}
      personas_agregadas = 0
      csv = CSV.parse(params[:archivo].read.encode(Encoding::UTF_8, Encoding::UTF_8), headers: true) 
      documento = TipoDocumento.find(2)
      csv.each_with_index do |persona_row, row_index|
        # Revisar si el pin existe
        puts "Verificacion: IcfesRegistro.exists?"
        if !IcfesRegistro.exists?({pin: persona_row["REFERENCIA_PAGO"]})
          # Revisar si la persona existe ya en la bd
          puts "No existe IcfesRegistro"
          puts "Verificacion: Persona.exists? con documento y tipo_documento igual"
          #if !Persona.exists?({documento: persona_row["DOCUMENTO"], tipo_documento: documento})
              puts "No existe Persona con la condicion"
            # Verificar si el mail ya existe en la bd
            
              # Crear el pin
              icfes_pin = IcfesRegistro.create({pin: persona_row["REFERENCIA_PAGO"]})
              # Crear al pelotudo
              pass = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
              persona = Persona.create({
                nombre: persona_row["NOMBRES"],
                apellido_paterno: persona_row["APELLIDOS"],
                documento: persona_row["DOCUMENTO"],
                tipo_documento: documento,
                email: persona_row["EMAIL"],
                registrado: false,
                password: pass,
                password_confirmation: pass
              })
              persona.profesor = Profesor.create({
                estado_id: 1
              })
              persona.rol = Rol.profesor.first
              # Vincular a ambos 
              icfes_pin.persona = persona
              # Guardarlos
              #persona.valid?
              #persona.errors.each{|attr,msg| puts "#{attr} - #{msg}" }
              persona.save(validate: false)
              #persona.save
              icfes_pin.save
              personas_agregadas+=1
              ##bloque del if de mail
          #else
          # Agregar error de persona repetida
          #end
        else
          # Agregar error de pin repetido
        end
      end
      flash_msgs = { notice: "Se agregaron #{personas_agregadas} nuevos evaluados" }
      #flash_msgs = build_flash_error_msg flash_msgs, [errores]
      redirect_to :back, :flash => flash_msgs
    end
  end

  #Se crea esta clase para poder cargar los registro de personas no inscritas los dias 26,27 y 28 de octubre
  def cargar_archivo_fecode
    if !params[:archivo]
      redirect_to :back, :flash => { error: 'No ha ingresado una base csv.'}
    else
      errores = {}
      personas_agregadas = 0
      csv = CSV.parse(params[:archivo].read.encode(Encoding::UTF_8, Encoding::UTF_8), headers: true) 
      
      csv.each_with_index do |persona_row, row_index|
        documento = TipoDocumento.find(persona_row["TIPO_DOCUMENTO"])
        pass = (0...50).map { ('a'..'z').to_a[rand(26)] }.join #generar clave aleatoria
        # Revisar si el pin existe
        puts "Verificacion: IcfesRegistro.exists?"          
        if !IcfesRegistro.exists?({pin: persona_row["REFERENCIA_PAGO"]})
          # Revisar si la persona existe ya en la bd
          puts "No existe IcfesRegistro"
          puts "Verificacion: Persona.exists? con documento y tipo_documento igual"
          #if !Persona.exists?({documento: persona_row["DOCUMENTO"], tipo_documento: documento})
              puts "No existe Persona con la condicion"
            # Verificar si el mail ya existe en la bd
            #validamos que la base traiga el password
          if !persona_row["PASSWORD"].nil?
               puts 'salio el password ingresado'
               puts persona_row["PASSWORD"]
               pass=persona_row["PASSWORD"]
           end 
 
              # Crear el pin
              icfes_pin = IcfesRegistro.create({pin: persona_row["REFERENCIA_PAGO"]})
              # Crear al pelotudo              
              persona = Persona.create({
                nombre: persona_row["NOMBRES"],
                apellido_paterno: persona_row["APELLIDOS"],
                documento: persona_row["DOCUMENTO"],
                tipo_documento: documento,
                email: persona_row["EMAIL"],
                telefono: persona_row["TELEFONO"],
                celular: persona_row["CELULAR"],
                direccion: persona_row["DIRECCION"],
                registrado: true,
                password: pass,
                password_confirmation: pass
              })
              persona.profesor = Profesor.create({
                estado_id: 1,
                materia_id: persona_row["MATERIA_ID"],
                nivel_id:   persona_row["GRADO_ID"],
                cargo_id:   persona_row["SUBCARGO _ID"],
                tipo_grabacion_id: persona_row["TIPO_GRABACION_ID"],
                institucion_id: persona_row["INSTITUCION_ID"],
                sede_id: persona_row["SEDE_ID"],
                
              })
              persona.rol = Rol.profesor.first
              # Vincular a ambos 
              icfes_pin.persona = persona
              # Guardarlos
              #persona.valid?
              #persona.errors.each{|attr,msg| puts "#{attr} - #{msg}" }
              persona.save(validate: false)
              #persona.save
              icfes_pin.save
              personas_agregadas+=1
              ##bloque del if de mail
          #else
          # Agregar error de persona repetida
          #end
        else
          # Actualizacion  de pin repetido          
          persona_select= Persona.joins(:profesor).joins(:icfes_registro).
                                  where('icfes_registros.pin'=>persona_row["REFERENCIA_PAGO"]).first          
      
          if Persona.joins(:profesor).joins(:icfes_registro).
                                  where('icfes_registros.pin'=>persona_row["REFERENCIA_PAGO"]).exists?                   
                                       
          Persona.update(persona_select[:id].to_i,                         
                         :nombre=>persona_row["NOMBRES"],
                         :apellido_paterno=>persona_row["APELLIDOS"],
                         :documento=>persona_row["DOCUMENTO"],
                         :tipo_documento=>documento,
                         :email=>persona_row["EMAIL"],
                         :telefono=>persona_row["TELEFONO"],
                         :celular=>persona_row["CELULAR"],
                         :direccion=>persona_row["DIRECCION"],
                         :registrado=>true,
                         :password=>pass,
                         :password_confirmation=>pass
                          )
          profesor_select = Profesor.where(:persona_id=>persona_select[:id].to_i).first          
          puts 'Salida Profesor fecode'
         

          Profesor.update(profesor_select[:id].to_i, 
                           :materia_id=>persona_row["MATERIA_ID"],
                           :nivel_id=>persona_row["GRADO_ID"],
                           :cargo_id=>persona_row["SUBCARGO _ID"],
                           :tipo_grabacion_id=>persona_row["TIPO_GRABACION_ID"],
                           :institucion_id=>persona_row["INSTITUCION_ID"],
                           :sede_id=>persona_row["SEDE_ID"])
                           
            if !Video.where({profesor_id:profesor_select[:id].to_i}).exists? && 
                persona_row["TIPO_GRABACION_ID"] == 2
                
               video = Video.new({
                  profesor_id: profesor_select[:id].to_i,
                  observador_id: 0,
                  skip_file: true
                })
                
               video.save
            end                 
          
          personas_agregadas+=1
          end
        end
      end
      flash_msgs = { notice: "Se agregaron #{personas_agregadas} nuevos evaluados" }
      #flash_msgs = build_flash_error_msg flash_msgs, [errores]
      redirect_to :back, :flash => flash_msgs
    end
  end

  #Proceso de pico y placa para evaluados que pueden subir un video 
  def cargar_archivo_pico_y_placa
    if !params[:archivo]
      redirect_to :back, :flash => { error: 'No ha ingresado una base csv.'}
    else
      errores = {}
      personas_agregadas = 0
      #Desabilitamos los evaluados que estaban con pico y placa true
      Persona.profesores.where(:pico_placa=>true).each { |n| n.update_attribute(:pico_placa, nil) }    
      csv = CSV.parse(params[:archivo].read.encode(Encoding::UTF_8, Encoding::UTF_8), headers: true) 
       csv.each_with_index do |persona_row, row_index|
        # Revisar si el pin existe
        puts "Verificacion: IcfesRegistro.exists? pico placa"
        if IcfesRegistro.exists?({pin: persona_row["REFERENCIA_PAGO"]})

        persona_select= Persona.joins(:profesor).joins(:icfes_registro).
                                  where('icfes_registros.pin'=>persona_row["REFERENCIA_PAGO"],"profesores.tipo_grabacion_id"=>[1,2]).
                                  first          
      
          if Persona.joins(:profesor).joins(:icfes_registro).
                                  where('icfes_registros.pin'=>persona_row["REFERENCIA_PAGO"],"profesores.tipo_grabacion_id"=>[1,2]).exists?                   
                                       
          Persona.update(persona_select[:id].to_i,                         
                         :pico_placa =>true                        
                          )
          profesor_select = Profesor.where(:persona_id=>persona_select[:id].to_i).first          
          puts 'Salida Profesor pico placa'
          puts profesor_select[:id].to_i    
                     
          if !Video.where({profesor_id:profesor_select[:id].to_i}).exists?
            if persona_row["TIPO_GRABACION_ID"] === '2' #Tipo de grabacion autograbación
              video = Video.new({
                profesor_id: profesor_select[:id].to_i,
                observador_id: 0,
                skip_file: true
              })
              
             video.save
             end
          end                 
          
          personas_agregadas+=1
        end
      end
     end #each csv
      flash_msgs = { notice: "Se habilitaron para pico y placa a #{personas_agregadas} evaluados" }
      redirect_to :back, :flash => flash_msgs
    end
  end
  
  #creamos el archivo csv para las relaciones
  def export_csv
      relacion= params[:tipo_relacion]   # Variable de relacion
     if params[:tipo_relacion]  == "profesorvscamarografo"
       #consulta de datos
       consulta_relacion = Persona.select("personas.*, profesores.*").joins(:profesor).
                                   where.not(:id=>Persona.joins(:profesor=>:video).pluck(:id),:registrado=>false).
                                   where("profesores.tipo_grabacion_id = 1")
       headers = [
                  'camarografo pin',
                  'camarografo nombre',
                  'camarografo apellido paterno',
                  'camarografo apellido materno',
                  'camarografo tipo documento',
                  'camarografo documento',
                  'camarografo direccion',
                  'camarografo telefono',
                  'camarografo celular',
                  'camarografo email',
                  'camarografo canal regional',
                  'profesor nombre',
                  'profesor apellido paterno',
                  'profesor apellido materno',
                  'profesor tipo documento',
                  'profesor documento',
                  'profesor direccion',
                  'profesor telefono',
                  'profesor celular',
                  'profesor email',
                  'fecha grabacion']
      else
       #consulta de datos
       consulta_relacion = Persona.evaluadores.where.not(:id=>Persona.joins(:evaluador=>:coordinadores).
                                                         pluck(:id))
       headers = ['evaluador nombre',
                  'evaluador apellido paterno',                  
                  'evaluador tipo documento',
                  'evaluador documento',
                  'evaluador direccion',
                  'evaluador telefono',
                  'evaluador celular',
                  'evaluador email',
                  'coordinador nombre',
                  'coordinador apellido paterno',
                  'coordinador apellido materno',
                  'coordinador tipo documento',
                  'coordinador documento',
                  'coordinador direccion',
                  'coordinador telefono',
                  'coordinador celular',
                  'coordinador email']
     end
      #Nombre archivo csv
      fname = "#{params[:tipo_relacion]}_#{DateTime.now.to_i}"
      #Download de csv
      send_data consulta_relacion.to_csv(consulta_relacion,headers,relacion).encode(Encoding::UTF_8, Encoding::UTF_8),
        :type => 'text/csv; charset=UTF_8; header=present',
        :disposition => "attachment; filename=#{fname}.csv"
   end
   
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_persona
      @persona = Persona.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def persona_params
      params.require(:persona).permit(:nombre, :apellido_paterno, :apellido_materno, :tipo_documento_id, :documento, :direccion, :telefono, :celular, :email,:archivo,:canal,:tipo_documento_profesor, :documento_profesor, :date, :estado_id)
    end

    # Generalizacion del metodo anterior para extenderlo para todo tipo de usuario
    def is_valid_usuario relacion_row, tipo_usuario, modificador_usuario
      errores = []
      # Modificamos el modificador de modo que funcione el metodo
      if modificador_usuario.length > 0
        modificador_usuario += " "
      end
      if Persona.where({tipo_documento_id: relacion_row["#{modificador_usuario}tipo documento"], documento: relacion_row["#{modificador_usuario}documento"]}).count > 0
        errores.push("documento_repetido") #jeyson se habilita por que se repiten usuarios
       
      end

      if TipoDocumento.where(:id => relacion_row["#{modificador_usuario}tipo documento"]).count ==0
        errores.push("tipo_documento_invalido")
      end
      if !EmailValidator.valid?(relacion_row["#{modificador_usuario}email"])
        errores.push("email_invalido")
      end
      if Persona.where(:email => relacion_row["#{modificador_usuario}email"]).count > 0
        errores.push("email_repetido")
      end
      case tipo_usuario
      #when "profesores"
        #if SeccionesEducativa.where(:id => relacion_row["#{modificador_usuario}seccion"]).count == 0
         # errores.push("seccion_educativa_invalida")
       # end
        #if SecretariasEducacion.where(:id => relacion_row["#{modificador_usuario}secretaria educacion"]).count == 0
         # errores.push("secretaria_educacion_invalida")
        #end
        #puts 'se comentare porque en la carga de profesor vs camarografo no va'
      when "observadores"
        if CanalRegional.where(:id => relacion_row["#{modificador_usuario}canal regional"]).count == 0
          errores.push("canal_regional_invalido")
        end
      end
      errores
    end

    # Encapsulacion de la funcion de si es persona valida
    def persona_exists relacion_row, tipo_usuario, modificador_usuario
      errores = is_valid_usuario relacion_row, tipo_usuario, modificador_usuario

      if errores
        puts "hubo errores en PERSONA EXISTS"
      end
      # Si existe el documento o el email la persona ya esta repetida
      existencia = errores & ["documento_repetido", "email_repetido"]
      existencia.any?
      #false
    end

    def create_msg_errores errores, header_msg
      if header_msg.length > 0
        header_msg = " "+header_msg
      end
      error_list = ""
      errores.each_with_index do |error, error_index|
        error_list += " en filas #{error.pop} por #{error.pop}; "
      end
      error_msg = "Errores en las filas#{header_msg}:\n #{error_list}"
      error_msg
    end

    def build_flash_error_msg flash_msgs, errores_arr
      error_msg = ""
      error = false
      errores_arr.each do |errores|
        if !errores.empty? 
          error_msg += create_msg_errores errores, ""
          error = true
        end
      end
      if error
        flash_msgs[:error] = error_msg
      end
      flash_msgs
    end

    # Acumula los errores de procesamiento
    def add_errores errores, row_index, persona_errores
      persona_errores.each do |error|
        if errores[error].nil?
          errores[error] = []
        end
        errores[error].push(row_index+2)
      end
      errores
    end

    # Agrega una relacion a partir del archivo csv, se debe explicitar el lado izquierdo y el lado derecho
    # Datos de entrada:
    # => archivo_csv -> Buffer de archivo csv abierto
    # => relacion -> La relacion a ser creada via el archivo
    # => relacion_izq, relacion_derecha -> Hash con la info del tipo de usuario que debe ser utilizado
    #    relacion_izg = { :tipo_usuario, :modificador_usuario}
    def agregar_relacion archivo_csv, relacion_izq, relacion_der, relacion
      errores_izq, errores_der, errores_asignacion = {}, {}, {"relacion_ya_existente" => [], "error_asignacion" => []}
      usuarios_izq_agregados, usuarios_der_agregados, asignados_agregados = 0, 0, 0
      archivo_csv.each_with_index do |relacion_row, row_index|
       
        
        usuario_izq, usuarios_izq_agregados, errores_izq, error_izq = get_usuario_para_relacionar relacion_row, row_index, relacion_izq, usuarios_izq_agregados, errores_izq
        usuario_der, usuarios_der_agregados, errores_der, error_der = get_usuario_para_relacionar relacion_row, row_index, relacion_der, usuarios_der_agregados, errores_der
        puts "Error Izq: " << error_izq.to_json
        puts "Error Der: " << error_der.to_json
 
        if !error_izq && !error_der
          # Verificamos el tipo de relacion que se esta creando:
          case relacion
          when "evaluador-coordinador"
            evaluador, coordinador = [usuario_izq, usuario_der]
            if !coordinador.coordinador.evaluadores.where({id: evaluador.evaluador.id }).exists?
              coordinador.coordinador.evaluadores.push(evaluador.evaluador)
              # Guardamos los datos
              if coordinador.save
                asignados_agregados += 1
              else
                errores_asignacion["error_asignacion"].push(row_index+2)
              end
            else
              errores_asignacion["relacion_ya_existente"].push(row_index+2)
            end 
          when "observador-profesor"
            observador, profesor = [usuario_izq, usuario_der]
            # Relacionamos profesor y camarografo a traves de video
         
            if !Video.where({profesor_id: profesor.profesor.id, observador_id: observador.observador.id }).exists?
              video = Video.new({
                profesor_id: profesor.profesor.id,
                observador_id: observador.observador.id,
                skip_file: true,
                fecha_grabacion: relacion_row["fecha grabacion"]
                
                
              })
              # Guardamos los datos
              if video.save
                asignados_agregados += 1
              else
                errores_asignacion["error_asignacion"].push(row_index+2)
              end
            else
              errores_asignacion["relacion_ya_existente"].push(row_index+2)
            end 
          end
        end
      end
      [errores_izq, errores_der, errores_asignacion, usuarios_izq_agregados, usuarios_der_agregados, asignados_agregados]
    end

    def get_usuario_para_relacionar relacion_row, row_index, usuario_relacion, contador_usuarios_agregados, errores_tipo_usuario
      # Chequeamos si existe el evaluador o si no lo creamos
      error = false
     if !persona_exists relacion_row, usuario_relacion[:tipo_usuario], usuario_relacion[:modificador_usuario]
        contador_usuarios_agregados, errores_tipo_usuario, error = agregar_usuario relacion_row, row_index, usuario_relacion[:tipo_usuario], usuario_relacion[:modificador_usuario], contador_usuarios_agregados, errores_tipo_usuario
        usuario = Persona.where({documento: relacion_row["#{usuario_relacion[:modificador_usuario]} documento"]}).first
        puts "if getusuario" 
      else
        puts "else getusuario"
        usuario = Persona.where({documento: relacion_row["#{usuario_relacion[:modificador_usuario]} documento"]}).first
      end
      [usuario, contador_usuarios_agregados, errores_tipo_usuario, error]
    end

    def crear_persona persona_row, tipo_usuario, modificador_usuario
      # Modificamos el modificador de modo que funcione el metodo
      #codigo para actualizar el git
      if modificador_usuario.length > 0
        modificador_usuario += " "
      end
      puts "salida de nombre"
      puts persona_row["nombre"]
      
      pass = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
      pin  = (0...15).map { (1..20).to_a[rand(26)] }.join
      puts "crear persona antes del new"
      
      persona = Persona.new({
        nombre: persona_row["#{modificador_usuario}nombre"],
        apellido_paterno: persona_row["#{modificador_usuario}apellido paterno"],
        apellido_materno: persona_row["#{modificador_usuario}apellido materno"],
        tipo_documento_id: persona_row["#{modificador_usuario}tipo documento"],
        documento: persona_row["#{modificador_usuario}documento"],
        direccion: persona_row["#{modificador_usuario}direccion"],
        telefono: persona_row["#{modificador_usuario}telefono"],
        celular: persona_row["#{modificador_usuario}celular"],
        email: persona_row["#{modificador_usuario}email"],
        registrado: false,
        password: pass,
        password_confirmation: pass  
      })
      puts "crear persona despues del new"
      # Se agregan los campos especiales por usuario
      case tipo_usuario
      # No hay caso especial para evaluador
      when "evaluadores"
        rol = Rol.evaluador.first
        persona.evaluador = Evaluador.create({
          estado_id: 1,
          cargo_id: persona_row["#{modificador_usuario}cargo_id"],
          nivel_id: persona_row["#{modificador_usuario}nivel_id"],
          departamento_id: persona_row["#{modificador_usuario}departamento_id"],
          nivelpar_id: persona_row["#{modificador_usuario}nivelpar_id"],
          materia_id: persona_row["#{modificador_usuario}materia_id"]
          
        })
        icfes_registro = IcfesRegistro.new({pin: pin})
        icfes_registro.persona = persona
        icfes_registro.save
      when "profesores"
        puts "CREAR_PERSONA: inicio profesores"
        rol = Rol.profesor.first
        # Validamos campos adicionales de profesor
        persona.profesor = Profesor.create({
          estado_id: 1,
          secretarias_educacion_id: persona_row["#{modificador_usuario}secretaria educacion"],
          secciones_educativa_id: persona_row["#{modificador_usuario}seccion"],
          carga_video: false
        })
        puts "CREAR_PERSONA : fin profesor create"
        puts "CREAR_PERSONA : inicio icfes_registro create"
        icfes_registro = IcfesRegistro.new({pin: persona_row["#{modificador_usuario}pin"]})
        icfes_registro.persona = persona
        icfes_registro.save
        puts "CREAR_PERSONA : fin icfes_registro create"
      when "observadores"
        rol = Rol.observador.first
        # Validamos campos adicionales de camarografo
        persona.observador = Observador.create({
          estado_id: 1,
          canal_regional_id: persona_row["#{modificador_usuario}canal regional"]
        })
        
        icfes_registro = IcfesRegistro.new({pin: pin})
        icfes_registro.persona = persona
        icfes_registro.save
          
      when "coordinadores"
        rol = Rol.coordinador.first
        persona.coordinador = Coordinador.create({
          estado_id: 1
        })
      when "admin_evaluadores"
        rol = Rol.admin_evaluadores.first  
              
      when "jefe_camarografos"
        rol = Rol.jefe_observadores.first  
        
      when "admin_evaluados"
        rol = Rol.admin_evaluados.first
      #when "jefe_evaluaciones"
      #  rol = Rol.jefe_evaluacion.first
      when "revisor_video"
        rol = Rol.revisor.first       
      when "administrador"
        rol = Rol.administrador.first    
        
      end
      persona.rol = rol
      #persona.save!
      persona.valid?
      persona.errors.each{|attr,msg| puts "#{attr} - #{msg}" }
      persona.save(validate: false)
    end

    def agregar_usuario persona_row, row_index, tipo_usuario, modificador_usuario, personas_agregadas, errores
      # Agregamos la validacion de persona
      persona_errores = is_valid_usuario persona_row, tipo_usuario, modificador_usuario
      error = false
      if persona_errores.count == 0
        if crear_persona persona_row, tipo_usuario, modificador_usuario
          personas_agregadas += 1 
        else
          puts "Error misterioso mail:"
          puts persona_errores.count
          puts persona_errores.to_s
          persona_errores = ["error_de_formato_usuario"]
          errores = add_errores errores, row_index, persona_errores
          error = true
        end
      else
        errores = add_errores errores, row_index, persona_errores
        error = true
      end
      [ personas_agregadas, errores, error ]
    end

    def agregar_persona persona_row, row_index, tipo_usuario, personas_agregadas, errores
      agregar_usuario persona_row, row_index, tipo_usuario, "", personas_agregadas, errores
    end
    
    def crear_test_video
      puts "Hola creador test de videos"
    end
end
