# frozen_string_literal: true
FactoryGirl.define do
  factory :meetup, aliases: [:attending_meetups] do
    title { "Meetup Title #{Random.rand(10_000)}" }
    description 'Meetup description'
    time { Time.zone.now.next_week }
    spot
    user
  end
end
