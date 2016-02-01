FactoryGirl.define do
  factory :post do
    title "Post title #{Random.rand 1000}"
    image "http://placeskull.com/400/200/"
    description { "Post description #{title}" }
    user
    spot
  end

end
