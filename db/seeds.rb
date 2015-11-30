# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
50.times do |i|
  Location.create({address: "test#{i}", title: "test#{i}", username: "test#{i}", description: "test#{i}", latitude: Random.rand(27..49), longitude: Random.rand(-123..-76)})
end
