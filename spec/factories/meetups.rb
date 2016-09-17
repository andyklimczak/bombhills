# frozen_string_literal: true
FactoryGirl.define do
  factory :meetup, aliases: [:attending_meetups] do
    title { FFaker::Movie.title }
    description { FFaker::Lorem.sentence }
    time { FFaker::Time.date }
    spot
    user
  end
end
