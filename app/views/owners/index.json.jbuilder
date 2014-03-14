json.array!(@owners) do |owner|
  json.extract! owner, :id, :nombre, :tipo, :clave, :pe
  json.url owner_url(owner, format: :json)
end
