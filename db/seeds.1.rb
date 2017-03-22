# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Post.delete_all
Collaborator.delete_all

# create standard users
6.times do |n|
   name  = Faker::Name.name
   email = "standard-#{n+1}@railstutorial.org"
   password = "password"
   User.create!(name:  name,
                email: email,
                password:              password,
                password_confirmation: password,
                confirmed_at: Time.zone.now,
                role: 'standard' )
end

# Create premium users
6.times do |n|
   name  = Faker::Name.name
   email = "premium-#{n+1}@railstutorial.org"
   password = "password"
   User.create!(name:  name,
                email: email,
                password:              password,
                password_confirmation: password,
                confirmed_at: Time.zone.now,
                role: 'premium' )
end

# Standard users Public Microposts
users = User.where( "role = 0").take(6)
4.times do
  users.each { |user| user.posts.create!(title: Faker::Lorem.sentence(1), body: Faker::Lorem.sentence(5) ) }
end

# Premium users Public Microposts
users = User.where( "role = 1").take(6)
4.times do
  users.each { |user| user.posts.create!(title: Faker::Lorem.sentence(1), body: Faker::Lorem.sentence(5) ) }
end

# Premium users Private Microposts
users = User.where( "role = 1").take(6)
4.times do
  users.each { |user| user.posts.create!(title: Faker::Lorem.sentence(1), body: Faker::Lorem.sentence(5), private: 1  ) }
end

# Standard users Collaborators.
#users = User.where( "role = 0").take(2)
#users.each do |user|
#  post=Post.where.not( user: user, private: 0).take(2)
#  post.each { |post| Collaborator.create!( user: user, post: post ) }
#end

# Premium users Collaborators.
#users = User.where( "role = 1").take(2)
#users.each do |user|
#  post=Post.where.not( user: user, private: 0).take(2)
#  post.each { |post| Collaborator.create!( user: user, post: post ) }
#end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Collaborator.count} collaborators created"