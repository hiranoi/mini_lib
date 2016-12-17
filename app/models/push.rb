class Push < ActiveRecord::Base

  def self.send_news(push_body)

    @push = Push.new
    @push.type = 'news'
    @push.title = '【JaQ News】新しい記事が追加されました'
    @push.text = push_body
    @push.save

    OpenSearchClient.new.send_push(@push.title, @push.text)
    @push
  end

end
