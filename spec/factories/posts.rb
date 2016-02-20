require 'ffaker'

FactoryGirl.define do
  factory :post do
    title { FFaker::Product.product }
    image "http://placeskull.com/400/200/"
    description { FFaker::HipsterIpsum.paragraph }
    user
    spot
  end

end
