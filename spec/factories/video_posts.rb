require 'ffaker'

FactoryGirl.define do
  factory :video_post do
    title { FFaker::Product.product }
    video_url "//www.youtube.com/embed/c7rCyll5AeY"
    description { FFaker::HipsterIpsum.paragraph }
    user
    spot
  end

end
