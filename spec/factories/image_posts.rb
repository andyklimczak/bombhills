# frozen_string_literal: true

require 'ffaker'

FactoryBot.define do
  factory :image_post do
    title { "Image Post Title #{Random.rand(10_000)}" }
    image { fixture_file_upload 'spec/fixtures/pic.jpg', 'image/jpeg' }
    description 'Image post description'
    user
    spot
  end
end
