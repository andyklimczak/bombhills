FactoryGirl.define do
  factory :user do
    username { "TestUser#{Random.rand 999}" }
    email { "#{username}@test.com" }
    password "password123"
    password_confirmation "password123"
  end
end

