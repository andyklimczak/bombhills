# frozen_string_literal: true
require 'ffaker'

FactoryGirl.define do
  factory :video_post do
    title { "Video Post Title #{Random.rand(10_000)}" }
    video_url 'https://www.youtube.com/watch?v=e-ORhEE9VVg'
    description 'Video description'
    user
    spot
  end
end
