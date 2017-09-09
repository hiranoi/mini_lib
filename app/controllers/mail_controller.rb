class MailController < ApplicationController

    protect_from_forgery except: :mail_action

	def create

		# check
		if params[:token] != ENV['SLACK_TOKEN_MAIL']
			render :json => {"text" => "Tokenチェックエラー"}
			return
		end

        articles = Article.get_new_articles_weekly

        if articles.empty?
          render :json => {"text" => "新しい記事はありません"}
          return
        end

		subject = '【JaQNews】新着お知らせメール便'

		to = ENV['MAIL_TO']
		from = ENV['MAIL_FROM']
		UserNotifier.new_arrival_mail(to,from,subject,articles).deliver

		success = {"text"=> "新着お知らせメールを送信しました"}		
		render :json => success
	end
end
