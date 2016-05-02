# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160423144615) do

  create_table "archivos_personas", force: :cascade do |t|
    t.integer  "persona_id"
    t.integer  "tipo"
    t.string   "archivo_file_name"
    t.string   "archivo_content_type"
    t.integer  "archivo_file_size"
    t.datetime "archivo_updated_at"
  end

  create_table "autoevaluacion_respuestas", force: :cascade do |t|
    t.integer  "autoevaluacion_id"
    t.integer  "grilla_autoevaluacion_id"
    t.string   "valor"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "pagina",                   limit: 2
    t.integer  "registro_obligatorio",     limit: 2
  end

  add_index "autoevaluacion_respuestas", ["grilla_autoevaluacion_id"], name: "index_autoevaluacion_respuestas_on_grilla_autoevaluacion_id"

  create_table "autoevaluaciones", force: :cascade do |t|
    t.integer  "profesor_id"
    t.integer  "periodo_grilla_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "autoevaluaciones", ["profesor_id"], name: "index_autoevaluaciones_on_profesor_id", unique: true

  create_table "canal_regionales", force: :cascade do |t|
    t.string   "canal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cargos", force: :cascade do |t|
    t.string  "nombre"
    t.integer "rango"
    t.integer "cargo_id"
  end

  create_table "categorias", force: :cascade do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "cargo_id"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "coordinador_evaluaciones", force: :cascade do |t|
    t.integer  "coordinador_id", null: false
    t.integer  "evaluacion_id",  null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "coordinador_evaluaciones", ["coordinador_id"], name: "index_coordinador_evaluaciones_on_coordinador_id"
  add_index "coordinador_evaluaciones", ["evaluacion_id"], name: "index_coordinador_evaluaciones_on_evaluacion_id"

  create_table "coordinador_evaluadores", force: :cascade do |t|
    t.integer  "evaluador_id"
    t.integer  "coordinador_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "coordinador_evaluadores", ["coordinador_id"], name: "index_coordinador_evaluadores_on_coordinador_id"
  add_index "coordinador_evaluadores", ["evaluador_id"], name: "index_coordinador_evaluadores_on_evaluador_id"

  create_table "coordinador_reportes", force: :cascade do |t|
    t.integer  "coordinador_id", null: false
    t.integer  "reporte_id",     null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "evaluacion_id"
  end

  add_index "coordinador_reportes", ["coordinador_id"], name: "index_coordinador_reportes_on_coordinador_id"
  add_index "coordinador_reportes", ["evaluacion_id"], name: "index_coordinador_reportes_on_evaluacion_id"
  add_index "coordinador_reportes", ["reporte_id"], name: "index_coordinador_reportes_on_reporte_id"

  create_table "coordinadores", force: :cascade do |t|
    t.integer  "estado_id"
    t.integer  "persona_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "coordinadores", ["estado_id"], name: "index_coordinadores_on_estado_id"
  add_index "coordinadores", ["persona_id"], name: "index_coordinadores_on_persona_id"

  create_table "departamentos", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "region_id"
  end

  add_index "departamentos", ["nombre"], name: "index_departamentos_on_nombre"
  add_index "departamentos", ["region_id"], name: "index_departamentos_on_region_id"

  create_table "escalas", force: :cascade do |t|
    t.string   "nombre",     limit: 30
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "estado_evaluaciones", force: :cascade do |t|
    t.string   "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estado_revision_videos", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estados", force: :cascade do |t|
    t.string   "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluacion_respuestas", force: :cascade do |t|
    t.integer  "evaluacion_id"
    t.integer  "grilla_item_id"
    t.string   "valor"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "numero_actividad"
    t.string   "actividad_obligatoria"
  end

  add_index "evaluacion_respuestas", ["evaluacion_id"], name: "index_evaluacion_respuestas_on_evaluacion_id"
  add_index "evaluacion_respuestas", ["grilla_item_id"], name: "index_evaluacion_respuestas_on_grilla_item_id"

  create_table "evaluaciones", force: :cascade do |t|
    t.integer  "evaluador_id"
    t.integer  "profesor_id"
    t.integer  "video_id"
    t.string   "contenido_evaluacion"
    t.integer  "valor"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "estado_evaluacion_id", default: 1
    t.integer  "orden"
  end

  create_table "evaluador_secciones", force: :cascade do |t|
    t.integer "evaluador_id"
    t.integer "secciones_educativa_id"
  end

  create_table "evaluadores", force: :cascade do |t|
    t.integer  "estado_id"
    t.integer  "persona_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "cargo_id"
    t.integer  "grado_academico_id"
    t.integer  "secretarias_educacion_id"
    t.integer  "departamento_id"
    t.integer  "nivel_id"
    t.integer  "nivelpar_id"
    t.integer  "materia_id"
  end

  add_index "evaluadores", ["estado_id"], name: "index_evaluadores_on_estado_id"
  add_index "evaluadores", ["materia_id"], name: "index_evaluadores_on_materia_id"
  add_index "evaluadores", ["nivel_id"], name: "index_evaluadores_on_nivel_id"
  add_index "evaluadores", ["nivelpar_id"], name: "index_evaluadores_on_nivelpar_id"
  add_index "evaluadores", ["persona_id"], name: "index_evaluadores_on_persona_id"

  create_table "evidencia_formes", force: :cascade do |t|
    t.integer  "profesor_id"
    t.string   "departamento",                       null: false
    t.string   "municipio",                          null: false
    t.string   "cargo",                              null: false
    t.string   "ultimo_nivel_educativo"
    t.string   "nivel"
    t.string   "area",                               null: false
    t.string   "grado",                              null: false
    t.string   "modelo_educativo",                   null: false
    t.string   "tiempo_laborado_institucion"
    t.string   "tiempo_docente_estudiantes"
    t.integer  "numero_estudiantes",                 null: false
    t.integer  "numero_estudiantes_consentimiento",  null: false
    t.datetime "fecha_clase_grabada",                null: false
    t.string   "desarrollo_tematico"
    t.text     "propositos_objetivos"
    t.text     "relacion_planes"
    t.text     "planeacion_pei"
    t.text     "organizacion_contenidos"
    t.text     "planeacion_aspectos_criterios"
    t.text     "materiales_recursos"
    t.text     "evaluacion_retroalimentacion_clase"
    t.text     "metodologias_estrategias_empleadas"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "grados_academicos", force: :cascade do |t|
    t.string  "nombre"
    t.integer "rango"
  end

  create_table "grilla_autoevalaciones", force: :cascade do |t|
    t.integer  "grilla_id"
    t.string   "codigo_item", limit: 10
    t.integer  "posicion"
    t.integer  "escala_id"
    t.string   "instruccion", limit: 1000
    t.string   "rv",          limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "grilla_autoevalaciones", ["escala_id"], name: "index_grilla_autoevalaciones_on_escala_id"
  add_index "grilla_autoevalaciones", ["grilla_id"], name: "index_grilla_autoevalaciones_on_grilla_id"

  create_table "grilla_autoevaluaciones", force: :cascade do |t|
    t.integer  "grilla_id"
    t.string   "codigo_item", limit: 10
    t.integer  "posicion"
    t.integer  "escala_id"
    t.string   "instruccion", limit: 1000
    t.string   "rv",          limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "grilla_autoevaluaciones", ["escala_id"], name: "index_grilla_autoevaluaciones_on_escala_id"
  add_index "grilla_autoevaluaciones", ["grilla_id"], name: "index_grilla_autoevaluaciones_on_grilla_id"

  create_table "grilla_itemes", force: :cascade do |t|
    t.integer  "grilla_id"
    t.string   "cod_item"
    t.integer  "categoria_id"
    t.string   "cod_dimension"
    t.string   "cod_sub_dimension"
    t.string   "cod_afirmacion"
    t.string   "cod_evidencia"
    t.string   "item"
    t.string   "escala"
    t.integer  "orden_item"
    t.string   "ejemplos"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "grilla_itemes", ["categoria_id"], name: "index_grilla_itemes_on_categoria_id"
  add_index "grilla_itemes", ["grilla_id"], name: "index_grilla_itemes_on_grilla_id"

  create_table "grillas", force: :cascade do |t|
    t.integer  "cargo_id"
    t.string   "tipo_grilla"
    t.string   "grilla"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "grillas", ["cargo_id"], name: "index_grillas_on_cargo_id"

  create_table "grupo_itemes", force: :cascade do |t|
    t.text "enunciado"
  end

  create_table "host_permitidos", force: :cascade do |t|
    t.string   "host",        limit: 20
    t.string   "descripcion"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "host_permitidos", ["host"], name: "index_host_permitidos_on_host", unique: true

  create_table "hostes", force: :cascade do |t|
    t.string   "host",        limit: 20
    t.string   "descripcion"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "hostes", ["host"], name: "index_hostes_on_host", unique: true

  create_table "icfes_registros", force: :cascade do |t|
    t.string   "pin"
    t.integer  "persona_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "icfes_registros", ["persona_id"], name: "index_icfes_registros_on_persona_id"
  add_index "icfes_registros", ["pin"], name: "index_icfes_registros_on_pin"

  create_table "instituciones", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "codigo",        limit: 8
    t.integer  "municipio_id"
    t.integer  "secretaria_id"
    t.string   "sector"
    t.string   "zona"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "instituciones", ["municipio_id"], name: "index_instituciones_on_municipio_id"
  add_index "instituciones", ["secretaria_id"], name: "index_instituciones_on_secretaria_id"
  add_index "instituciones", ["sector"], name: "index_instituciones_on_sector"
  add_index "instituciones", ["zona"], name: "index_instituciones_on_zona"

  create_table "item_saltos", force: :cascade do |t|
    t.integer "item_id"
    t.integer "pregunta_id"
  end

  create_table "itemes", force: :cascade do |t|
    t.integer "grupo_item_id"
    t.integer "codigo_icfes"
    t.string  "item"
    t.integer "item_valor"
  end

  create_table "materias", force: :cascade do |t|
    t.integer  "secciones_educativas_id"
    t.string   "materia"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "materias", ["secciones_educativas_id"], name: "index_materias_on_secciones_educativas_id"

  create_table "materias_coordinadores", force: :cascade do |t|
    t.integer  "coordinador_id"
    t.integer  "materia_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "materias_coordinadores", ["coordinador_id"], name: "index_materias_coordinadores_on_coordinador_id"
  add_index "materias_coordinadores", ["materia_id"], name: "index_materias_coordinadores_on_materia_id"

  create_table "materias_evaluadores", force: :cascade do |t|
    t.integer "evaluador_id"
    t.integer "materia_id"
  end

  create_table "municipios", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "departamento_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "municipios", ["departamento_id"], name: "index_municipios_on_departamento_id"
  add_index "municipios", ["nombre"], name: "index_municipios_on_nombre"

  create_table "nivel_pares", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "rango"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "niveles", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "nivel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "niveles", ["nivel_id"], name: "index_niveles_on_nivel_id"

  create_table "notificacion_tipos", force: :cascade do |t|
    t.string   "texto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "clase"
    t.string   "clase_css"
  end

  create_table "notificaciones", force: :cascade do |t|
    t.string   "texto"
    t.boolean  "visible"
    t.integer  "usuario_id"
    t.integer  "tipo_notif_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "rol_id"
  end

  create_table "observadores", force: :cascade do |t|
    t.integer  "estado_id"
    t.integer  "persona_id"
    t.integer  "canal_regional_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "lider_id"
  end

  add_index "observadores", ["canal_regional_id"], name: "index_observadores_on_canal_regional_id"
  add_index "observadores", ["estado_id"], name: "index_observadores_on_estado_id"
  add_index "observadores", ["persona_id"], name: "index_observadores_on_persona_id"

  create_table "observadores_profesores", id: false, force: :cascade do |t|
    t.integer "profesor_id"
    t.integer "observador_id"
    t.date    "fecha_grabacion"
  end

  add_index "observadores_profesores", ["observador_id"], name: "index_observadores_profesores_on_observador_id"
  add_index "observadores_profesores", ["profesor_id"], name: "index_observadores_profesores_on_profesor_id"

  create_table "operaciones", force: :cascade do |t|
    t.integer "tipo_operador_id"
    t.integer "operando_izq"
    t.integer "operando_der"
    t.string  "operando_izq_tipo"
    t.string  "operando_der_tipo"
  end

  create_table "pagina_justificaciones", force: :cascade do |t|
    t.integer  "autoevaluacion_id"
    t.integer  "pagina"
    t.string   "justificacion",     limit: 1000
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "paginas", force: :cascade do |t|
    t.string   "controller"
    t.string   "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perfiles", force: :cascade do |t|
    t.string   "perfil"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "codigo"
  end

  create_table "periodo_grillas", force: :cascade do |t|
    t.integer  "periodo"
    t.integer  "grilla_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.date     "fecha_inicial"
    t.date     "fecha_final"
  end

  add_index "periodo_grillas", ["grilla_id"], name: "index_periodo_grillas_on_grilla_id"

  create_table "persona_roles", force: :cascade do |t|
    t.integer  "persona_id"
    t.integer  "rol_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "persona_roles", ["persona_id"], name: "index_persona_roles_on_persona_id"
  add_index "persona_roles", ["rol_id"], name: "index_persona_roles_on_rol_id"

  create_table "personas", force: :cascade do |t|
    t.string   "nombre"
    t.string   "apellido_paterno"
    t.string   "apellido_materno"
    t.integer  "tipo_documento_id"
    t.string   "documento"
    t.string   "direccion"
    t.string   "telefono"
    t.string   "celular"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "registrado",             default: false
    t.integer  "estado_id"
    t.datetime "ultima_visita_notif"
    t.datetime "ultima_visita_blog"
    t.boolean  "consentimiento"
    t.boolean  "pico_placa"
  end

  add_index "personas", ["documento"], name: "index_personas_on_documento"
  add_index "personas", ["reset_password_token"], name: "index_personas_on_reset_password_token", unique: true
  add_index "personas", ["tipo_documento_id"], name: "index_personas_on_tipo_documento_id"

  create_table "personas_videos", id: false, force: :cascade do |t|
    t.integer "persona_id"
    t.integer "video_id"
  end

  create_table "portafolios", force: :cascade do |t|
    t.text     "texto"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "archivo_file_name"
    t.string   "archivo_content_type"
    t.integer  "archivo_file_size"
    t.datetime "archivo_updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "titulo"
    t.text     "cuerpo"
    t.boolean  "visible"
    t.integer  "usuario_id"
    t.string   "imagen"
    t.string   "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "preguntas", force: :cascade do |t|
    t.text    "pregunta"
    t.integer "grilla_id"
    t.integer "tipo_pregunta_id"
    t.boolean "validada"
    t.text    "enunciado"
    t.text    "explicacion"
    t.integer "grupo_item_id"
  end

  add_index "preguntas", ["grilla_id"], name: "index_preguntas_on_grilla_id"

  create_table "profesores", force: :cascade do |t|
    t.integer  "estado_id"
    t.integer  "persona_id"
    t.integer  "secretarias_educacion_id"
    t.integer  "secciones_educativa_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.boolean  "carga_video"
    t.integer  "materia_id"
    t.integer  "nivel_id"
    t.integer  "cargo_id"
    t.integer  "tipo_grabacion_id"
    t.integer  "institucion_id"
    t.string   "otra"
    t.integer  "sede_id"
    t.integer  "departamento_id"
    t.integer  "municipio_id"
  end

  add_index "profesores", ["departamento_id"], name: "index_profesores_on_departamento_id"
  add_index "profesores", ["estado_id"], name: "index_profesores_on_estado_id"
  add_index "profesores", ["municipio_id"], name: "index_profesores_on_municipio_id"
  add_index "profesores", ["persona_id"], name: "index_profesores_on_persona_id"
  add_index "profesores", ["secciones_educativa_id"], name: "index_profesores_on_secciones_educativa_id"
  add_index "profesores", ["secretarias_educacion_id"], name: "index_profesores_on_secretarias_educacion_id"
  add_index "profesores", ["sede_id"], name: "index_profesores_on_sede_id"

  create_table "regiones", force: :cascade do |t|
    t.string "nombre"
  end

  create_table "registro_menes", force: :cascade do |t|
    t.integer  "tipo_documento_id"
    t.string   "documento"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "reportes", force: :cascade do |t|
    t.integer  "persona_id"
    t.integer  "video_id"
    t.integer  "tipos_reporte_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.boolean  "revisado",         null: false
    t.boolean  "tercer_evaluador", null: false
    t.text     "causa"
  end

  create_table "respuesta_itemes", force: :cascade do |t|
    t.integer "item_id"
    t.integer "test_instancia_id"
  end

  create_table "revisor_videos", force: :cascade do |t|
    t.integer  "video_id"
    t.integer  "revisor_id"
    t.boolean  "aprobado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "estado"
  end

  create_table "rol_perfiles", force: :cascade do |t|
    t.integer  "rol_id"
    t.integer  "perfil_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rol_perfiles", ["perfil_id"], name: "index_rol_perfiles_on_perfil_id"
  add_index "rol_perfiles", ["rol_id"], name: "index_rol_perfiles_on_rol_id"

  create_table "roles", force: :cascade do |t|
    t.string   "rol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "secciones_educativas", force: :cascade do |t|
    t.string   "seccion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "secretarias", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "departamento_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "secretarias", ["departamento_id"], name: "index_secretarias_on_departamento_id"
  add_index "secretarias", ["nombre"], name: "index_secretarias_on_nombre"

  create_table "secretarias_educaciones", force: :cascade do |t|
    t.string  "secretaria"
    t.integer "region_id"
  end

  create_table "sedes", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "codigo",         limit: 8
    t.integer  "institucion_id"
    t.integer  "municipio_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "sedes", ["institucion_id"], name: "index_sedes_on_institucion_id"
  add_index "sedes", ["nombre"], name: "index_sedes_on_nombre"

  create_table "test_instancias", force: :cascade do |t|
    t.integer "test_persona_id"
    t.integer "respuesta_item_id"
  end

  create_table "test_personas", force: :cascade do |t|
    t.integer "evaluado_id"
    t.integer "evaluador_id"
    t.integer "test_id"
  end

  create_table "test_preguntas", force: :cascade do |t|
    t.integer "test_id"
    t.integer "pregunta_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string  "test"
    t.boolean "validado", default: false
  end

  create_table "tipo_documentos", force: :cascade do |t|
    t.string   "documento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_grabaciones", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tipo_grabaciones", ["nombre"], name: "index_tipo_grabaciones_on_nombre"

  create_table "tipo_operadores", force: :cascade do |t|
    t.string "operador"
    t.text   "descripcion"
    t.string "codigo"
  end

  create_table "tipo_preguntas", force: :cascade do |t|
    t.string "tipo_pregunta"
  end

  create_table "tipos_reportes", force: :cascade do |t|
    t.string "nombre"
  end

  create_table "tutoriales", force: :cascade do |t|
    t.string   "tutorial"
    t.string   "youtube_id"
    t.integer  "pagina_id"
    t.integer  "perfil_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "valor_escalas", force: :cascade do |t|
    t.integer  "escalas_id"
    t.string   "valor",      limit: 30
    t.string   "letra",      limit: 1
    t.integer  "orden"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "valor_escalas", ["escalas_id"], name: "index_valor_escalas_on_escalas_id", unique: true
  add_index "valor_escalas", ["valor"], name: "index_valor_escalas_on_valor", unique: true

  create_table "valoracion_itemes", force: :cascade do |t|
    t.integer "item_id"
    t.integer "valoracion_id"
    t.string  "valoracion"
  end

  create_table "valoraciones", force: :cascade do |t|
    t.integer "pregunta_id"
  end

  create_table "video_estados", force: :cascade do |t|
    t.string   "video_estado"
    t.integer  "video_estado_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "videos", force: :cascade do |t|
    t.integer  "profesor_id"
    t.integer  "observador_id"
    t.boolean  "identidad_verificada"
    t.integer  "reporte_id"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.datetime "attach_updated_at"
    t.integer  "video_estado_id"
    t.string   "transcoder_job_id"
    t.string   "conversion_status"
    t.integer  "intentos",             default: 0
    t.boolean  "revisado",             default: false
    t.string   "fecha_grabacion"
  end

end
