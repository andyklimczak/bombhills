json.array!(@events) do |event|
  json.extract! event, :id, :title, :description, :datetime
  json.url event_url(event, format: :json)
end
