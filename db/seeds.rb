until User.count > 2 do
  User.create(username: FFaker::Internet.user_name, email: FFaker::Internet.safe_email, password: FFaker::Internet.password, motto: FFaker::DizzleIpsum.sentence)
  User.create(username: FFaker::Internet.user_name, email: FFaker::Internet.safe_email, password: FFaker::Internet.password, motto: FFaker::DizzleIpsum.sentence)
end

10.times do |i|
  User.first.spots.create({title: FFaker::Venue.name, description: FFaker::HipsterIpsum.sentence, latitude: FFaker::Geolocation.lat, longitude: FFaker::Geolocation.lng, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample})
  User.last.spots.create({title: FFaker::Venue.name, description: FFaker::HipsterIpsum.sentence, latitude: FFaker::Geolocation.lat, longitude: FFaker::Geolocation.lng, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample})
end

2.times do |i|
  User.first.posts.create({title: FFaker::Product.product, description: FFaker::HipsterIpsum.paragraph, image: FFaker::Avatar.image, spot: Spot.order("RANDOM()").first, type: "ImagePost"})
  User.last.posts.create({title: FFaker::Product.product, description: FFaker::HipsterIpsum.paragraph, image: FFaker::Avatar.image, spot: Spot.order("RANDOM()").first, type: "ImagePost"})
  User.last.posts.create({title: FFaker::Product.product, description: FFaker::HipsterIpsum.paragraph, image: FFaker::Avatar.image, type: "ImagePost"})
  User.first.posts.create({title: FFaker::Product.product, description: FFaker::HipsterIpsum.paragraph, video_url: 'https://www.youtube.com/watch?v=e-ORhEE9VVg', spot: Spot.order("RANDOM()").first, type: "VideoPost"})
end
