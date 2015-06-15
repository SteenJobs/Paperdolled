# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User.populate(100) do |user|
#   user.email = Faker::Internet.free_email
#   user.first_name = Faker::Name.first_name
#   user.last_name = Faker::Name.last_name
#   user.encrypted_password = User.new(:password => "password").encrypted_password
#   user.bio = Faker::Lorem.sentences
#   user.picture = Faker::Avatar.image
# end

99.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  picture = Faker::Avatar.image
  bio = Faker::Lorem.sentences
  User.create!(first_name:            first_name,
               last_name:             last_name,
               email:                 "#{first_name}.#{last_name}#{n+1}@gmail.com",
               password:              "password",
               password_confirmation: "password",
               bio:                   bio.join(" "),
               remote_picture_url:    picture)               
end