FactoryGirl.define do
  factory :location do
    title "Test Location #{Random.rand 1000}"
    description { "#{title} description" }
    latitude Random.rand 27..49
    longitude Random.rand -123..-76
    difficulty ['Starter', 'Intermediate', 'Expert'].sample
    user
  end
end

