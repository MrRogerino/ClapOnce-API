# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

max_users = 5

users_needed = max_users - User.count

users_needed.times do
  user_details = {
    name: Faker::HarryPotter.character,
    latitude: rand(-30.0..30.0),
    longitude: rand(-180.0..180.0)
  }
  User.create(user_details)
end
