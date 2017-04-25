# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

userData = [
  ['John Doe', 'johndoe@email.com'],
  ['Jenny Nguyen', 'jenny643@gmail.com'],
  ['Jen Doe', 'jendoe@email.com'],
  ['Luke Dam', 'luke2233@email.com'],
  ['Ava O\' Brian', 'ava33221x@email.com'],
  ['Johnny Huynh', 'johnnyhuynhdev@gmail.com'],
]

userData.each do |name, email|
  User.create(name: name, email: email)
end

course = Course.create(name: 'Web Programming', prerequisite: 'Programming Techniques', description: 'The course introduces you to the basic concepts of the World Wide Web, and the principles and tools that are used to develop Web applications. The course will provide an overview of Internet technology and will introduce you to current Web protocols, client side and server side programming, communication and design.')
# course.roles << Category.create(name: "admin")
