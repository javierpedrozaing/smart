namespace :admin do
  desc "Crea usuarios de prueba para la plataforma"
  task usuarios_prueba: :environment do

    rol_observador = Rol.where(rol: 'Camarógrafo').first
    rol_profesor = Rol.where(rol: 'Profesor').first
    cedula = TipoDocumento.find(2)
    number = 0
    observadores_id = [0,0,0,0,0]
    5.times do |x|
      number = number + 1
      num_length = number.to_s.length
      repeat = 6 - num_length
      string = ""
      repeat.times do
        string = string + "0"
      end
      string = string + number.to_s
      name = "Camarografo" + x.to_s
      observador = Persona.new({
        nombre: name,
        apellido_paterno: "Camarógrafo",
        apellido_materno: "Camarógrafo",
        tipo_documento_id: cedula.id,
        documento: string,
        direccion: "General Bolívar 2234",
        telefono: '23414424',
        celular: '843215991',
        email: 'observador'+number.to_s+'@evaluacion.co',
        password: 'Testing1234',
        password_confirmation: 'Testing1234',
        registrado: true
      })
      observador.observador = Observador.create({
        estado_id: 1,
        canal_regional_id: 1
      
      })
      observador.rol = rol_observador
      observador.save

      observadores_id[x] = observador.observador.id
    end

    45.times do |x|

      number = number + 1
      num_length = number.to_s.length
      repeat = 6 - num_length
      string = ""
      repeat.times do
        string = string + "0"
      end
      string = string + number.to_s

      name = "Profesor-" + x.to_s
      profesor = Persona.new({
        nombre: name,
        apellido_paterno: "Profesor",
        apellido_materno: "Profesor",
        tipo_documento_id: cedula.id,
        documento: string,
        direccion: "General Bolívar 2234",
        telefono: '23414424',
        celular: '843215991',
        email: 'profesor'+number.to_s+ '@evaluacion.co',
        password: 'Testing1234',
        password_confirmation: 'Testing1234',
        registrado: true
      })
      profesor.profesor = Profesor.create({
        secretarias_educacion_id: 1,
        secciones_educativa_id: 1,
        estado_id: 1,
        carga_video: false
      })
      profesor.rol = rol_profesor
      profesor.save
      icfes_registro = IcfesRegistro.new({pin: '1234'})
      icfes_registro.persona = profesor
      icfes_registro.save


      if number > 25
        pos = number%5
        video = Video.new({
                profesor_id: profesor.profesor.id,
                observador_id: observadores_id[pos],
                skip_file: true
              })
        video.save
      else
        video = Video.new({
                profesor_id: profesor.profesor.id,
                observador_id: 0,
                skip_file: true
              })
        video.save
      end

    end
  end

end
