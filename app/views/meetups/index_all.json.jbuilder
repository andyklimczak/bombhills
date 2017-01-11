# frozen_string_literal: true
json.array!(@meetups) do |meetup|
  json.extract! meetup, :id, :title, :description, :time, :spot_id, :user_id
  json.url meetup_url(meetup, format: :json)
end
