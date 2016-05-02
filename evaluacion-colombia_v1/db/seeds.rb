####################################################################
####################################################################
# Carga de datos de Plataforma de Evaluacion de profesores
# OGR SA
# Autor: Juan Francisco Lobos - juan.lobos@ogr.cl
####################################################################
####################################################################

require 'csv'



###################################################
# Tipos de Documentos:
###################################################

tipos_documentos = TipoDocumento.create([
	{ documento: "Tarjeta de identidad" },
	{ documento: "Cédula de ciudadanía" },
	{ documento: "Cédula de extranjería" },
	{ documento: "Contraseña" },
	{ documento: "Pasaporte" }
])
###################################################
# Estados:
###################################################

esatdos = Estado.create([
	{ estado: "Activo" },
	{ estado: "Inactivo" }
])

###################################################
# Secretarias de Educación:
###################################################

secretarias_educacion = SecretariasEducacion.create([
	{ secretaria: "Secretaria 1", region_id: 1 },
	{ secretaria: "Secretaria 2", region_id: 2 },
	{ secretaria: "Secretaria 3", region_id: 3 },
	{ secretaria: "Secretaria 4", region_id: 1 },
	{ secretaria: "Secretaria 5", region_id: 2 }
])

###################################################
# Secciones Educativas:
###################################################

secciones_educativas = SeccionesEducativa.create([
	{ seccion: "Preescolar" },
	{ seccion: "Primaria" },
	{ seccion: "Secundaria" },
	{ seccion: "Media" }
])

###################################################
# Materias:
###################################################

materias = Materia.create([
	{ materia: "Preescolar", secciones_educativas_id: nil },
	{ materia: "Primaria", secciones_educativas_id: nil },
	{ materia: "Ciencias Naturales", secciones_educativas_id: nil },
	{ materia: "Ciencias Naturales - Química", secciones_educativas_id: nil },
	{ materia: "Ciencias Naturales - Física", secciones_educativas_id: nil },
	{ materia: "Ciencias sociales", secciones_educativas_id: nil },
	{ materia: "Matemáticas", secciones_educativas_id: nil },
	{ materia: "Humanidades y  Lengua Castellana", secciones_educativas_id: nil },
	{ materia: "Idioma Extranjero Inglés", secciones_educativas_id: nil },
	{ materia: "Idioma Extranjero Francés", secciones_educativas_id: nil },
	{ materia: "Filosofía", secciones_educativas_id: nil },
	{ materia: "Educ. Física, Recreación y Deporte", secciones_educativas_id: nil },
	{ materia: "Educ. Religiosa", secciones_educativas_id: nil },
	{ materia: "Educ. Etica y Valores", secciones_educativas_id: nil },
	{ materia: "Educ. Artística - Artes escenicas", secciones_educativas_id: nil },
	{ materia: "Educ. Artística - Artes plásticas", secciones_educativas_id: nil},
	{ materia: "Educ. Artística - Danzas", secciones_educativas_id: nil },
	{ materia: "Educ. Artística - Musica", secciones_educativas_id: nil },
	{ materia: "Ciencias Económicas y Politicas", secciones_educativas_id: nil },
	{ materia: "Tecnología e Informática", secciones_educativas_id: nil },
	{ materia: "Áreas de Apoyo para Educación Especial", secciones_educativas_id: nil },
	{ materia: "Otra", secciones_educativas_id: nil}

])

###################################################
# Niveles de enseñanza:
###################################################

niveles_enseñanza = Nivel.create([
	{ nombre: "Preescolar", nivel_id: nil },
	{ nombre: "Básica Primaria (1° a 5° grado)", nivel_id: nil },
	{ nombre: "Básica secundaria y media (6° a 11° grado)", nivel_id: nil },
	{ nombre: "Ciclo complementario (Normales Superiores)", nivel_id: nil },
	{ nombre: "1°  grado", nivel_id: 2 },
	{ nombre: "2°  grado", nivel_id: 2 },
	{ nombre: "3°  grado", nivel_id: 2 },
	{ nombre: "4°  grado", nivel_id: 2 },
	{ nombre: "5°  grado", nivel_id: 2 },
  { nombre: "Multigrado", nivel_id: 2 },
	{ nombre: "6°  grado", nivel_id: 3 },
	{ nombre: "7°  grado", nivel_id: 3 },
	{ nombre: "8°  grado", nivel_id: 3 },
	{ nombre: "9°  grado", nivel_id: 3 },
	{ nombre: "10°  grado", nivel_id: 3 },
	{ nombre: "11°  grado", nivel_id: 3 }
])


###################################################
# Canales regionales:
###################################################

canales_regiones = CanalRegional.create([
	{ canal: "Canal Uno" },
	{ canal: "Canal Dos" },
	{ canal: "Canal Tres" },
	{ canal: "Canal Cuatro" },
	{ canal: "Canal Cinco" }
])

###################################################
# Grillas:
###################################################

grillas = Grilla.create([
	{ grilla: "Matematícas", materia_id: 1, seccion_educativa_id: 1},
	{ grilla: "Español"    , materia_id: 2 ,seccion_educativa_id: 2},
	{ grilla: "Ingles"     , materia_id: 3 ,seccion_educativa_id: 3},
	{ grilla: "Religión"   , materia_id: 4 ,seccion_educativa_id: 4 }
])

###################################################
# Pagina:
###################################################

paginas = Pagina.create([
	{ controller: "administracion",action: "index"},
	{ controller: "evaluador",action: "index"},
	{ controller: "observador",action: "index"},
	{ controller: "profesor",action: "index"},
	{ controller: "profesor",action: "panel"}
	
	
	
])

###################################################
# Tutorial:
###################################################
#
#tutoriales = Tutorial.create([
#	{ tutorial: "Pagina prueba 1", youtube_id: "https://www.youtube.com/watch?v=fULkbtX-YZU",pagina_id: 8, perfil_id: 25},
#	{ tutorial: "Pagina prueba 2", youtube_id: "https://www.youtube.com/watch?v=556UaYHL2vY",pagina_id: 2, perfil_id: 25},
#	{ tutorial: "Pagina prueba 3", youtube_id: "https://www.youtube.com/watch?v=556UaYHL2vY",pagina_id: 7, perfil_id: 21},
#	{ tutorial: "Pagina prueba 4", youtube_id: "https://www.youtube.com/watch?v=84Mzvag53BI",pagina_id: 20, perfil_id: 25}
 
#])


###################################################
# Video:
###################################################

#video = Video.create([
#	{ descripcion: "prueba de carga desde seed", attach_file_name:"prueba/path", attach_content_type:"jpg", attach_file_size:1024,attach_updated_at:"2015-08-15 00:00:00",video_estado_id: 2 }
#	
#])

###################################################
# video_estados:
###################################################

video_estados = VideoEstado.create([
	{ video_estado: "Grabación", video_estado_id: nil },
	{ video_estado: "Pendiente  grabación", video_estado_id: 1 },
	{ video_estado: "Proceso grabación"    , video_estado_id: 1 },
	{ video_estado: "Reasignado grabación"     , video_estado_id: 1 },
	{ video_estado: "Grabacion finalizada"   , video_estado_id: 1},
	{ video_estado: "Evaluación", video_estado_id: nil },
	{ video_estado: "Evaluado Uno"    , video_estado_id: 6 },
	{ video_estado: "evaluado Dos"     , video_estado_id: 6 },
	{ video_estado: "Evaluado Tres", video_estado_id: 6 },
	{ video_estado: "Reasignado"    , video_estado_id: 6 },
	{ video_estado: "Fin evaluación"     , video_estado_id: 6 },
	{ video_estado: "Errores Video", video_estado_id: nil },
	{ video_estado: "Reasignado"    , video_estado_id: 12 },
	{ video_estado: "Reportado por audio"     , video_estado_id: 12 },
	{ video_estado: "Reportado por video"     , video_estado_id: 12 },
	{ video_estado: "Reportado por audio y video"     , video_estado_id: 12 },
])

###################################################
# estado_evaluaciones:
###################################################

estado_evaluaciones = EstadoEvaluacion.create([
	{ estado: "Pendiente"},
	{ estado: "En proceso"},
	{ estado: "Terminada"}
])


###################################################
# TipoGrabaciones:
###################################################

tipo_grabaciones = TipoGrabacion.create([
				{ nombre: "Grabación por camarógrafos profesionales"}, 
				{ nombre: "Auto-grabación"} 
])

###################################################
# Cargos:
###################################################

cargos = Cargo.create([
	{ nombre: "Docente", rango: "", cargo_id: nil},
	{ nombre: "Directivo", rango: "", cargo_id: nil},
	{ nombre: "Directivos sindicales", rango: "", cargo_id: nil},
	{ nombre: "Docente de aula", rango: "", cargo_id: 1},
	{ nombre: "Docente orientador", rango: "", cargo_id: 1},
	{ nombre: "Docente Tutor del PTA", rango: "", cargo_id: 1},
	{ nombre: "Rector", rango: "", cargo_id: 2},
	{ nombre: "Directivo rural", rango: "", cargo_id: 2},
	{ nombre: "Coordinador", rango: "", cargo_id: 2}
])

###################################################
# Perfiles:
###################################################

# Listar usuarios normales
per_listar_profesores = Perfil.create({perfil: 'Listar Profesores', codigo: 'listar_profesores'}) 
per_listar_profesores_asignados = Perfil.create({perfil: 'Listar Profesores Asignados', codigo: 'listar_profesores_asignados'})
per_listar_evaluadores = Perfil.create({perfil: 'Listar Evaluadores', codigo: 'listar_evaluadores'})
per_listar_coordinadores = Perfil.create({perfil: 'Listar Coordinadores', codigo: 'listar_coordinadores'})
per_listar_evaluadores_asignados = Perfil.create({perfil: 'Listar Evaluadores Asignados', codigo: 'listar_evaluadores_asignados'})
per_listar_observadores = Perfil.create({perfil: 'Listar Observadores', codigo: 'listar_observadores'})
per_listar_observadores_asignados = Perfil.create({perfil: 'Listar Observadores Asignados', codigo: 'listar_observadores_asignados'})



# Editar usuarios normales
per_editar_observadores = Perfil.create({perfil: 'Editar Observadores', codigo: 'editar_observadores'})
per_editar_profesores = Perfil.create({perfil: 'Editar Profesores', codigo: 'editar_profesores'})
per_editar_evaluadores = Perfil.create({perfil: 'Editar Evaluadores', codigo: 'editar_evaluadores'})
per_editar_coordinadores = Perfil.create({perfil: 'Editar Coordinadores', codigo: 'editar_coordinadores'})

# Gestion de usuarios jefes
per_listar_jefes = Perfil.create({perfil: 'Listar Jefes', codigo: 'listar_jefes'})
per_editar_jefes = Perfil.create({perfil: 'Editar Jefes', codigo: 'editar_jefes'})

# Gestion de administradores
per_listar_administradores = Perfil.create({perfil: 'Listar Administradores', codigo: 'listar_administradores'})
per_editar_administradores = Perfil.create({perfil: 'Editar Administradores', codigo: 'editar_administradores'})
	
# Funciones asociadas a los videos
per_reportar_video = Perfil.create({perfil: 'Crear reporte de vídeo', codigo: 'reportar_video'})
per_resolver_reporte_video = Perfil.create({perfil: 'Resolver reporte vídeo', codigo: 'resolver_reporte_video'})
per_listar_videos = Perfil.create({perfil: 'Listar vídeos', codigo: 'listar_videos'})
per_aprobar_video = Perfil.create({perfil: 'Aprobar vídeo', codigo: 'aprobar_video'})
per_subir_video = Perfil.create({ perfil: 'Subir vídeo', codigo: 'subir_video' })
per_ver_muestra_video = Perfil.create({ perfil: 'Ver muestra de vídeo', codigo: 'ver_muestra_video' })
per_listar_videos_asignados = Perfil.create( { perfil: 'Listar vídeos asignados', codigo: 'listar_videos_asignados' } )

# Funciones asociadas a las evaluaciones
per_realizar_evaluacion = Perfil.create({perfil: 'Realizar evaluación', codigo: 'realizar_evaluacion'})
per_listar_evaluaciones = Perfil.create({perfil: 'Listar evaluaciones', codigo: 'listar_evaluaciones'})
per_asignar_evaluador = Perfil.create({perfil: 'Asignar tercer evaluador', codigo: 'asignar_evaluador'})
per_ver_propia_evaluacion = Perfil.create({perfil: 'Ver mi evaluación', codigo: 'ver_propia_evaluacion'})
per_listar_evaluaciones_propias = Perfil.create({perfil: 'Listar evaluaciones asignadas a uno mismo', codigo: 'listar_evaluaciones_propias'})
per_listar_evaluaciones_asignadas = Perfil.create({perfil: 'Listar evaluaciones asignadas', codigo: 'listar_evaluaciones_asignadas'})

# Funciones asociadas al administrador de la plataforma
per_parametros_evaluacion = Perfil.create({perfil: 'Asignar parametros de evaluación', codigo: 'parametros_evaluacion'})

# Permisos para gestion de noticias
per_editar_post = Perfil.create({perfil: "Gestionar noticias", codigo: 'editar_post'})

# Permisos asociados al revisor de videos
per_queue_video = Perfil.create({perfil: "Cola de Videos", codigo: 'cola_de_videos'})
per_revisar_video = Perfil.create({perfil: "Revisar Videos", codigo: 'revisar_videos'})
#Además debería tener estos
##per_reportar_video = Perfil.create({perfil: 'Crear reporte de vídeo', codigo: 'reportar_video'})
##per_aprobar_video = Perfil.create({perfil: 'Aprobar vídeo', codigo: 'aprobar_video'})

# Funciones asociadas a los reportes de jefes

#per_ver_reportes_evaluados = Perfil.create({perfil: 'Ver Reportes Evaluados', codigo: 'ver_reportes_evaluados'})
#per_ver_reportes_camarografos = Perfil.create({perfil: 'Ver Reportes Camarógrafos', codigo: 'ver_reportes_camarógrafos'})
#per_ver_reportes_coordinadores = Perfil.create({perfil: 'Ver Reportes Coordinadores', codigo: 'ver_reportes_coordinadores'})
#per_ver_reportes_evaluadores = Perfil.create({perfil: 'Ver Reportes Evaluadores', codigo: 'ver_reportes_evaluadores'})



# Funciones asociadas a los reportes de jefes

#per_ver_reportes_evaluados = Perfil.create({perfil: 'Ver Reportes Evaluados', codigo: 'ver_reportes_evaluados'})
#per_ver_reportes_camarografos = Perfil.create({perfil: 'Ver Reportes Camarógrafos', codigo: 'ver_reportes_camarógrafos'})
#per_ver_reportes_coordinadores = Perfil.create({perfil: 'Ver Reportes Coordinadores', codigo: 'ver_reportes_coordinadores'})
#per_ver_reportes_evaluadores = Perfil.create({perfil: 'Ver Reportes Evaluadores', codigo: 'ver_reportes_evaluadores'})



###################################################
# Roles de usuario
###################################################

# Super Usuario
rol_super_user = Rol.create({ rol: 'Super Usuario' })
rol_super_user.perfiles = Perfil.all

# Administrador
rol_administrador = Rol.create({ rol: 'Administrador' })
rol_administrador.perfiles = [
	# Listar todos los tipos de usuario
	per_listar_profesores, per_listar_evaluadores, per_listar_observadores, per_listar_jefes, per_listar_administradores, per_listar_coordinadores,
	# Editar usuarios
	per_editar_jefes, per_editar_evaluadores, per_editar_profesores, per_editar_observadores, per_editar_coordinadores,
	# Funciones relacionadas a videos
	per_reportar_video, per_resolver_reporte_video, per_listar_videos, per_subir_video, per_ver_muestra_video, per_listar_videos_asignados,
	# Funciones relacionadas a evaluaciones
	per_realizar_evaluacion, per_asignar_evaluador, per_listar_evaluaciones, per_ver_propia_evaluacion, per_listar_evaluaciones_propias,
	# Parametros de configuracion de app
	per_parametros_evaluacion,
	# Gestion de noticias
	per_editar_post
]
rol_administrador.save

# Jefe de Evaluadores
rol_jefe_evaluadores = Rol.create({rol: 'Jefe de Evaluadores'})
rol_jefe_evaluadores.perfiles = [
	# Listar tipos de usuario base
	per_listar_profesores, per_listar_evaluadores, per_listar_observadores, per_listar_coordinadores,
	# Editar evaluadores
	per_editar_observadores, per_editar_coordinadores, per_editar_evaluadores,
	# Funcionailidades asociadas al rol de supervisar evaluadores
	per_asignar_evaluador, per_listar_evaluaciones
]
rol_jefe_evaluadores.save

# Jefe de Observadores:
rol_jefe_observadores = Rol.create({rol: 'Jefe de Camarógrafos'})
rol_jefe_observadores.perfiles = [
	# Listar tipos de usuario base
	per_listar_profesores, per_listar_evaluadores, per_listar_observadores, per_listar_coordinadores,
	# Editar observadores
	per_editar_observadores,
	# Funcionailidades asociadas al rol de supervisar observaciones
	per_listar_videos, per_reportar_video, per_resolver_reporte_video, per_subir_video
]
rol_jefe_observadores.save

# Jefe de Evaluaciones:
rol_jefe_evaluaciones = Rol.create({rol: 'Jefe de Evaluaciones'})
rol_jefe_evaluaciones.perfiles = [
	# Listar tipos de usuario base
	per_listar_profesores, per_listar_evaluadores, per_listar_observadores, per_listar_coordinadores,
	# Funcionailidades asociadas al rol de supervisar observaciones
	per_listar_evaluaciones, per_asignar_evaluador,
	# Funciones relacionadas a subir bases de usuarios
]
rol_jefe_evaluaciones.save

# Coordinador evaluadores
rol_coordinador = Rol.create({rol: 'Coordinador'})
rol_coordinador.perfiles = [
	per_realizar_evaluacion, per_listar_evaluaciones_asignadas,
	# Funcionalidades asignadas a videos
	per_reportar_video,
	#Funcionalidades asociadas a supervisar observaciones
	per_listar_evaluaciones, per_asignar_evaluador, per_listar_evaluadores_asignados
]

# Evaluador
rol_evaluador = Rol.create({ rol: 'Evaluador' })
rol_evaluador.perfiles = [
	# Funciones de evaluador
	per_realizar_evaluacion, per_listar_evaluaciones_propias,
	# Funcionalidades asignadas a videos
	per_reportar_video
]
rol_evaluador.save	

# Observador
rol_observador = Rol.create({ rol: 'Camarógrafo' })
rol_observador.perfiles = [
	# Funcionalidades de observador
	per_subir_video, per_listar_videos_asignados
]
rol_observador.save

# Profesor
rol_profesor = Rol.create({ rol: 'Profesor' })
rol_profesor.perfiles = [
	# Perfiles asociados a videos
	per_aprobar_video, per_ver_muestra_video,
	# Perfiles asociados a evalaucion
	per_ver_propia_evaluacion
]
rol_profesor.save

# Revisor de videos
rol_revisor = Rol.create({ rol: 'Revisor de videos'})
rol_revisor.perfiles = [
  #per_parobar_ideo, 
  per_ver_muestra_video
]
rol_revisor.save
###################################################
# NotificacionTipo:
###################################################

norificaciones_tipos = NotificacionTipo.create([
	{ texto: "Validación de entidad en video", clase: "error", clase_css: "danger"},
	{ texto: "Notificación tipo2_prueba", clase: "ok", clase_css: "success"},
	{ texto: "Notificación tipo3_info", clase: "info", clase_css: "info"}
])


###################################################
# Carga de departamentos, secretarias, municipios
# e instituciones mediante el archivo enviado por 
# ICFES:
###################################################

puts "Inicio de la carga de sedes, instituciones, secreatarias, departamentos y  municipios"
	
sql = File.read('db/base_data.sql')
statements = sql.split(/;$/)
statements.pop


connection = ActiveRecord::Base.connection
ActiveRecord::Base.transaction do
	statements.each_with_index do |statement, index|
		connection.execute(statement)
		if index % 100 == 0
			print "."
		end
	end
end
puts ""
puts "Fin carga de datos minimos"


=begin

csv_text = File.read('db/data/BD_Colegios25092015.csv')
csv = CSV.parse(csv_text, :headers => true)

#Creamos hash para optimizar la carga de la BD

hash_departamentos = Hash.new
hash_municipios = Hash.new
hash_secretarias = Hash.new
hash_instituciones = Hash.new

csv.each_with_index do |row, index|
	# Departamentos
	if hash_departamentos[row["DEPTO"]].nil?
		departamento = Departamento.create( { nombre: row["DEPTO"].strip })
		hash_departamentos[row["DEPTO"]] = departamento
	else
		departamento = hash_departamentos[row["DEPTO"]]
	end
	# Municipios
	if hash_municipios[row["MUNICIPIO"]].nil?
		municipio = Municipio.create( { nombre: row["MUNICIPIO"].strip, departamento: departamento } )
		hash_municipios[row["MUNICIPIO"]] = municipio
	else
		municipio = hash_municipios[row["MUNICIPIO"]]
	end
	# Secretarias
	if hash_secretarias[row["SECRETARIA"]].nil?
		secretaria = Secretaria.create( { nombre: row["SECRETARIA"].strip, departamento: departamento } )
		hash_secretarias[row["SECRETARIA"]] = secretaria
	else
		secretaria = hash_secretarias[row["SECRETARIA"]]
	end
	# Instituciones
	if hash_instituciones[row["CODIGO_ESTABLE"]].nil?
		institucion = Institucion.create({
			nombre: row["NOMBRE_ESTABLE"].strip,
			codigo: row["CODIGO_ESTABLE"].strip,
			sector: row["SECTOR"].strip,
			zona: row["ZONA"].strip,
			municipio: municipio,
			secretaria: secretaria
		})
		hash_instituciones[row["CODIGO_ESTABLE"]] = institucion
	else
		institucion = hash_instituciones["CODIGO_ESTABLE"]
	end
	sede = Sede.create({
		nombre: row["NOMBRE_SEDE"].strip,
		codigo: row["CODIGO_SEDE"].strip,
		institucion: institucion
	})
	if index % 100 == 0
		print "."
	end
end
puts ""

=end

###################################################
# Personas:
###################################################

puts "Creando las personas de ejemplo"

# Se crea una persona por rol:

cedula = TipoDocumento.find(2)

# Profesor:
puts "  - Profesor"
profesor = Persona.new({
	nombre: "Juan",
	apellido_paterno: "Profesor",
	apellido_materno: "Profesor",
	tipo_documento_id: cedula.id,
	documento: '111111',
	direccion: "General Bolívar 2234",
	telefono: '23414424',
	celular: '843215991',
	email: 'profesor@evaluacion.co',
	password: 'lalala1234',
	password_confirmation: 'lalala1234'
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

puts "  - Profesor"
profesor_sub = Persona.new({
	nombre: "José",
	apellido_paterno: "Profesor",
	apellido_materno: "Subidor",
	tipo_documento_id: cedula.id,
	documento: '121212',
	direccion: "General Bolívar 2234",
	telefono: '23414424',
	celular: '843215991',
	email: 'profesor2@evaluacion.co',
	password: 'lalala1234',
	password_confirmation: 'lalala1234'
})
profesor_sub.profesor = Profesor.create({
	secretarias_educacion_id: 1,
	secciones_educativa_id: 1,
	estado_id: 1	,
	carga_video: true
})
profesor_sub.rol = rol_profesor
profesor_sub.save
icfes_registro = IcfesRegistro.new({pin: '1235'})
icfes_registro.persona = profesor_sub
icfes_registro.save

video = Video.create(
	profesor_id: profesor_sub.profesor.id,
	observador_id: profesor_sub.profesor.id,
	skip_file: true
)
	

# Evaluador
puts "  - Evaluador"
evaluador = Persona.new({
	nombre: "Jorge",
	apellido_paterno: "Evaluador",
	apellido_materno: "Evaluador",
	tipo_documento_id: cedula.id,
	documento: '222222',
	direccion: "General Bolívar 2234",
	telefono: '23414424',
	celular: '843215991',
	email: 'evaluador@evaluacion.co',
	password: 'lalala1234',
	password_confirmation: 'lalala1234'
})
evaluador.evaluador = Evaluador.create({
	estado_id: 1	
})
evaluador.rol = rol_evaluador
evaluador.save

puts "  - Segundo Evaluador"
evaluador02 = Persona.new({
	nombre: "Paulino",
	apellido_paterno: "Evaluador",
	apellido_materno: "Evaluador",
	tipo_documento_id: cedula.id,
	documento: '212121',
	direccion: "General Bolívar 2234",
	telefono: '23414424',
	celular: '843215991',
	email: 'evaluador02@evaluacion.co',
	password: 'lalala1234',
	password_confirmation: 'lalala1234'
})
evaluador02.evaluador = Evaluador.create({
	estado_id: 1	
})
evaluador02.rol = rol_evaluador
evaluador02.save

# Observador
puts "  - Observador"
observador = Persona.new({
	nombre: "Carlos",
	apellido_paterno: "Camarógrafo",
	apellido_materno: "Camarógrafo",
	tipo_documento_id: cedula.id,
	documento: '333333',
	direccion: "General Bolívar 2234",
	telefono: '23414424',
	celular: '843215991',
	email: 'observador@evaluacion.co',
	password: 'lalala1234',
	password_confirmation: 'lalala1234'
})
observador.observador = Observador.create({
	estado_id: 1,
	canal_regional_id: 1

})
observador.rol = rol_observador
observador.save

#Coordinador
puts "  - Coordinador"
coordinador = Persona.new({
	nombre: "Emerson",
	apellido_paterno: "Coordinador",
	apellido_materno: "Coordinador",
	tipo_documento_id: cedula.id,
	documento: '999999',
	direccion: "General Bolívar 2234",
	telefono: '23414424',
	celular: '843215991',
	email: 'coordinador@evaluacion.co',
	password: 'lalala1234',
	password_confirmation: 'lalala1234'
})
coordinador.coordinador = Coordinador.create({
	estado_id: 1
})
coordinador.rol = rol_coordinador
coordinador.coordinador.evaluadores = [evaluador.evaluador, evaluador02.evaluador]
coordinador.save


# Jefe Evaluadores
puts "  - Jefe Evaluador"
jefe_evaluador = Persona.new({
	nombre: "María",
	apellido_paterno: "Evaluador",
	apellido_materno: "Jefe",
	tipo_documento_id: cedula.id,
	documento: '444444',
	direccion: "General Bolívar 2234",
	telefono: '23414424',
	celular: '843215991',
	email: 'jefeevaluador@evaluacion.co',
	password: 'lalala1234',
	password_confirmation: 'lalala1234'

})
jefe_evaluador.rol = rol_jefe_evaluadores
jefe_evaluador.save

# Jefe Observadores
puts "  - Jefe Camarografos"
jefe_observador = Persona.new({
	nombre: "Carmén",
	apellido_paterno: "Observadores",
	apellido_materno: "Jefe",
	tipo_documento_id: cedula.id,
	documento: '555555',
	direccion: "General Bolívar 2234",
	telefono: '23414424',
	celular: '843215991',
	email: 'jefeobservadores@evaluacion.co',
	password: 'lalala1234',
	password_confirmation: 'lalala1234'
})
jefe_observador.rol = rol_jefe_observadores
jefe_observador.save

# Jefe Observadaciones
puts "  - Jefe Evaluaciones"
jefe_evaluaciones = Persona.new({
	nombre: "Carla",
	apellido_paterno: "Evaluaciones",
	apellido_materno: "Jefe",
	tipo_documento_id: cedula.id,
	documento: '666666',
	direccion: "General Bolívar 2234",
	telefono: '23414424',
	celular: '843215991',
	email: 'jefeevaluaciones@evaluacion.co',
	password: 'lalala1234',
	password_confirmation: 'lalala1234'
})
jefe_evaluaciones.rol = rol_jefe_evaluaciones
jefe_evaluaciones.save

# Administrador
puts "  - Administrador"
administrador = Persona.new({
	nombre: "Héctor",
	apellido_paterno: "Administrador",
	apellido_materno: "Administrador",
	tipo_documento_id: cedula.id,
	documento: '777777',
	direccion: "General Bolívar 2234",
	telefono: '23414424',
	celular: '843215991',
	email: 'administrador@evaluacion.co',
	password: 'lalala1234',
	password_confirmation: 'lalala1234'
})
administrador.rol = rol_administrador
administrador.save

# Super Usuario
puts "  - Super usuario"
super_usuario = Persona.new({
	nombre: "Emperador",
	apellido_paterno: "Super",
	apellido_materno: "Usuario",
	tipo_documento_id: cedula.id,
	documento: '888888',
	direccion: "General Bolívar 2234",
	telefono: '23414424',
	celular: '843215991',
	email: 'superusuario@evaluacion.co',
	password: 'lalala1234',
	password_confirmation: 'lalala1234'
})
super_usuario.rol = rol_super_user
super_usuario.save

puts "  - Revisor de videos 1"
revisor_vid_1 = Persona.new({
  nombre: "Jose",
  apellido_paterno: "Revisor1",
  apellido_materno: "UsuarioPrueba",
  tipo_documento_id: 2,
  documento: '999000',
  direccion: "General Bolívar 2234",
  telefono: '23414466',
  celular: '843215900',
  email: 'revisorvid1@evaluacion.co',
  password: 'lalala1234',
  password_confirmation: 'lalala1234'
})
revisor_vid_1.rol = rol_revisor
revisor_vid_1.save

###################################################
# Notificaciones:
###################################################

norificaciones = Notificacion.create([
	{ texto: "Notificación por seed usuario 777777", visible: true, tipo_notif_id: 1, usuario_id: 10 },
	{ texto: "Segunda notificación por seed usuario 777777", visible: true, tipo_notif_id: 2, usuario_id: 10},
	{ texto: "Notificación por seed usuario 888888", visible: true, tipo_notif_id: 1, usuario_id: 11}
])


# Tipos de Reporte
puts "Tipos de reporte:"

puts "  - Imagen"
tipo_reporte = TiposReporte.new(nombre: "Imagen")
tipo_reporte.save

puts "  - Audio"
tipo_reporte = TiposReporte.new(nombre: "Audio")
tipo_reporte.save

puts "  - Regiones"
1.upto(3) do |i|
	s = "Region" + i.to_s
	puts "  - " + s
	a = Region.new(nombre: s)
	a.save
end


