require 'ffaker'

FactoryGirl.define do
  factory :user, aliases: [:owner, :attending_users] do
    username { FFaker::Internet.user_name }
    email { FFaker::Internet.safe_email }
    password { FFaker::Internet.password }
    password_confirmation { password }
    motto { FFaker::DizzleIpsum.sentence }
    avatar { FFaker::Avatar.image }
  end
end

