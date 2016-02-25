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

15.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  picture = Faker::Avatar.image("random-slug", "300x200").gsub('http://','https://')
  bio = Faker::Lorem.sentences
  User.create!(first_name:            first_name,
               last_name:             last_name,
               email:                 "#{first_name}.#{last_name}#{n+1}@gmail.com",
               password:              "foobar",
               password_confirmation: "foobar",
               bio:                   bio.join(" "),
               remote_picture_url:    picture)               
end

=begin

events_array = ["Wedding/gala","Date","Meeting the parents","Outdoor music festival","Concert","Work","Weekend wear","Going out","Picnic/BBQ","Pool/Beach party","Vacation","Hiking","Chuch/Synagogue","Bar/Bat mitzvah/Sweet 16/Quinceanera","Holiday party","Other"]
events_array.each do |event|
  Event.create!(dress_me_for: event)
end

options_array1 = ["It's black tie optional", "It's black tie","It's beach formal","It's semi-formal","It's casual","It's white tie"]
event = Event.find_by(dress_me_for: "Wedding/gala")
options_array1.each do |option|
  event.options.create!(question_type: "And:", possible_response: option)
end

options_array2 = ["She/he might be the one", "It's a blind date", "It's a first date", "Not sure how I feel", "I'm not that into him/her"]
event2 = Event.find_by(dress_me_for: "Date")
options_array2.each do |option|
  event2.options.create!(question_type: "And:", possible_response: option)
end

options_array3 = ["They're conservative", "They're laid back"]
event3 = Event.find_by(dress_me_for: "Meeting the parents")
options_array3.each do |option|
  event3.options.create!(question_type: "And:", possible_response: option)
end

options_array4 = ["It's one day","It's two days","It's 3 days"]
event4 = Event.find_by(dress_me_for: "Outdoor music festival")
options_array4.each do |option|
  event4.options.create!(question_type: "And:", possible_response: option)
end

options_array5 = ["It's rock",	"It's pop",	"It's electronic",	"It's country",	"It's jazz/blues",	"It's rap/hip-hop",	"It's indie",	"It's metal",	"It's soul/ r&b",	"It's reggae"]
event5 = Event.find_by(dress_me_for: "Concert")
options_array5.each do |option|
  event5.options.create!(question_type: "And:", possible_response: option)
end

options_array6 = ["It's business casual",	"It's business formal",	"It's casual",	"It's fashiony"]
event6 = Event.find_by(dress_me_for: "Work")
options_array6.each do |option|
  event6.options.create!(question_type: "And:", possible_response: option)
end

=end

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

        



