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
Band.create!(name: "The Beatles")
Band.create!(name: "Sia")
Band.create!(name: "The Killers")

Album.create!(title: "Hot Fuss", band_id: 5, album_type: "Studio")
Album.create!(title: "Sam's Town", band_id: 5, album_type: "Studio")

Track.create!(album_id: 1, track_type: "Regular", name: "Jenny Was a Friend of Mine")
Track.create!(album_id: 1, track_type: "Regular", name: "Mr. Brightside")
Track.create!(album_id: 1, track_type: "Regular", name: "Smile Like You Mean It")
Track.create!(album_id: 1, track_type: "Regular", name: "Somebody Told Me")
Track.create!(album_id: 1, track_type: "Regular", name: "All These Things That I've Done")
