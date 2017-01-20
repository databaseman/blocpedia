# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "Minh",
             email: "nguyen_ba_minh@yahoo.com",
             password:              "password",
             password_confirmation: "password",
             confirmed_at: Time.zone.now,
             role: 'admin').skip_confirmation!

User.create!(name:  "MinhStandard",
             email: "mn_misc-000@yahoo.com",
             password:              "password",
             password_confirmation: "password",
             confirmed_at: Time.zone.now,
             role: 'standard').skip_confirmation!

User.create!(name:  "MinhPremium",
             email: "mn_misc-001@yahoo.com",
             password:              "password",
             password_confirmation: "password",
             confirmed_at: Time.zone.now,
             role: 'premium').skip_confirmation!

5.times do |n|
   name  = Faker::Name.name
   email = "standard-#{n+1}@railstutorial.org"
   password = "password"
   User.create!(name:  name,
                email: email,
                password:              password,
                password_confirmation: password,
                confirmed_at: Time.zone.now,
                role: 'standard' ).skip_confirmation!
end

5.times do |n|
   name  = Faker::Name.name
   email = "premium-#{n+1}@railstutorial.org"
   password = "password"
   User.create!(name:  name,
                email: email,
                password:              password,
                password_confirmation: password,
                confirmed_at: Time.zone.now,
                role: 'premium' ).skip_confirmation!
end

users=User.all

# Microposts
users = User.order(:created_at).take(6)
10.times do
  users.each { |user| user.posts.create!(title: Faker::Lorem.sentence(1), body: Faker::Lorem.sentence(5) ) }
end
posts=Post.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
