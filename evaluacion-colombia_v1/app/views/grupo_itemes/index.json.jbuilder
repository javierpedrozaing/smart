json.array!(@grupo_itemes) do |grupo_item|
  json.extract! grupo_item, :id
  json.url grupo_item_url(grupo_item, format: :json)
end
