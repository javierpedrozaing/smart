json.array!(@reportes) do |report|
  json.extract! report, :id
  json.url report_url(report, format: :json)
end
