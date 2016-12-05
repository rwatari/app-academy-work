# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(username: 'rwatari')
User.create!(username: 'hcan')
User.create!(username: 'gizmo')
User.create!(username: 'richard')

Contact.create!(name: 'Hazal', email: 'hazal@gmail.com', owner_id: 1)
Contact.create!(name: 'Gizmo', email: 'gizmo@gizmo.com', owner_id: 1)
Contact.create!(name: 'Richard', email: 'richard@gizmo.com', owner_id: 2)


ContactShare.create!(contact_id: 1, shared_user_id: 3)
ContactShare.create!(contact_id: 3, shared_user_id: 1)
