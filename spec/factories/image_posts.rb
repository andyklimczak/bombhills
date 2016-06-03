require 'ffaker'

FactoryGirl.define do
  factory :image_post do
    title { FFaker::Product.product }
    image { FFaker::Avatar.image }
    description { FFaker::HipsterIpsum.paragraph }
    user
    spot
  end
end
