json.array!(@video_estados) do |video_estado|
  json.extract! video_estado, :id, :video_estado, :video_estado_id
  json.url video_estado_url(video_estado, format: :json)
end
