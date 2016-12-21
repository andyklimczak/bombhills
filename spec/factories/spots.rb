# frozen_string_literal: true
require 'ffaker'

FactoryGirl.define do
  factory :spot, aliases: [:commentable] do
    title { FFaker::Venue.name + Random.rand(10_000).to_s }
    traffic { FFaker::HipsterIpsum.phrase }
    description { FFaker::HipsterIpsum.sentence }
    latitude { FFaker::Geolocation.lat }
    longitude { FFaker::Geolocation.lng }
    difficulty %w(Beginner Intermediate Professional).sample
    user
  end
end
