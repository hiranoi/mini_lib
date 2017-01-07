class Article < ActiveRecord::Base
    belongs_to :user
	has_many :feelings

    validates :title, length: { maximum: 60 }
    validates :url, :title, presence: true
    validates :url, format: /\A#{URI::regexp(%w(http https))}\z/

     def self.get_url_info(article)

     	object = LinkThumbnailer.generate(article.url)

     	article.url_title = object.title
     	article.url_description = object.description
   		article.url_thumbnail = object.images.empty? ? nil : object.images.first.src.to_s

     	article
		 end

		def self.get_new_articles

			t = Time.now

			from = Time.local(t.year, t.month, t.day)
			to = Time.local(t.year, t.month, t.day + 1)

			articles = Article.where(:created_at => from..to)
		end
end
