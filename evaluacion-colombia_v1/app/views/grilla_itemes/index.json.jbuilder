json.array!(@grilla_itemes) do |grilla_item|
  json.extract! grilla_item, :id, :grilla_id, :cod_item, :categoria_id, :cod_dimension, :cod_sub_dimension, :cod_afirmacion, :cod_evidencia, :item, :escala, :orden_item, :ejemplos
  json.url grilla_item_url(grilla_item, format: :json)
end
