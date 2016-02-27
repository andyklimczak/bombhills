# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: FFaker::Internet.user_name, email: FFaker::Internet.safe_email, password: FFaker::Internet.password)
User.create(username: FFaker::Internet.user_name, email: FFaker::Internet.safe_email, password: FFaker::Internet.password)

5.times do |i|
  User.first.spots.create({title: FFaker::Venue.name, description: FFaker::HipsterIpsum.sentence, latitude: FFaker::Geolocation.lat, longitude: FFaker::Geolocation.lng, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample})
  User.last.spots.create({title: FFaker::Venue.name, description: FFaker::HipsterIpsum.sentence, latitude: FFaker::Geolocation.lat, longitude: FFaker::Geolocation.lng, difficulty: ['Beginner', 'Intermediate', 'Expert'].sample})
end

#5.times do |i|
  #User.first.posts.create({title: FFaker::Product.product, description: FFaker::HipsterIpsum.paragraph, image: "http://placeskull.com/400/200/", spot: Spot.order("RANDOM()").first})
  #User.last.posts.create({title: FFaker::Product.product, description: FFaker::HipsterIpsum.paragraph, image: "http://placeskull.com/400/200/", spot: Spot.order("RANDOM()").first})
#end
