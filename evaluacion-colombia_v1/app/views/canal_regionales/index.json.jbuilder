json.array!(@canal_regionales) do |canal_regional|
  json.extract! canal_regional, :id, :descripcion
  json.url canal_regional_url(canal_regional, format: :json)
end
