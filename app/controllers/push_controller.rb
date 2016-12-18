class PushController < ApplicationController

  protect_from_forgery except: :push_action

  def create

    # token check
    if params[:token] != ENV['SLACK_TOKEN']
      render :json => {"text" => "Tokenチェックエラー"}
      return
    end

    # check sent push
    if !Push.sent_check("news").empty?
      render :json => {"text" => "Push通知は1日1回までです"}
      return
    end

    # get new articles
    articles = Article.get_new_articles

    if articles.empty?
      render :json => {"text" => "新しい記事はありません"}
      return
    end

    # create push body
    push_body = ""
    articles.each_with_index do |article, i|
      push_body += "・"
      push_body += article.title
      push_body += "\n"

      break if i == 2
    end

    # send push
    Push.send_news(push_body)

    render :json => {"text" => push_body}
  end

end