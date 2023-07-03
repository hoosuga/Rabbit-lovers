# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
category_names = %w(
    category_1
    category_2
    category_3
  )

categories = category_names.map do |name|
  Category.create!(name: name)
end

Admin.create!(email: "admin@test.com", password: "password")

#if Rails.env.development
  
(1..10).each do |n|
  user = User.create!(name: "user#{n}",
               email: "user#{n}@test.com",
               password: "password")
  if n == 10
  elsif n ==9
   room = user.rooms.create!(title: "test-private",
                       body: "text" * rand(5..10),
                       status: 2)
    categories.sample(rand(1..3)).each do |category|
      CategoryRoom.create!(room_id: room.id, category_id: category.id)
    end
  else
    (1..rand(1..2)).each do |nn|
      room = user.rooms.create!(title: "test#{n}-#{nn}",
                         body: "text" * rand(5..10))
      categories.sample(rand(1..3)).each do |category|
        CategoryRoom.create!(room_id: room.id, category_id: category.id)
      end
    end
  end
end

#end

#rooms = Room.all.sample(5)
#users = User.where(id: [1, 2, 3])
#users.each_with_index do |user, i|
#  user.likes.create!(room_id: rooms[i])
#end

rooms = Room.all.sample(5)

users = User.where(id: [1, 2, 3])
users.each_with_index do |user, i|
  user.comments.create!(room_id: rooms[i].id,
                        body: "comment" * rand(5..10))
end

users = User.where(id: [1, 3])
users.each_with_index do |user, i|
  user.likes.create!(room_id: rooms[i].id)
end