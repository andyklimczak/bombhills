json.array!(@locations) do |location|
  json.extract! location, :id, :address, :latitude, :longitude, :description, :username
  json.url location_url(location, format: :json)
end
