require 'ffaker'

FactoryGirl.define do
  factory :user do
    username { FFaker::Internet.user_name }
    email { FFaker::Internet.safe_email }
    password { FFaker::Internet.password }
  end
end

