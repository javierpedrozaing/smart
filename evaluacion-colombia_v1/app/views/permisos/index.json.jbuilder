json.array!(@permisos) do |permiso|
  json.extract! permiso, :id, :perfiles_id, :estados_id
  json.url permiso_url(permiso, format: :json)
end
