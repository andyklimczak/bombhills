# frozen_string_literal: true
require 'ffaker'

FactoryGirl.define do
  factory :user, aliases: [:attending_users] do
    username { FFaker::Internet.user_name.sub('.', '_') + Random.rand(10000).to_s }
    email { FFaker::Internet.safe_email }
    password { FFaker::Internet.password }
    password_confirmation { password }
    motto { FFaker::DizzleIpsum.sentence }
    avatar { fixture_file_upload 'spec/fixtures/pic.jpg', 'image/jpeg' }
  end
end
