class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :book, :counter_cache => true
end
