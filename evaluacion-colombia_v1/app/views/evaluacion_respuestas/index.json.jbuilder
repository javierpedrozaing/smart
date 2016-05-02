json.array!(@evaluacion_respuestas) do |evaluacion_respuesta|
  json.extract! evaluacion_respuesta, :id
  json.url evaluacion_respuesta_url(evaluacion_respuesta, format: :json)
end
