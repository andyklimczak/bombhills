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

admin = User.create(username: 'admin', email: 'bombhillscommunity@gmail.com', password: 'bombhills', motto: 'bomb ass hills')

admin.spots.create({title: 'Geary St. SF', description: 'Night ride, timed street lights. Nice wide carves.', latitude: 37.77948336934459, longitude: -122.49653398990631, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'na'})

admin.spots.create({title: 'Rivera St.', description: 'Nice cruiser hill w a killer view of the ocean.', latitude: 37.74578121450763, longitude: -122.49834179878236, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'na'})

admin.spots.create({title: 'Lombard street', description: 'Anthology!!! Downhill sliding. Brick pavement.', latitude: 37.801989564915104, longitude: -122.41952776908873, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'Bad'})

admin.spots.create({title: 'Mclaren Park', description: 'the SF Gravity fest cource', latitude: 37.72350400727579, longitude: -122.42274641990662, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'na'})

admin.spots.create({title: 'Muir beach run', description: 'dope view but dont fall off the edge', latitude: 37.88052730149224, longitude: -122.55414247512817, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'na'})


