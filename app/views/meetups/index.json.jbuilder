json.array!(@meetups) do |meetup|
  json.extract! meetup, :id, :title, :description, :time, :spot_id, :owner_id
  json.url meetup_url(meetup, format: :json)
end
