json.array!(@preguntas) do |pregunta|
  json.extract! pregunta, :id, :pregunta, :grilla_id
  json.url pregunta_url(pregunta, format: :json)
end
