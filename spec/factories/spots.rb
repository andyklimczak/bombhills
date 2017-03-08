# frozen_string_literal: true
require 'ffaker'

FactoryGirl.define do
  factory :spot, aliases: [:commentable] do
    title { "Spot Title #{Random.rand(10_000)}" }
    traffic 'Spot traffic'
    description 'Spot description'
    latitude 38
    longitude 122
    difficulty %w(Beginner Intermediate Professional).sample
    user
  end
end
