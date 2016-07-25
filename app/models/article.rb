class Article < ActiveRecord::Base
    belongs_to :user
    validates :title, length: { maximum: 60 }
end
