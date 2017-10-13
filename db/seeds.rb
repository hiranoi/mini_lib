# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
# User.create!(email: 'admin@example.com', password: 'password', admin: true)

ArticleCategory.create!(code: '1', name: 'ビジネス')
ArticleCategory.create!(code: '2', name: 'IT')
ArticleCategory.create!(code: '3', name: 'スポーツ')
ArticleCategory.create!(code: '4', name: 'ライフハック')
ArticleCategory.create!(code: '5', name: 'エンタメ')
ArticleCategory.create!(code: '6', name: '社会')