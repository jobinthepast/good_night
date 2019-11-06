# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.destroy_all

10.times { User.create(name: FFaker::Name.name) }

5.times do
  user_id = User.ids.sample
  Following.create(user_id: user_id, following_id: (User.ids - [user_id]).sample)
end

7.times do |i|
  User.all.each do |user|
    start_time = i.days.ago.beginning_of_day - (rand(1..5).hours)
    length     = rand(5..10)
    end_time   = start_time + length.hours

    Sleep.create(user_id: user.id, start_time: start_time, end_time: end_time, length: length)
  end
end
