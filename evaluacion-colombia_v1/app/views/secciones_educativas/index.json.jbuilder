json.array!(@secciones_educativas) do |secciones_educativa|
  json.extract! secciones_educativa, :id, :descripcion
  json.url secciones_educativa_url(secciones_educativa, format: :json)
end
