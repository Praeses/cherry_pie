# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

a = Admin.new
a.email = 'admin@praeses.com'
a.password = 'asdf'
a.save(:validate => false)

u = User.new
u.email = 'user@localhost.com'
u.password = 'asdf'
u.first_name = 'Test'
u.last_name = 'User'
u.site_id = 1
u.save(:validate => false)

