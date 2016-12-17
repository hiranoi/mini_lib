class PushController < ApplicationController

  def create

    # get new articles
    articles = Article.get_new_articles

    push_body = ""
    articles.each do |article|
      push_body += "・"
      push_body += article.title
      push_body += "\n"
    end

    # send push
    Push.send_news(push_body)

    render :json => push_body
  end

end