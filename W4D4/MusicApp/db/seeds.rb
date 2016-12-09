# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(email: "rwatari@gmail.com", password: "password", activated: true)

Band.create!(name: "U2")
Band.create!(name: "Coldplay")
Band.create!(name: "The Beatles")
Band.create!(name: "Sia")
Band.create!(name: "The Killers")

Album.create!(title: "Hot Fuss", band_id: 5, album_type: "Studio")
Album.create!(title: "Sam's Town", band_id: 5, album_type: "Studio")

track1 = Track.create!(album_id: 1, track_type: "Regular", name: "Jenny Was a Friend of Mine")
Track.create!(album_id: 1, track_type: "Regular", name: "Mr. Brightside")
Track.create!(album_id: 1, track_type: "Regular", name: "Smile Like You Mean It")
Track.create!(album_id: 1, track_type: "Regular", name: "Somebody Told Me")
Track.create!(album_id: 1, track_type: "Regular", name: "All These Things That I've Done")

Note.create!(track_id: 1, user_id: 1, text: "This is a cool song.")

track1.update(lyrics:
  "We took a walk that night, but it wasn't the same\r\n"\
  "We had a fight on the promenade out in the rain\r\n"\
  "She said she loved me, but she had somewhere to go\r\n"\
  "She couldn't scream while I held I close\r\n"\
  "I swore I'd never let her go\r\n\r\n"\
  "Tell me what you want to know\r\n"\
  "Oh come on, oh come on, oh come on\r\n"\
  "There ain't no motive for this crime\r\n"\
  "Jenny was a friend of mine\r\n"\
  "So come on, oh come on, oh come on\r\n\r\n"\
  "I know my rights, I've been here all day and it's time\r\n"\
  "For me to go, so let me know if it's alright\r\n"\
  "I just can't take this, I swear I told you the truth\r\n"\
  "She couldn't scream while I held her close\r\n"\
  "I swore I'd never let her go\r\n\r\n"\
  "Tell me what you want to know\r\n"\
  "Oh come on, oh come on, oh come on\r\n"\
  "And then you whisper in my ear\r\n"\
  "I know what you're doing here\r\n"\
  "So come on, oh come on, oh come on\r\n"\
  "There ain't no motive for this crime\r\n"\
  "Jenny was a friend of mine\r\n"\
  "Oh come on, oh come on, oh come on\r\n")
