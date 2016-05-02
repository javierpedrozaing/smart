json.array!(@materias) do |materia|
  json.extract! materia, :id, :secciones_educativas_id, :descripcion
  json.url materia_url(materia, format: :json)
end
