json.array!(@secretarias_educaciones) do |secretarias_educacion|
  json.extract! secretarias_educacion, :id, :descripcion
  json.url secretarias_educacion_url(secretarias_educacion, format: :json)
end
