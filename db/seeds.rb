# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
# User.create!(email: 'admin@example.com', password: 'password', admin: true)

Category.create!(name: 'ビジネス', theme: 'primary')
Category.create!(name: 'IT', theme: 'info')
Category.create!(name: 'スポーツ', theme: 'warning')
Category.create!(name: 'ライフハック', theme: 'success')
Category.create!(name: 'エンタメ', theme: 'danger')
Category.create!(name: '社会', theme: 'dark')