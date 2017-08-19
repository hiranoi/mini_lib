class MailController < ApplicationController

    protect_from_forgery except: :mail_action

	def create

		# check
		if params[:token] != ENV['SLACK_TOKEN']
			render :json => {"text" => "Tokenチェックエラー"}
			return
		end

		# タイトル
		subject = '新着お知らせメール'

		to = ENV['MAIL_TO']
		from = ENV['MAIL_FROM']
		UserNotifier.new_arrival_mail(to,from,subject).deliver

		success = {"text"=> "新着お知らせメールを送信しました"}		
		render :json => success
	end

end
