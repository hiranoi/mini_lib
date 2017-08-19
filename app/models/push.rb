class Push < ActiveRecord::Base

  def self.sent_check(type)

    t = Time.now

    from = Time.local(t.year, t.month, t.day)
    to = Time.local(t.year, t.month, t.day + 1)

    Push.where(:type => type, :created_at => from..to)
  end

  def self.send_news(push_body)

    push = Push.new
    push.type = 'news'
    push.title = '【JaQ News】新しい記事が追加されました'
    push.text = push_body

    OpenSearchClient.new.send_push(push.title, push.text)

    push.save
  end
end
