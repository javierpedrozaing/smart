json.array!(@tutoriales) do |tutorial|
  json.extract! tutorial, :id, :tutorial, :youtube_id, :pagina_id, :perfil_id
  json.url tutorial_url(tutorial, format: :json)
end
