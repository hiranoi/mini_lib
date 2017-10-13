# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
# User.create!(email: 'admin@example.com', password: 'password', admin: true)

ArticleCategory.create!(name: 'ビジネス')
ArticleCategory.create!(name: 'IT')
ArticleCategory.create!(name: 'スポーツ')
ArticleCategory.create!(name: 'ライフハック')
ArticleCategory.create!(name: 'エンタメ')
ArticleCategory.create!(name: '社会')