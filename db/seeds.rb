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
  Spot.first.meetups.create({title: FFaker::Movie.title, description: FFaker::Lorem.sentence, user: User.first, time: FFaker::Time.date})
end

admin = User.create(username: 'admin', email: 'bombhillscommunity@gmail.com', password: 'bombhills', motto: 'bomb ass hills')

# san fran spots 

admin.spots.create({title: 'Geary St. SF', description: 'Night ride, timed street lights. Nice wide carves.', latitude: 37.77948336934459, longitude: -122.49653398990631, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'na'})

admin.spots.create({title: 'Rivera St.', description: 'Nice cruiser hill w a killer view of the ocean.', latitude: 37.74578121450763, longitude: -122.49834179878236, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'na'})

admin.spots.create({title: 'Lombard street', description: 'Anthology!!! Downhill sliding. Brick pavement.', latitude: 37.801989564915104, longitude: -122.41952776908873, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'Bad'})

admin.spots.create({title: 'Mclaren Park', description: 'the SF Gravity fest cource', latitude: 37.72350400727579, longitude: -122.42274641990662, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'na'})

admin.spots.create({title: 'Muir beach run', description: 'dope view but dont fall off the edge', latitude: 37.88052730149224, longitude: -122.55414247512817, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'na'})

admin.spots.create({title: 'Redwood', description: 'Watch out for cops', latitude: 37.7951184623911, longitude: -122.16005086898802, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'minimal'})

# portland spots 

admin.spots.create({title: 'ZooBomb', description: 'this is one of the best/gnarliest downhill runs in portland. Zoobombers (people on mini-bikes) hit up this hill every sunday. ', latitude: 45.51482779887124, longitude: -122.71677017211913, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'na'})

admin.spots.create({title: '12th street', description: 'there is a bit of a trick to this one. The idea is to time all the lights from the top of 12th street all the way down to burnside. The best way to do this is buy hikeing up to the top of 12th, you know your at the right spot when you can see PSU dorms on the left and I405 cars driveing under you. Once your at the top of the overpass look down the hill at the first stop light, closest to the botem of the hill. Wait for it to turn red, then start counting down from 13 "you might wana time the light a few times just to get it right.", then start skating down twords the light. If you do this right the light will turn green just as you get up to it. If you can keep up your speed you will make it all the way down to burnside with out ever haveing to stop! Its way sick the first time you do it. I helps if you got some one waiting down at burnside to give you a ride back up. ', latitude: 45.51114387792089, longitude: -122.68921852111815, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'na'})

admin.spots.create({title: 'Kaiser Bomb', description: 'this is a fun, short hill to get a fews runs on. want to leave the top right as the Max (train) is leaving. that way you can time the traffic lights and get a green. you stop at the Max station at the bottom and take the train back to the top.', latitude: 45.5481225064744, longitude: -122.68082857131957, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'na'})

# san jose 

admin.spots.create({title: 'Coth slide', description: 'Steep and short with really good pavement. One-way street so no oncoming cars.', latitude: 37.28647377194026, longitude: -121.87128424644472, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'minimal'})

admin.spots.create({title: 'C.O.T.H.', description: 'Wide, easy, almost NO cars. Great place for beginner downhillers .', latitude: 37.28501409508062, longitude: -121.87231421470642, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'minimal'})

admin.spots.create({title: 'Calaveras', description: 'Fast, but no predrifiting needed.', latitude: 37.4395651585563, longitude: -121.82928085327148, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'ma'})


#LA / surrounding 

admin.spots.create({title: 'Speedway / Right next to the beach', description: 'u can take Speedway or go along the beach', latitude: 33.99563986057449, longitude: -118.48078966140747, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'na'})

admin.spots.create({title: 'la bomba 07', description: 'site of the 2007 loaded boards la bomba', latitude: 34.03604941812869, longitude: -118.5355496406555, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'na'})

admin.spots.create({title: 'sanddunes hill', description: 'fun and no cars', latitude: 33.90164004460608, longitude: -118.4156334400177, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample, traffic: 'na'})