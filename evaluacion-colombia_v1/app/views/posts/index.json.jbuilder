json.array!(@posts) do |post|
  json.extract! post, :id, :titulo, :cuerpo, :visible, :usuario_id, :imagen, :descripcion
  json.url post_url(post, format: :json)
end
