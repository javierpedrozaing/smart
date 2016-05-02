Rails.application.routes.draw do

  resources :grilla_itemes
  resources :evaluacion_respuestas
  get 'estadisticas/admin_evaluadores'
  get 'estadisticas/admin_evaluados'
  get 'estadisticas/jefe_camarografos'
  get 'estadisticas/admin_evaluados_csv'
  post 'estadisticas/jefe_camarografos_totales'
  
  get 'notificaciones' => 'notificaciones#index', as: 'notificaciones'
  get 'notificaciones/enviar' => 'notificaciones#enviar', as: 'notificaciones_enviar'
  post 'notificaciones/create' => 'notificaciones#create', as: 'notificaciones_create'
  get '/public/static_files/decreto.pdf', :to => redirect('/static_files/decreto.pdf')
  get '/public/static_files/consentimiento_final.pdf', :to => redirect('/static_files/consentimiento_final.pdf')
  #get '/public/static_files/ManualAutograbacion', :to => redirect('/static_files/ManualAutograbacion.pdf', status: 301)
  get 'cuenta/mailtest' => 'cuenta#mailtest'
  get 'cuenta/redirect' => 'cuenta#redirect'
  get 'cuenta/tipo_usuario' => 'cuenta#tipo_usuario'
  mount Ckeditor::Engine => '/ckeditor'
  resources :posts
  resources :permisos

  devise_for :personas

  devise_scope :persona do
    authenticated :persona do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  #####################################################
  # Registro de usuarios
  #####################################################
  
  get 'cuenta/registro' => 'cuenta#new_registro'
  get 'cuenta/profesor' => 'cuenta#new_registro_profesor'
  get 'cuenta/camarografo' => 'cuenta#new_registro_camarografo'
  get 'cuenta/admin' => 'cuenta#new_registro_admin'
  get 'cuenta/email_ingreso/:id' => 'cuenta#email_ingreso'
  get 'cuenta/activar_camarografo' => 'cuenta#activar_camarografo'
  get 'cuenta/activar_admin/:id' => 'cuenta#activar_admin'
  post 'cuenta/activar_camarografo_email' => 'cuenta#activar_camarografo_email'
  post 'cuenta/activar_admin_email' => 'cuenta#activar_admin_email'
  post 'cuenta/activar_registro_profesor' => 'cuenta#activar_registro_profesor'
  post 'cuenta/activar_profesor' => 'cuenta#activar_profesor'
  post 'cuenta/activar_camarografo' => 'cuenta#activar_camarografo'
  post 'cuenta/activar_persona' => 'cuenta#activar_registro_persona'
  post 'cuenta/cargar_profesor' => 'cuenta#cargar_profesor'
  post 'cuenta/activar' => 'cuenta#activar'
  post 'cuenta/reset_password_email' =>'cuenta#reset_password_email'
  get 'cuenta/ajmunicipios' => 'cuenta#ajax_municipios'
  get 'cuenta/ajinstituciones' => 'cuenta#ajax_instituciones'
  get 'cuenta/ajcargos' => 'cuenta#ajax_cargos'
  get 'cuenta/ajniveles' => 'cuenta#ajax_niveles'
  get 'cuenta/ajsedes' => 'cuenta#ajax_sedes'
  get 'cuenta/editar_cuenta' => 'cuenta#editar_cuenta'
  get 'cuenta/editar_cuenta_simple' => 'cuenta#editar_cuenta_simple'
  post 'cuenta/editar_cuenta_simple' => 'cuenta#editar_cuenta_simple_actualizar'
  post 'cuenta/editar_cuenta/persona' => 'cuenta#editar_cuenta_persona'
  post 'cuenta/editar_cuenta/profesor' => 'cuenta#editar_cuenta_profesor'
  get 'cuenta/editar_cuenta/profesor_dep_muni' => 'cuenta#editar_profesor_dep_muni', as: 'get_editar_dep_muni'
  post 'cuenta/editar_cuenta/profesor_dep_muni' => 'cuenta#editar_profesor_dep_muni_actualizar', as: 'editar_dep_muni'
  
  #Creacion de ruta de bienvenida al mail
  post 'usuario_mailer/bienvenida_usuario' => 'usuario_mailer#bienvenida_usuario'


  #####################################################
  # Resources para la gestión de modelos vía REST
  #####################################################
  
  resources :videos do
    get 'reportar', on: :member
  end
  #resources :reportes
  resources :evaluaciones
  resources :preguntas do
  resources :grupo_itemes
  end
  #devise_for :usuarios
  resources :icfes_registros
  

  #=====================================================
  ######################################################
  # Modulos clave de la aplicacion
  ######################################################
  #=====================================================

  ######################################################
  # Vistas de usuarios genericos
  ######################################################

  # Evaluadores
  get 'usuarios/camarografos'
  get 'usuarios/evaluadores'
  get 'usuarios/profesores'
  get 'usuarios/coordinadores'
  get 'usuarios/admin_evaluados'
  get 'usuarios/jefe_camarografos'
  get 'usuarios/admin_evaluadores'
  get 'usuarios/administradores'
  get 'usuarios/revisor_videos'

  ######################################################has_one :video
  # Módulo para coordinador
  ######################################################  
  get 'coordinador' => 'coordinador#index'
  get 'coordinador/evaluadores'
  get 'coordinador/reasignar/:video_id' => 'coordinador#reasignar'

  ######################################################
  # Evaluaciones
  ######################################################
  get 'evaluaciones' => 'evaluaciones#index'
  get 'evaluaciones/pendientes' => 'evaluaciones#pendientes'
  get 'evaluaciones/realizadas' => 'evaluaciones#realizadas'
  get 'evaluaciones/procesando' => 'evaluaciones#procesando'
  post 'evaluaciones/:id/asignar_evaluador', to: 'evaluaciones#asignar_evaluador', as: 'evaluaciones_asignar_evaluador'
  get 'evaluaciones/:id/realizar', to: 'evaluaciones#realizar', as: 'evaluaciones_realizar'
  
  
  

  #######################################
  # Modulo de administracion:
  #
  #######################################
  # TODO: Refactoring urgente de esto
  #namespace :admin do
  
  
    get 'administracion' => 'administracion#index'
    get 'administracion/:id' => 'administracion#index'
    get 'administracion/asignar/:id' => 'administracion#asignar'
    get 'administracion/reporte_estados/:id' => 'administracion#reporte_estados'
    get 'administracion/permisos' => 'administracion#permisos'
    get 'administracion/perfiles' => 'administracion#perfiles'
    get 'administracion/previsualizacion_video' => 'administracion#previsualizacion_video'
    post 'administracion/cargar_evaluados' => 'administracion#cargar_evaluados'
    get 'administracion/prueba_archivo/test' => 'administracion#prueba_archivo'
    
    # Vistas de listado por tipo de usuario
    get 'administracion/evaluadores' => 'evaluacion#evaluadores'
    get 'administracion/profesores' => 'administracion#profesores'
    get 'administracion/observadores' => 'observacion#observadores'
    
    # Vistas de Personas     
    get 'persona/correo_valido/:id' => 'personas#correo_valido'    
    get 'persona/evaluados_csv/evaluados_error' => 'personas#evaluados_csv'  
    get 'persona/export_csv/profesores' => 'personas#export_csv' #, :format => false, :defaults => { :format => '' }
    post 'persona/cargar_archivo' => 'personas#cargar_archivo'
    post 'persona/cargar_coordinadores_evaluadores' => 'personas#cargar_coordinadores_evaluadores'
    post 'persona/cargar_archivo_pines' => 'personas#cargar_archivo_pines'
    post 'persona/cargar_archivo_men' => 'personas#cargar_archivo_men'
    post 'persona/evaluadores/coordinadores' => 'personas#cargar_coordinadores_evaluadores'
    post 'persona/camarografos/profesores' => 'personas#cargar_camarografos_profesores'
    post 'persona/edit_observador'=>'persona#edit_observador'
    post 'persona/carga_csv' => 'personas#carga_csv'
    post 'persona/cargar_archivo_fecode' => 'personas#cargar_archivo_fecode'
    post 'persona/cargar_archivo_pico_y_placa' => 'personas#cargar_archivo_pico_y_placa'
    
    resources :personas
    
    # Vistas de profesor
    resources :canal_regionales
    
    # Vistas de evaluacion
    get 'evaluacion' , to: 'evaluacion#index', as: 'admin_evaluacion' 
    get 'evaluacion/show' => 'evaluacion#show'
    get 'evaluacion/evaluadores' => 'evaluacion#evaluadores'
    get 'evaluacion/coordinador_evaluadores' => 'evaluacion#coordinador_evaluadores'
    get 'evaluacion/videoevaluar' => 'evaluacion#videoevaluar'
    post 'evaluacion/cargar_evaluadores' => 'evaluacion#cargar_evaluadores'
    post 'evaluacion/cargar_coordinadores' => 'evaluacion#cargar_coordinadores'

  
    # Vistas de Sistemas:
    get 'sistemas' ,to: 'sistemas#index', as: 'admin_sistemas'
    get 'sistemas/logs' => 'sistemas#logs'
    get 'sistemas/icfes' => 'sistemas#icfes'
    
    # Vistas del Revisor de videos:
    get 'revisor_videos' => 'administracion#revisor_index'
    patch 'revisor_videos/guardar_revision' => 'administracion#revisor_guardar', as: 'guardar_revision'
    get 'revisor_videos/reset' => 'administracion#revisor_reset', as: 'revisor_reset'
    ##patch 'revisor_videos/guardar_revision2' => 'evaluador#revisor_guardar', as: 'guardar_revision2'
    
    # Vistar para ejecutar tasks por url:
    get 'busuario_cam' => 'administracion#borrar_usuario_camarografo_task'
    get 'busuario_prof' => 'administracion#borrar_usuario_profesor_task'
    get 'bevresp' => 'administracion#borrar_evaluacion_respuesta'
    get 'evtorev' => 'administracion#videos_eval_rev'
    #tutoriales  
    get 'tutoriales/select_ajax' => 'tutoriales#select_ajax'
    resources :tutoriales
         
    #preguntas  
    resources :preguntas
    
    #grillas
    get 'grilla/preview/:id' => 'grillas#preview_grilla'  
    resources :grillas  
   

    # Vistas de Observacion:
    get 'observacion', to:  'observacion#index', as: 'admin_camarografos'
    get 'observacion/show' => 'observacion#show'       
    post 'observacion/cargar_camarografos' => 'observacion#cargar_camarografos'
 # end

  # Vista de Profesor
  get 'profesor' => 'profesor#index'
  get 'profesor/panel' => 'profesor#panel'
  get 'profesor/download_file' => 'profesor#download_file'
  get 'profesor/video' => 'profesor#video'
  get 'profesor/signin' => 'profesor#signin'
  get 'profesor/login' => 'profesor#login'
  post 'profesor/validar_video' => 'profesor#validar_video'
  post 'profesor/validar_video_modal' => 'profesor#validar_video_modal'
  get 'profesor/portafolio_form' => 'profesor#portafolio_form',as: 'portafolio_new'
  post 'profesor/portafolio_create' => 'profesor#portafolio_create',as: 'portafolio_create'
  get 'profesor/formulario_planeacion' => 'profesor#formulario_planeacion'
  post 'profesor/guardar_formulario_planeacion' => 'profesor#guardar_formulario_planeacion'
  patch 'profesor/guardar_formulario_planeacion' => 'profesor#guardar_formulario_planeacion'


  #Vista de Evaluador
  get 'evaluador' => 'evaluador#index'  
  get 'evaluador/terminadas' => 'evaluador#terminadas'
  get 'evaluador/evaluar' => 'evaluador#evaluar'
  get 'evaluador/actividad_obligatoria' => 'evaluador#actividad_obligatoria' #se crea para actividades obligatorias
  patch 'evaluador/guardar_evaluacion' => 'evaluador#guardar_evaluacion'

  #Vista de Observador

  get 'observador' => 'observador#index'
  get 'observador/upload' => 'observador#upload'
  get 'observador/show' => 'observador#show'
  get 'observador/index_v2' => 'observador#index_v2' 
  get  'observador/detalle_profesor' => 'observador#detalle_profesor'
  post 'observador/enviar_video_modal' => 'observador#enviar_video_modal'

  #get 'videos/:id/reportar' => 'videos#reportar'
  post 'videos/procesar_reporte' => 'videos#procesar_reporte'
  post 'videos/procesar_reporte_revisor' => 'videos#procesar_reporte_revisor'
  get 'videos/download/:id' => 'videos#download', as: 'download_video'
  post 'update_state' => 'videos#update_state'
  #post 'update_state' => 'funciones/amazon#update_video_state'
  #####################################################
  # Tests
  #####################################################
  
  get 'test' => 'tests#index', as: 'tests'
  get 'tests/:id' => 'tests#show', as: 'test'
  get 'test/new' => 'tests#new'  , as: 'new_test'
  get 'tests/edit/:id' => 'tests#edit'  , as: 'edit_test'
  patch  'tests/:id' => 'tests#update', as: 'update_test'
  post 'test/create' => 'tests#create'  , as: 'create_test'
  delete 'tests/:id' =>'tests#destroy'

  #####################################################
  # Archivos
  #####################################################
  post 'archivos/upload' => 'archivos#upload_file'
  get 'archivos/show' => 'archivos#show_certificado_no_carga'
  #get 'archivos/generar/:id' => 'archivos#generar_certificado_no_carga'
  get 'archivos/download/:id' => 'archivos#download', as: 'download_archivo'
  
  
  #####################################################
  # Autoevaluación
  #####################################################
   get 'autoevaluacion/index' => 'autoevaluacion#index'
   post 'autoevaluacion/guardar_autoevaluacion' => 'autoevaluacion#guardar_autoevaluacion'
   post 'autoevaluacion/guardar_autoevaluacion_item' => 'autoevaluacion#guardar_autoevaluacion_item'
  
end
