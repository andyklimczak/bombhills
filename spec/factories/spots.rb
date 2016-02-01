FactoryGirl.define do
  factory :spot do
    title "Test Spot #{Random.rand 1000}"
    description { "#{title} description" }
    latitude Random.rand 27..49
    longitude Random.rand -123..-76
    difficulty ['Beginner', 'Intermediate', 'Expert'].sample
    user
  end
end

