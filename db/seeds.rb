# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
COLORS = ["calico", "black", "white", "tuxedo", "leopard", "tabby"]

20.times do 
  Cat.create!(birth_date: Faker::Date.backward(5475), color: COLORS.sample, 
    name: Faker::Name.first_name, sex: ["M", "F"].sample, 
    description: Faker::Hacker.say_something_smart)
end

