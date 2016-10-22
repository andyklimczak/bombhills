# frozen_string_literal: true
require 'ffaker'

FactoryGirl.define do
  factory :image_post do
    title { FFaker::Product.product }
    image { fixture_file_upload 'spec/fixtures/pic.jpg', 'image/jpeg' }
    description { FFaker::HipsterIpsum.paragraph }
    user
    spot
  end
end
