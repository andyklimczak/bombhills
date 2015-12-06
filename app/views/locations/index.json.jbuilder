json.array!(@locations) do |location|
  json.extract! location, :id, :latitude, :longitude, :description, :user
  json.url location_url(location, format: :json)
end
