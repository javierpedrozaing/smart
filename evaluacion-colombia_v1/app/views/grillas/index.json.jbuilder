json.array!(@grillas) do |grilla|
  json.extract! grilla, :id, :asignatura_id, :seccion_educativa_id, :grilla
  json.url grilla_url(grilla, format: :json)
end
