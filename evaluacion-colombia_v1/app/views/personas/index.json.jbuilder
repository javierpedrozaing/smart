json.array!(@personas) do |persona|
  json.extract! persona, :id, :nombre, :apellido_paterno, :apellido_materno, :tipo_documento_id, :documento, :direccion, :telefono, :celular, :email
  json.url persona_url(persona, format: :json)
end
