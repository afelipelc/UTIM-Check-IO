json.array!(@entries) do |entry|
  json.extract! entry, :id, :ingreso, :egreso
  json.url entry_url(entry, format: :json)
end
