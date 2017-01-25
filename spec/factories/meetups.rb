# frozen_string_literal: true
FactoryGirl.define do
  factory :meetup, aliases: [:attending_meetups] do
    title { FFaker::Movie.title }
    description { FFaker::Lorem.sentence }
    time { Time.zone.now.next_week }
    spot
    user
  end
end
