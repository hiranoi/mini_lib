class Push < ActiveRecord::Base

  def self.send_news
    @push = Push.new
    @push.type = 'news'
    @push.title = 'タイトル'
    @push.text = '本文'
    @push.save

    OpenSearchClient.new.send_push(@push.title, @push.text)
    @push
  end

end
