# frozen_string_literal: true

json.spots do
  json.array! @spots do |spot|
    json.id spot.id
    json.title spot.title
    json.description spot.description
    json.difficulty spot.difficulty
    json.latitude spot.latitude
    json.longitude spot.longitude
    json.traffic spot.traffic
    json.slug spot.slug
    json.user do
      json.username spot.user.username
    end
  end
end
