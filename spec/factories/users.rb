# frozen_string_literal: true
require 'ffaker'

FactoryGirl.define do
  factory :user, aliases: [:attending_users] do
    username { "username#{Random.rand(10_000)}" }
    email { "#{username}@email.com" }
    password 'Password123'
    password_confirmation { password }
    motto 'User motto'
    avatar { fixture_file_upload 'spec/fixtures/pic.jpg', 'image/jpeg' }
  end
end
