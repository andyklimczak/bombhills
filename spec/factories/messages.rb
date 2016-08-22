FactoryGirl.define do
  factory :message do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    content { FFaker::LoremFR.phrase }
    subject { FFaker::Sport.name }
  end
end
