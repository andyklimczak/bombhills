# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(username: 'testuser', email: 'test@bombhills.com', password: 'password123', password_confirmation: 'password123')

10.times do |i|
  User.first.spots.create({title: "spot title #{i}", description: "spot description #{i}", latitude: Random.rand(27..49), longitude: Random.rand(-123..-76), difficulty: ['Beginner', 'Intermediate', 'Expert'].sample})
end

10.times do |i|
  User.first.posts.create({title: "post title #{i}", description: "post description #{i}", image: "http://placeskull.com/400/200/", spot: Spot.order("RANDOM()").first})
end
