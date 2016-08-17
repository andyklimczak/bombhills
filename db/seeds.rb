until User.count > 2 do
  User.create(username: FFaker::Internet.user_name, email: FFaker::Internet.safe_email, password: FFaker::Internet.password, motto: FFaker::DizzleIpsum.sentence)
  User.create(username: FFaker::Internet.user_name, email: FFaker::Internet.safe_email, password: FFaker::Internet.password, motto: FFaker::DizzleIpsum.sentence)
end

3.times do |i|
  User.first.spots.create({title: FFaker::Venue.name, description: FFaker::HipsterIpsum.sentence, latitude: FFaker::Geolocation.lat, longitude: FFaker::Geolocation.lng, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: FFaker::HipsterIpsum.phrase})
  User.last.spots.create({title: FFaker::Venue.name, description: FFaker::HipsterIpsum.sentence, latitude: FFaker::Geolocation.lat, longitude: FFaker::Geolocation.lng, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: FFaker::HipsterIpsum.phrase})
end

3.times do |i|
  User.first.posts.create({title: FFaker::Product.product, description: FFaker::HipsterIpsum.paragraph, image: FFaker::Avatar.image, spot: Spot.order("RANDOM()").first, type: "ImagePost"})
  User.last.posts.create({title: FFaker::Product.product, description: FFaker::HipsterIpsum.paragraph, image: FFaker::Avatar.image, spot: Spot.order("RANDOM()").first, type: "ImagePost"})
  User.last.posts.create({title: FFaker::Product.product, description: FFaker::HipsterIpsum.paragraph, image: FFaker::Avatar.image, type: "ImagePost"})
  User.first.posts.create({title: FFaker::Product.product, description: FFaker::HipsterIpsum.paragraph, video_url: FFaker::Youtube.url, spot: Spot.order("RANDOM()").first, type: "VideoPost"})
end

4.times do |i|
  Spot.first.meetups.create({title: FFaker::Movie.title, description: FFaker::Lorem.sentence, owner: User.first, time: FFaker::Time.date})
end
