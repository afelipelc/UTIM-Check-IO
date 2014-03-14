json.array!(@devices) do |device|
  json.extract! device, :id, :tipo, :noserie, :marca, :color, :nota, :registro, :ultimavez
  json.url device_url(device, format: :json)
end
