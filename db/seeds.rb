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

11.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  response = HTTParty.get('http://uifaces.com/api/v1/random')
  puts response
  hash = JSON.parse response.body
  picture = hash['image_urls']['epic']
  User.create!(first_name:            first_name,
               last_name:             last_name,
               email:                 "#{first_name}.#{last_name}#{n+1}@gmail.com",
               password:              "foobar",
               password_confirmation: "foobar",
               remote_picture_url: picture)               
end


require 'csv'

c = CSV.read("#{Rails.root}/Event_matrix.csv", {headers: true})
  c.each do |row|
    array = row.to_a
    occasion = array[0][1]
    event = Event.create!(dress_me_for: occasion)
    array.each do |item|
      not_nil = !item[1].nil?
      case item[0]
      when "And:"
        if not_nil
          event.options.create!(question_type: "And:", possible_response: item[1])
        end
      when "Also:"
        if not_nil
          event.options.create!(question_type: "Also:", possible_response: item[1])
        end
      when "With:"
        if not_nil
          event.options.create!(question_type: "With:", possible_response: item[1])
        end
      end
    end
  end
  events = Event.all
  events.each do |event|
    event.options.create!(question_type: "Anything else?", possible_response: "type in")
    event.options.create!(question_type: "Date:", possible_response: "-----")
  end

        



