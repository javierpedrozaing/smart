json.array!(@icfes_registros) do |icfes_registro|
  json.extract! icfes_registro, :id, :pin, :persona_id
  json.url icfes_registro_url(icfes_registro, format: :json)
end
