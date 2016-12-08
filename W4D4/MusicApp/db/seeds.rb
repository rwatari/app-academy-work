# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(email: "rwatari@gmail.com", password: "password")
Band.create!(name: "U2")
Band.create!(name: "Coldplay")
Band.create!(name: "Beatles")
Band.create!(name: "Sia")
Band.create!(name: "The Killers")
