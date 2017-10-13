class Article < ActiveRecord::Base
    belongs_to :user
    belongs_to :categories
	has_many :feelings
    has_many :article_views

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
		to = Time.local(t.year, t.month, t.day) + 24*60*60

		articles = Article.where(:created_at => from..to)
	end

    def self.get_new_articles_weekly

        t = Time.now

        from = Time.local(t.year, t.month, t.day) - 24*60*60*7
        to = Time.local(t.year, t.month, t.day) + 24*60*60

        articles = Article.where(:created_at => from..to).order('article_views_count DESC').limit(5)
    end

end
