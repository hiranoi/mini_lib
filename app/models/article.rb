class Article < ActiveRecord::Base
    belongs_to :user
    validates :title, length: { maximum: 60 }

     def self.get_url_info(article)

     	object = LinkThumbnailer.generate(article.url)

     	article.url_title = object.title
     	article.url_description = object.description
   		article.url_thumbnail = object.images.empty? ? nil : object.images.first.src.to_s

     	article
     end
end
