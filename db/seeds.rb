# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do |i|
  Location.create({title: "test title#{i}", username: "test user#{i}", description: "test description#{i}", latitude: Random.rand(27..49), longitude: Random.rand(-123..-76), difficulty: ['Starter', 'Intermediate', 'Expert'].sample})
end
