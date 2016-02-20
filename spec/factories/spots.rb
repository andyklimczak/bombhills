require 'ffaker'

FactoryGirl.define do
  factory :spot do
    title { FFaker::Venue.name }
    description { FFaker::HipsterIpsum.sentence }
    latitude { FFaker::Geolocation.lat }
    longitude { FFaker::Geolocation.lng }
    difficulty ['Beginner', 'Intermediate', 'Expert'].sample
    user
  end
end

