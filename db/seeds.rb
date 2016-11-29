# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(first_name: 'Rj', last_name: 'Bernaldo', sender_id: '950498005077644')
user.expenses.create(amount: '50', item: 'Burger', location: 'Super Duper', category: 'Food')
user.expenses.create(amount: '25', item: 'Milkshake', location: 'Super Duper', category: 'Food')
user.expenses.create(amount: '20', item: 'Taco', location: 'Tacolicious', category: 'Food')
