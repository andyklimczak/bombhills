# frozen_string_literal: true
require 'ffaker'

FactoryGirl.define do
  factory :video_post do
    title { FFaker::Product.product }
    video_url { FFaker::Youtube.url }
    description { FFaker::HipsterIpsum.paragraph }
    user
    spot
  end
end
